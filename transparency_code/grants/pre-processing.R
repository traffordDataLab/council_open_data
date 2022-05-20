## Transparency Code - Grants to voluntary, community and social enterprise organisations.  ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/about-your-council/open-data/docs/trafford-council-voluntary-sector-grants.csv
# Licence: Open Government Licence v3.0

# Load the necessary R packages
library(tidyverse)

# Read in the data to a tibble
df_raw <- read_csv("https://www.trafford.gov.uk/about-your-council/open-data/docs/trafford-council-voluntary-sector-grants.csv")

# Write out the data, no changes required
write_csv(df_raw, "trafford_council_voluntary_sector_grants.csv")

# Get CSV data converted to JSON by 360Giving Data Tool using the following steps:
#1. Go to: https://dataquality.threesixtygiving.org
#2. Expand the "Link" section and paste the following URL: https://www.trafford.gov.uk/about-your-council/open-data/docs/trafford-council-voluntary-sector-grants.csv
#3. Download and save the JSON file, converted from the original CSV as trafford_council_voluntary_sector_grants.json