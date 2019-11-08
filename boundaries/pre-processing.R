# Administrative and statistical boundaries #

library(tidyverse) ; library(sf) ; library(jsonlite)

# Local authority district -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/local-authority-districts-april-2019-boundaries-uk-bgc
# Licence: https://www.ons.gov.uk/methodology/geography/licences
st_read("https://ons-inspire.esriuk.com/arcgis/rest/services/Administrative_Boundaries/Local_Authority_Districts_April_2019_Boundaries_UK_BGC/MapServer/0/query?where=UPPER(lad19cd)%20like%20'%25E08000009%25'&outFields=lad19cd,lad19nm&outSR=4326&f=geojson") %>% 
  select(area_code = lad19cd, area_name = lad19nm) %>% 
  st_write("local_authority_district.geojson")

# Electoral wards -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/wards-december-2018-generalised-clipped-boundaries-uk
# Licence: https://www.ons.gov.uk/methodology/geography/licences
st_read("https://ons-inspire.esriuk.com/arcgis/rest/services/Administrative_Boundaries/Wards_December_2018_Boundaries_V3/MapServer/2/query?where=wd18cd%20IN%20('E05000819',%20'E05000820',%20'E05000821',%20'E05000822',%20'E05000823',%20'E05000824',%20'E05000825',%20'E05000826',%20'E05000827',%20'E05000828',%20'E05000829',%20'E05000830',%20'E05000831',%20'E05000832',%20'E05000833',%20'E05000834',%20'E05000835',%20'E05000836',%20'E05000837',%20'E05000838',%20'E05000839')&outFields=wd18cd,wd18nm&outSR=4326&f=geojson") %>% 
  select(area_code = wd18cd, area_name = wd18nm) %>% 
  st_write("electoral_ward.geojson")

# Middle Super Output Areas -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/middle-layer-super-output-areas-december-2011-boundaries-bgc
# Licence: https://www.ons.gov.uk/methodology/geography/licences
st_read("https://ons-inspire.esriuk.com/arcgis/rest/services/Census_Boundaries/Middle_Super_Output_Areas_December_2011_Boundaries/MapServer/2/query?where=msoa11cd%20IN%20('E02001283',%20'E02001277',%20'E02001282',%20'E02001281',%20'E02001278',%20'E02001279',%20'E02001272',%20'E02001273',%20'E02001276',%20'E02001285',%20'E02001284',%20'E02001275',%20'E02001259',%20'E02001262',%20'E02001260',%20'E02001268',%20'E02001274',%20'E02001286',%20'E02001266',%20'E02001265',%20'E02001270',%20'E02001264',%20'E02001271',%20'E02001263',%20'E02001269',%20'E02001261',%20'E02001280',%20'E02001267')&outFields=msoa11cd,msoa11nm&outSR=4326&f=geojson") %>% 
  select(area_code = msoa11cd, area_name = msoa11nm) %>% 
  st_write("msoa.geojson")

# Lower-layer Super Output Areas -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/lower-layer-super-output-areas-december-2011-generalised-clipped-boundaries-in-england-and-wales
# Licence: https://www.ons.gov.uk/methodology/geography/licences
st_read("https://ons-inspire.esriuk.com/arcgis/rest/services/Census_Boundaries/Lower_Super_Output_Areas_December_2011_Boundaries/MapServer/2/query?where=UPPER(lsoa11nm)%20like%20'%25TRAFFORD%25'&outFields=lsoa11cd,lsoa11nm&outSR=4326&f=geojson") %>% 
  select(area_code = lsoa11cd, area_name = lsoa11nm) %>% 
    st_write("lsoa.geojson")

# Output Areas -------------------------
# Source: ONS Open Geography Portal
# URL: https://geoportal.statistics.gov.uk/datasets/output-area-december-2011-generalised-clipped-boundaries-in-england-and-wales
# Licence: https://www.ons.gov.uk/methodology/geography/licences
st_read("https://ons-inspire.esriuk.com/arcgis/rest/services/Census_Boundaries/Output_Area_December_2011_Boundaries/MapServer/2/query?where=UPPER(lad11cd)%20like%20'%25E08000009%25'&outFields=oa11cd&outSR=4326&f=json") %>% 
  select(area_code = oa11cd) %>% 
  st_write("oa.geojson")
