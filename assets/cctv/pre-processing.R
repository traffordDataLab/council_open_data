## This dataset was initially created by the Trafford Data Lab using our Plotter app (https://www.trafforddatalab.io/plotter)
## The "RAW" file is now updated by the Trafford CCTV control room as and when there are changes, also using Plotter.
## The "RAW" file is **NOT** included in the repo due to it containing both the camera positions and their field of view.
## This purpose of this script is separate the camera positions from the views and clean up the output for publication as open data, in both GeoJSON and CSV format.
## Last code update: 2025-03-04


# Required libraries
library(tidyverse) ; library(sf)


# Read in Trafford's wards
sf_wards <- sf::st_read("https://www.trafforddatalab.io/spatial_data/ward/2023/trafford_ward_full_resolution.geojson")


# Load in the RAW file
sf_cctv_raw <- sf::st_read("trafford_cctv_RAW.geojson")

# ================ TEMPORARY SECTION: ONLY REQUIRED IF RENUMBERING THE CAMERAS IN THE SOURCE FILE =================
# Renumber instances of the cameras which are not in the 1xxx series
sf_cctv_raw <- sf_cctv_raw %>%
    mutate(camera_id = str_extract(featureAlias, "[0-9]+"),
           featureAlias = case_when(str_length(camera_id) == 1 ~ str_replace(featureAlias, "Cam ([0-9]{1}) ", "Cam 100\\1 "),
                                    str_length(camera_id) == 2 ~ str_replace(featureAlias, "Cam ([0-9]{2}) ", "Cam 10\\1 "),
                                    str_length(camera_id) == 3 ~ str_replace(featureAlias, "Cam ([0-9]{3}) ", "Cam 1\\1 "),
                                    TRUE ~ featureAlias)) %>%
    select(-camera_id)
# ==================================================================================================================


# Separate the cameras from the views based on the geometry type (cameras are POINT, the views are MULTIPOLYGON), and match to ward
sf_cctv <- sf_cctv_raw %>%
    dplyr::filter(st_geometry_type(geometry) == "POINT") %>%
    sf::st_join(sf_wards, join = st_within, left = FALSE) %>%
    dplyr::select(location = featureAlias, area_name, area_code)


# Separate the camera id from the location into a new variable.
# NOTE: we need to leave the id within the location variable for now as we need it later on to tidy up some of the location names
sf_cctv <- sf_cctv %>%
    # Normalise the camera ids so that each record starts with the camera id followed by a space
    dplyr::mutate(location = stringr::str_to_title(location),
                  location = stringr::str_replace(location, " - ", " "),
                  location = stringr::str_replace(location, "- ", " "),
                  location = stringr::str_replace(location, "Cam -", ""),
                  location = stringr::str_replace(location, "Cam-", ""),
                  location = stringr::str_replace(location, "Cam ", ""),
                  location = stringr::str_replace(location, "Camera ", ""),
                  camera_id = as.numeric(str_extract(location, "[0-9]+"))) %>%
    dplyr::arrange(camera_id) %>%
    dplyr::select(camera_id, everything())
    

# Tidy up general aspects of the location names e.g. "rd" -> "road", "st" -> "street" etc. (multiple instances)
sf_cctv <- sf_cctv %>%
    dplyr::mutate(location = stringr::str_squish(location), # start by removing any whitespace at the beginning, end and replace multiple whitespaces internally with a single space
                  location = stringr::str_replace_all(location, " Rd", " Road"),
                  location = stringr::str_replace_all(location, " St/", " Street/"),
                  location = stringr::str_replace_all(location, " St$", " Street"),
                  location = stringr::str_replace_all(location, " Ave$| Av$", " Avenue"),
                  location = stringr::str_replace(location, "Magnolia ([A-Za-z]+)", "Magnolia Court (Rooftop \\1)"),
                  location = stringr::str_replace(location, "Sale Water Park Ptz ([1-4])", "Sale Water Park (PTZ \\1)"),
                  location = stringr::str_replace_all(location, c("Sale Water Park Fixed 5 Internal"="Sale Water Park (Static 1)", "Sale Water Park Fixed 6 Internal"="Sale Water Park (Static 2)", "Sale Water Park Fixed 7 Internal"="Sale Water Park (Static 3)", "Sale Water Park Fixed 8 Internal"="Sale Water Park (Static 4)")),
                  location = stringr::str_replace(location, "Road-([A-Za-z0-9\\s]+)", "Road (\\1)"),
                  location = stringr::str_replace(location, " Shops", " (Shops)"),
                  location = stringr::str_replace(location, " Junction Of | Junction ", "/"),
                  location = stringr::str_replace(location, "Round About", "Roundabout"))


# Tidy up specific aspects of individual locations (requires the camera id otherwise there is a risk to accidentally alter other location names)
sf_cctv <- sf_cctv %>%
    dplyr::mutate(location = dplyr::case_when(location == "1003 Wharside Way/Sir Matt Busby Way" ~ "1003 Wharfside Way/Sir Matt Busby Way",
                                              location == "1005 Chester Road" ~ "1005 Chester Road (White City)",
                                              location == "1007 Warwick Road" ~ "1007 Warwick Road (Town Hall)",
                                              location == "1008 Chester Road" ~ "1008 Chester Road (Tesco)",
                                              location == "1009 The Quadrant" ~ "1009 The Quadrant, Old Trafford",
                                              location == "1018 Seven Ways Roundabout" ~ "1018 Sevenways Roundabout (Church Side)",
                                              location == "1019 Seven Ways Roundabout" ~ "1019 Sevenways Roundabout (Petrol Station Side)",
                                              location == "1025 Subway 1" ~ "1025 Chester Road/Kingsway (Subway)",
                                              location == "1026 Subway 2" ~ "1026 Chester Road/Edge Lane (Subway)",
                                              location == "1027 Kingsway Stretford" ~ "1027 Kingsway, Stretford",
                                              location == "1028 Kingsway Near Barton Road Junction" ~ "1028 Kingsway/Barton Road, Stretford",
                                              location == "1036 Shrewsbury Street" ~ "1036 Shrewsbury Street/Ayres Road",
                                              location == "1038 Powell Street" ~ "1038 Powell Street/Ayres Road",
                                              location == "1039 St Johns Road" ~ "1039 St John's Road/Ayres Road",
                                              location == "1040 Ayres Road" ~ "1040 Ayres Road/Northumberland Road",
                                              location == "1042 Stretford Road" ~ "1042 Stretford Road/East Union Street",
                                              location == "1044 Stretford House Roof" ~ "1044 Stretford House (Rooftop)",
                                              location == "1050 Radnor Street Stretford" ~ "1050 Radnor Street, Stretford",
                                              location == "1060 Health Centre" ~ "1060 Plymouth Road/Bodmin Road (Health Centre)",
                                              location == "1064 Firsway/Goodwood Avenue" ~ "1064 Firs Way/Goodwood Avenue",
                                              location == "1069 Chepstow/Epsom Avenue" ~ "1069 Chepstow Avenue/Epsom Avenue",
                                              location == "1072 Manor Avenue" ~ "1072 Manor Avenue/Coppice Avenue",
                                              location == "1081 Regent/George Street" ~ "1081 Regent Road/George Street",
                                              location == "1082 The Causeway Altrincham" ~ "1082 The Causeway, Altrincham",
                                              location == "1083 Travel Lodge Roof Altrincham" ~ "1083 Travelodge (Rooftop), Altrincham",
                                              location == "1085 Cresta Court./Woodlands Road/Church Street" ~ "1085 Woodlands Road/Church Street (Cresta Court)",
                                              location == "1150 Barton Dock Road" ~ "1150 Trafford Centre Metrolink Terminus, Barton Dock Road",
                                              location == "1152 Nags Head Roundabout" ~ "1152 Barton Road/Davyhulme Circle (The Nags Head)",
                                              location == "1154 Flixton Road(Railway Station)" ~ "1154 Flixton Road (Railway Station)",
                                              location == "1171 Moss Lane" ~ "1171 Moss Lane, Partington",
                                              location == "1181 Millbank House" ~ "1181 Millbank House, Wood Lane",
                                              location == "1184 Lock Lane/Conniston" ~ "1184 Lock Lane/Conniston Road",
                                              location == "1185 Millenium Clock" ~ "1185 Manchester New Road/Manchester Road (Millenium Clock)",
                                              location == "1188 Car Park Rear Of Co-Op" ~ "1188 Central Road (Car Park rear of Co-Op)",
                                              location == "1271chester Road/Greatstone Road" ~ "1271 Chester Road/Great Stone Road",
                                              location == "1272 Moss Road Stretford" ~ "1272 Moss Road/Derbyshire Lane",
                                              location == "1273 Sale Waterside Roof Top Caamera" ~ "1273 Sale Waterside (Rooftop)",
                                              location == "1274 Broad Road Sale" ~ "1274 Broad Road, Sale",
                                              location == "1275 Sale Waterwide" ~ "1275 Sale Waterside",
                                              location == "1277 Kings Ransom Sale" ~ "1277 Kings Ransom, Sale",
                                              location == "1280 Norton Street-Old Trafford" ~ "1280 Norton Street, Old Trafford",
                                              location == "1283 Moss Road" ~ "1283 Moss Road/Grasmere Road",
                                              location == "1285 Cantral Way Static" ~ "1285 Central Way, Altrincham",
                                              location == "1295 Mainswood Road" ~ "1295 Mainwood Road",
                                              location == "1296 Goose Green/Cinema" ~ "1296 Denmark Street/Goose Green (Cinema)",
                                              location == "1297 Altrincham Taxi Rank" ~ "1297 Stamford New Road/Altrincham Interchange (Taxi Rank)",
                                              location == "1301 Ashley Road Hale" ~ "1301 Ashley Road/Brown Street, Hale",
                                              location == "1302 Ashley Road/Victoria Road" ~ "1302 Ashley Road/Victoria Road, Hale",
                                              location == "1303 Ashley Road Hale" ~ "1303 Ashley Road, Hale (Shops)",
                                              location == "1310 Sibson House Front Left" ~ "1310 Sibson House (Front Left)",
                                              location == "1311 Sibson House Front Right" ~ "1311 Sibson House (Front Right)",
                                              TRUE ~ location))


# Delete the old GeoJSON file first!
file.remove("trafford_cctv_cameras.geojson")

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
