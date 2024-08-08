## Transparency Code - Parking Spaces ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/about-your-council/open-data/docs/trafford-off-street-parking-spaces.csv
#                https://www.trafford.gov.uk/about-your-council/open-data/docs/trafford-on-street-parking-spaces.csv
# Licence: Open Government Licence v3.0

# Load the necessary R packages
library(tidyverse)

# Read in the data to separate tibbles
df_off_street_raw <- read_csv("https://www.trafford.gov.uk/about-your-council/open-data/docs/trafford-off-street-parking-spaces.csv")
df_on_street_raw <- read_csv("https://www.trafford.gov.uk/about-your-council/open-data/docs/trafford-on-street-parking-spaces.csv")

# Tidy up the data
# - nothing required for these datasets

# Write out the cleaned data
write_csv(df_off_street_raw, "off_street_parking_spaces.csv")
write_csv(df_on_street_raw, "on_street_parking_spaces.csv")
