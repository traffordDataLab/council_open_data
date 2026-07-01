## Transparency Code - Local Authority Land ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/council-data-and-democracy/transparency-and-accountability/local-government-and-transparency-code/grants-and-assets
# Licence: Open Government Licence v3.0
# Created: 2026-07-01

# Load the necessary R packages
library(tidyverse)

# Read in the data to a tibble
df_raw <- read_csv("https://www.trafford.gov.uk/sites/default/files/2025-12/traffordlandandbuildingassets.csv")

# Tidy up the data
# - nothing required for this dataset
  
# Write out the cleaned data
write_csv(df_raw, "trafford_land_and_building_assets.csv", na = "")
