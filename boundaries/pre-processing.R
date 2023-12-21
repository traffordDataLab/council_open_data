# Administrative, electoral and statistical boundaries for Trafford #
# Latest versions of generalised resolution (20m) as at 2023-07-28

# NOTES:
# These boundaries are obtained from ONS Open Geography Portal using the API service: https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/{BOUNDARY TYPE}/FeatureServer/0/query?{API PARAMETERS}
# The default API call shown on each dataset page returns features for the whole county, therefore it's best to use some extra parameters, such as defining a rectangle (spatial envelope) around the LA, to reduce the amount of data being returned and speed up the process.
# Local Authority (LA) boundaries can be obtained using the area code or name, e.g. E08000009 or "Trafford".
# For boundaries within an LA that don't contain the LA's area code or name you can use the st_intersection() function to obtain the features that intersect with the LA's boundary, or use a lookup.
# To get the spatial rectangle coordinates around the area you require, and the other API properties, simply zoom into the interactive map shown on the ONS Geoportal page for the boundary data you require, then select "I want to use this" and expand the "View API resources" box.
# All methods described above are demonstrated within this script.


# Required packages ---------
library(tidyverse) ; library(sf)

# =========
# VERY IMPORTANT NOTE REGARDING SF PACKAGE AND COORDINATE WINDING ORDER 2023-12-21:
# The IETF standard for GeoJSON has made certain changes over the original non-IETF specification.  The changes can be viewed here: https://datatracker.ietf.org/doc/html/rfc7946#appendix-B
# One key change is that polygon rings MUST follow the right-hand rule for orientation (counter-clockwise external rings, clockwise internal rings).
# This change has caused issues with certain libraries which have historically used the left-hand rule, i.e. clockwise for outer rings and counter-clockwise for interior rings.
# D3-Geo, Vega-Lite and versions of sf below 1.0.0 (default behaviour) use the GEOS library for performing flat-space calculations, known as R^2 (R-squared) which produce polygons wound to the left-hand rule.
# The sf package from version 1.0.0 onwards now uses the S2 library by default which performs S^2 (S-squared) spherical calculations and returns polygons wound according to the right-hand rule.
# At the time of writing, if we want our geography files to work in D3 and Vega-Lite, they must use the left-hand rule and so we need sf to use the GEOS library not S2.
# More information regarding this can be found at: https://r-spatial.github.io/sf/articles/sf7.html#switching-between-s2-and-geos
# =========
sf_vers <- package_version(packageVersion('sf')) # packageVersion returns a character string, package_version converts that into numeric version numbers (major.minor.patch) e.g. 1.0.0

# Only run the following if we are using sf version 1.0.0 or above
if (sf_vers$major >= 1) {
    useS2 <- sf_use_s2()    # store boolean to indicating if sf is currently using the s2 spherical geometry package for geographical coordinate operations
    sf_use_s2(FALSE)        # force sf to use R^2 flat space calculations using GEOS which returns polygons with left-hand windings
}


# API parameters specifying the spatial rectangular area containing Trafford
api_geommetry_envelope <- "&geometryType=esriGeometryEnvelope&geometry=%7B%22spatialReference%22%3A%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D%2C%22xmin%22%3A-278455.35481123265%2C%22ymin%22%3A7047642.057770884%2C%22xmax%22%3A-244823.0623658004%2C%22ymax%22%3A7073592.428873666%2C%22type%22%3A%22esriGeometryEnvelope%22%7D"


# Local authority district -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/ons::local-authority-districts-may-2023-boundaries-uk-bgc/about
# Licence: OGL v3.0
# NOTE: we need the LA boundary stored as an sf object for use in st_intersection() calculations for other boundaries
la <- st_read("https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Local_Authority_Districts_May_2023_UK_BGC_V2/FeatureServer/0/query?outFields=*&where=UPPER(lad23cd)%20like%20%27%25E08000009%25%27&f=geojson") %>%
  select(area_code = LAD23CD, area_name = LAD23NM) %>%
  st_write("local_authority_district.geojson")


# Westminster Parliamentary Constituencies -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/ons::westminster-parliamentary-constituencies-december-2022-uk-bgc/about
# Licence: OGL v3.0
st_read(paste0("https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Westminster_Parliamentary_Constituencies_Dec_2022_UK_BGC/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson", api_geommetry_envelope)) %>% 
  st_intersection(la) %>% 
  select(area_code = PCON22CD, area_name = PCON22NM) %>% 
  # we need to filter further as some features returned are not applicable
  filter(area_name %in% c("Altrincham and Sale West", "Stretford and Urmston", "Wythenshawe and Sale East")) %>% 
  st_write("westminster_parliamentary_constituency.geojson")


# Electoral wards -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/ons::wards-may-2023-boundaries-uk-bgc/about
# Licence: OGL v3.0
wards <- st_read(paste0("https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/WD_MAY_2023_UK_BGC/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson", api_geommetry_envelope)) %>% 
  filter(LAD23NM == "Trafford") %>%
  select(area_code = WD23CD, area_name = WD23NM) %>%
  st_write("electoral_ward.geojson")


# Localities -------------------------
# These are a Trafford council-defined construct based on groupings of electoral wards
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/ons::wards-may-2023-boundaries-uk-bgc/about
# Licence: OGL v3.0
localities <- wards %>%
  mutate(area_name = 
           case_when(
               area_name %in% c("Ashton upon Mersey", "Brooklands", "Manor", "Sale Central", "Sale Moor") ~ "Central",
               area_name %in% c("Gorse Hill & Cornbrook", "Longford", "Lostock & Barton", "Old Trafford", "Stretford & Humphrey Park") ~ "North",
               area_name %in% c("Altrincham", "Bowdon", "Broadheath", "Hale", "Hale Barns & Timperley South", "Timperley Central", "Timperley North") ~ "South",
               area_name %in% c("Bucklow-St Martins", "Davyhulme", "Flixton", "Urmston") ~ "West")) %>% 
  group_by(area_name) %>% 
  summarise() %>% 
  st_write("localities.geojson")


# Parishes -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/ons::parishes-may-2023-boundaries-ew-bgc-2/about
# Licence: OGL v3.0
st_read(paste0("https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Parishes_May_2023_Boundaries_EW_BGC/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson", api_geommetry_envelope)) %>% 
  st_intersection(la) %>%
  select(area_code = PAR23CD, area_name = PAR23NM) %>%
  # we need to filter further as some features returned are not applicable
  filter(area_name %in% c("Carrington", "Dunham Massey", "Partington", "Warburton")) %>% 
  st_write("parish.geojson")


# Middle layer Super Output Areas (2021) -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/ons::middle-layer-super-output-areas-december-2021-boundaries-generalised-clipped-ew-bgc/about
# Licence: OGL v3.0
st_read(paste0("https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Middle_layer_Super_Output_Areas_December_2021_EW_BGC/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson", api_geommetry_envelope)) %>%
  select(area_code = MSOA21CD, area_name = MSOA21NM) %>% 
  st_as_sf(crs = 4326, coords = c("long", "lat")) %>%
  filter(grepl('Trafford', area_name)) %>%  # Don't need to do an intersection operation as the area names contain the LA name
  st_write("msoa.geojson")


# Lower layer Super Output Areas (2021) -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/ons::lower-layer-super-output-areas-december-2021-boundaries-generalised-clipped-ew-bgc/about
# Licence: OGL v3.0
st_read(paste0("https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Lower_layer_Super_Output_Areas_Decemeber_2021_EW_BGC/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson", api_geommetry_envelope)) %>%
  select(area_code = LSOA21CD, area_name = LSOA21NM) %>% 
  st_as_sf(crs = 4326, coords = c("long", "lat")) %>%
  filter(grepl('Trafford', area_name)) %>%  # Don't need to do an intersection operation as the area names contain the LA name
  st_write("lsoa.geojson")


# Output Areas (2021) -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/ons::output-areas-december-2021-boundaries-generalised-clipped-ew-bgc/about
# Licence: OGL v3.0

# Load statistical lookup CSV to match the OA area codes to Local Authorities so that we can isolate the OAs for Trafford
# Unfortunately can't use LA intersection as we get a shared vertices error
# Source: https://geoportal.statistics.gov.uk/datasets/output-area-to-lower-layer-super-output-area-to-middle-layer-super-output-area-to-local-authority-district-december-2021-lookup-in-england-and-wales-v2/about
df_lookup <- read_csv("https://www.arcgis.com/sharing/rest/content/items/9f0bc2c6fbc9427ba11db01759e5f6d8/data") %>%
  select(area_code = oa21cd, la_code = lad22cd, la_name = lad22nm)

st_read(paste0("https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Output_Areas_December_2021_Boundaries_EW_BGC/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson", api_geommetry_envelope)) %>%
  rename(area_code = OA21CD) %>% 
  st_as_sf(crs = 4326, coords = c("long", "lat")) %>%
  left_join(df_lookup) %>%
  filter(la_code == "E08000009") %>%
  select(area_code) %>%
  st_write("oa.geojson")


# Ensure sf_use_s2() is reset to the state it was in before running the code above, i.e. whether to use the S2 library (for S^2 spherical coordinates) or GEOS (for R^2 flat space coordinates). Only if using v1 or above of the sf package
if (sf_vers$major >= 1) sf_use_s2(useS2)
