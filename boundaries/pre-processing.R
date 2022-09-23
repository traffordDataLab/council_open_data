# Administrative, electoral and statistical boundaries #
# Generalised resolution (20m)

library(tidyverse) ; library(sf)

# Local authority district -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/ons::local-authority-districts-december-2021-gb-bgc/about
# Licence: OGL v3.0
# NOTE: we need the LA boundary stored in order to do an intersection calculation later for Westminster Parliamentary Constituencies
la <- st_read("https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Local_Authority_Districts_December_2021_GB_BGC/FeatureServer/0/query?outFields=lad21cd,lad21nm&where=UPPER(lad21cd)%20like%20%27%25E08000009%25%27&f=geojson") %>% 
  select(area_code = LAD21CD, area_name = LAD21NM) 

st_write(la, "local_authority_district.geojson")

# Electoral wards -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/wards-december-2018-generalised-clipped-boundaries-uk
# Licence: OGL v3.0
st_read("https://ons-inspire.esriuk.com/arcgis/rest/services/Administrative_Boundaries/Wards_December_2018_Boundaries_V3/MapServer/2/query?where=wd18cd%20IN%20('E05000819',%20'E05000820',%20'E05000821',%20'E05000822',%20'E05000823',%20'E05000824',%20'E05000825',%20'E05000826',%20'E05000827',%20'E05000828',%20'E05000829',%20'E05000830',%20'E05000831',%20'E05000832',%20'E05000833',%20'E05000834',%20'E05000835',%20'E05000836',%20'E05000837',%20'E05000838',%20'E05000839')&outFields=wd18cd,wd18nm&outSR=4326&f=geojson") %>% 
  select(area_code = wd18cd, area_name = wd18nm) %>% 
  st_write("electoral_ward.geojson")

# Westminster Parliamentary Constituencies -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/westminster-parliamentary-constituencies-december-2018-uk-bgc
# Licence: OGL v3.0
st_read("https://ons-inspire.esriuk.com/arcgis/rest/services/Electoral_Boundaries/Westminster_Parliamentary_Constituencies_December_2018_UK_BGC/MapServer/0/query?where=1%3D1&outFields=pcon18cd,pcon18nm&geometry=-2.478454%2C53.357425%2C-2.253022%2C53.480363&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelIntersects&outSR=4326&f=geojson") %>% 
  st_intersection(la) %>% 
  select(area_code = pcon18cd, area_name = pcon18nm) %>% 
  filter(area_name %in% c("Altrincham and Sale West", "Stretford and Urmston", "Wythenshawe and Sale East")) %>% 
  st_write("westminster_parliamentary_constituency.geojson")

# Parishes -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/parishes-december-2018-generalised-clipped-boundaries-ew
# Licence: OGL v3.0
st_read("https://ons-inspire.esriuk.com/arcgis/rest/services/Administrative_Boundaries/Parishes_December_2018_Boundaries_EW/MapServer/2/query?where=UPPER(lad18cd)%20like%20'%25E08000009%25'&outFields=par18cd,par18nm&outSR=4326&f=geojson") %>% 
  select(area_code = par18cd, area_name = par18nm) %>% 
  st_write("parish.geojson")

# Middle layer Super Output Areas (2021) -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/ons::middle-layer-super-output-areas-december-2021-boundaries-generalised-clipped-ew-bgc/about
# Licence: OGL v3.0
st_read("https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Middle_layer_Super_Output_Areas_December_2021_EW_BGC/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson") %>%
  select(area_code = MSOA21CD, area_name = MSOA21NM) %>% 
  st_as_sf(crs = 4326, coords = c("long", "lat")) %>%
  filter(grepl('Trafford', area_name)) %>%
  st_write("msoa.geojson")

# Lower layer Super Output Areas (2021) -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/ons::lower-layer-super-output-areas-december-2021-boundaries-generalised-clipped-ew-bgc/about
# Licence: OGL v3.0
st_read("https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Lower_layer_Super_Output_Areas_Decemeber_2021_EW_BGC/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson") %>%
  select(area_code = LSOA21CD, area_name = LSOA21NM) %>% 
  st_as_sf(crs = 4326, coords = c("long", "lat")) %>%
  filter(grepl('Trafford', area_name)) %>%
  st_write("lsoa.geojson")

# Output Areas (2021) -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/ons::output-areas-december-2021-boundaries-generalised-clipped-ew-bgc/about
# Licence: OGL v3.0

# Load statistical lookup CSV to match the OA area codes to Local Authorities so that we can isolate the OAs for Trafford
# Source: https://geoportal.statistics.gov.uk/datasets/output-area-to-lower-layer-super-output-area-to-middle-layer-super-output-area-to-local-authority-district-december-2021-lookup-in-england-and-wales-v2/about
df_lookup <- read_csv("https://www.arcgis.com/sharing/rest/content/items/9f0bc2c6fbc9427ba11db01759e5f6d8/data") %>%
  select(area_code = oa21cd, la_code = lad22cd, la_name = lad22nm)

st_read("https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Output_Areas_December_2021_Boundaries_EW_BGC/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson") %>%
  select(area_code = OA21CD) %>% 
  st_as_sf(crs = 4326, coords = c("long", "lat")) %>%
  left_join(df_lookup) %>%
  filter(la_code == "E08000009") %>%
  st_write("oa.geojson")

# Localities -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/wards-december-2018-generalised-clipped-boundaries-uk
# Licence: OGL v3.0
st_read("https://ons-inspire.esriuk.com/arcgis/rest/services/Administrative_Boundaries/Wards_December_2018_Boundaries_V3/MapServer/2/query?where=wd18cd%20IN%20('E05000819',%20'E05000820',%20'E05000821',%20'E05000822',%20'E05000823',%20'E05000824',%20'E05000825',%20'E05000826',%20'E05000827',%20'E05000828',%20'E05000829',%20'E05000830',%20'E05000831',%20'E05000832',%20'E05000833',%20'E05000834',%20'E05000835',%20'E05000836',%20'E05000837',%20'E05000838',%20'E05000839')&outFields=wd18cd,wd18nm&outSR=4326&f=geojson") %>% 
  select(area_code = wd18cd, area_name = wd18nm) %>% 
  mutate(area_name = 
           case_when(
             area_name %in% c("Ashton upon Mersey", "Brooklands", "Priory", "St Mary\'s", "Sale Moor") ~ "Central",
             area_name %in% c("Clifford", "Gorse Hill", "Longford", "Stretford") ~ "North",
             area_name %in% c("Altrincham", "Bowdon", "Broadheath", "Hale Barns", "Hale Central", "Timperley", "Village") ~ "South",
             area_name %in% c("Bucklow-St Martins", "Davyhulme East", "Davyhulme West", "Flixton", "Urmston") ~ "West")) %>% 
  group_by(area_name) %>% 
  summarise() %>% 
  st_write("localities.geojson")
