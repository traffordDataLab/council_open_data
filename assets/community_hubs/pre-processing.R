# Trafford Council Community Hubs #

# Source: Trafford Council
# URL: https://www.trafford.gov.uk/residents/community/Community-Response-Hubs.aspx
# Licence: OGL v3.0

library(tidyverse) ; library(sf)

# Read in the CSV created using the data on the source page
df <- read_csv("trafford_community_hubs.csv")

# Use the lon, lat variables to convert to a spatial dataset
sf <- df %>%
    st_as_sf(coords = c("lon", "lat"), crs = 4326)

st_write(sf, "trafford_community_hubs.geojson")
