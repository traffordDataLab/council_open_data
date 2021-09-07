## Transparency Code - Trade Union Facility Time ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/trade-union-facility-time.csv
# Licence: Open Government Licence v3.0

# Load the necessary R packages
library(tidyverse)

# Read in the data to a tibble
df_raw <- read_csv("https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/trade-union-facility-time.csv")

# Tidy up the data
# - nothing required for this dataset

# Write out the cleaned data
write_csv(df_raw, "trade_union_facility_time.csv")
