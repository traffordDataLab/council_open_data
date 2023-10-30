## This dataset was initially created by the Trafford Data Lab using our Plotter app (https://www.trafforddatalab.io/plotter)
## The "RAW" file is now updated by the Trafford CCTV control room as and when there are changes, also using Plotter.
## The "RAW" file is **NOT** included in the repo due to it containing both the camera positions and their field of view.
## This purpose of this script is separate the camera positions from the views and clean up the output for publication as open data, in both GeoJSON and CSV format.

# Required libraries
library(tidyverse) ; library(sf)


# Read in Trafford's wards
sf_wards <- sf::st_read("https://www.trafforddatalab.io/spatial_data/ward/2023/trafford_ward_full_resolution.geojson")


# Read in the source GeoJSON, separate the cameras from the views based on the geometry type (cameras are POINT, the views are MULTIPOLYGON), and match to ward
sf_cctv <- sf::st_read("trafford_cctv_RAW.geojson") %>%
    dplyr::filter(st_geometry_type(geometry) == "POINT") %>%
    sf::st_join(sf_wards, join = st_within, left = FALSE) %>%
    dplyr::select(location = featureAlias, area_name, area_code)


# Separate the camera id from the location into a new variable.
# NOTE: we need to leave the id within the location variable for now as we need it later on to tidy up some of the location names
sf_cctv <- sf_cctv %>%
    # Normalise the camera ids so that each record starts with the camera id followed by a space
    dplyr::mutate(location = str_to_title(location),
                  location = str_replace(location, " - ", " "),
                  location = str_replace(location, "Cam ", ""),
                  camera_id = str_extract(location, "[0-9]+")) %>%
    dplyr::select(camera_id, everything())
    

# Tidy up general aspects of the location names e.g. "rd" -> "road", "st" -> "street" etc. (multiple instances)
sf_cctv <- sf_cctv %>%
    dplyr::mutate(location = str_replace_all(location, " Rd", " Road"),
                  location = str_replace_all(location, " St/", " Street/"),
                  location = str_replace_all(location, " St$", " Street"),
                  location = str_replace_all(location, " Ave$", " Avenue"),
                  location = str_replace_all(location, " Av$", " Avenue"),
                  location = str_replace(location, "Magnolia ([North,South])", "Magnolia Court - \\1\\"),
                  location = str_replace(location, " Ptz", ""),
                  location = str_replace(location, "Fixed ([0-9]) Internal", "\\1 - Internal"),
                  location = str_replace(location, "Subway ([0-9])", "Chester Road, Stretford - Subway \\1"),
                  location = str_replace(location, "Road-", "Road - "),
                  location = str_replace(location, " Shops", " - Shops"),
                  location = str_replace(location, " Junction ", "/"))


# Tidy up specific aspects of individual locations (requires the camera id otherwise there is a risk to accidentally alter other location names)
sf_cctv <- sf_cctv %>%
    dplyr::mutate(location = case_when(location == "9 The Quadrant" ~ "9 The Quadrant, Old Trafford",
                                       location == "39 St Johns Road" ~ "39 St John's Road",
                                       location == "60 Health Centre" ~ "60 Plymouth Road/Bodmin Road - Health Centre",
                                       location == "64 Firsway/Goodwood Avenue" ~ "64 Firs Way/Goodwood Avenue",
                                       location == "69 Chepstow/Epsom Avenue" ~ "69 Chepstow Avenue/Epsom Avenue",
                                       location == "81 Regent/George Street" ~ "81 Regent Road/George Street",
                                       location == "154 Flixton Road(Railway Station)" ~ "154 Flixton Road - Railway Station",
                                       location == "171 Moss Lane" ~ "171 Moss Lane, Partington",
                                       location == "184 Lock Lane/Conniston" ~ "184 Lock Lane/Conniston Road",
                                       location == "185 Millenium Clock" ~ "185 Millenium Clock, Partington",
                                       location == "188 Car Park Rear Of Co-Op" ~ "188 Car Park - Rear Of Co-Op, Partington",
                                       location == "277 Kings Ransom Sale" ~ "277 Kings Ransom, Sale",
                                       location == "280 Norton Street-Old Trafford" ~ "280 Norton Street, Old Trafford",
                                       location == "1003 Wharside Way/Sir Matt Busby Way " ~ "1003 Wharfside Way/Sir Matt Busby Way ",
                                       location == "1005 Chester Road" ~ "1005 Chester Road, Old Trafford",
                                       location == "1301 Ashley Road Hale" ~ "1301 Ashley Road/Hale View, Hale",
                                       location == "1302 Ashley Road /Victoria Road" ~ "1302 Ashley Road/Victoria Road, Hale",
                                       location == "1303 Ashley Road Hale" ~ "1303 Ashley Road, Hale",
                                       TRUE ~ location))


# Remove the camera id from the location and save the cleaned GeoJSON
sf_cctv <- sf_cctv %>%
    dplyr::mutate(location = str_replace(location, "[0-9]+\\s", "")) %>%
    sf::st_write("trafford_cctv_cameras.geojson")    


# Create the CSV output by extracting the coordinates from the geometry as variables and then removing the geometry
df_csv <- sf_cctv %>%
    dplyr::bind_cols(sf::st_coordinates(sf_cctv) %>%
                     tibble::as_tibble() %>%
                     dplyr::select(X, Y) %>%
                     dplyr::rename(lon = X, lat = Y)
                    ) %>%
    sf::st_set_geometry(NULL) %>%
    readr::write_csv("trafford_cctv_cameras.csv")


# Remove the camera positions and fields of view RAW file - **THIS MUST NOT BE COMMITTED TO THE REPO**
file.remove("trafford_cctv_RAW.geojson")
