## Public Health Funerals ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/trafford-public-funerals.csv
# Licence: Open Government Licence v3.0

# Load the necessary R packages
library(tidyverse)

# Read in the data to a tibble
df_raw <- read_csv("https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/trafford-public-funerals.csv")

# No tidying of the data required, so just write out the raw data
write_csv(df_raw, "trafford_public_funerals.csv")