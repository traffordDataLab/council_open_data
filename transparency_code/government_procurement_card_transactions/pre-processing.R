## Transparency Code - Government Procurement Card (GPC) transactions ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/council-data-and-democracy/transparency-and-accountability/supplier-spend
# Licence: Open Government Licence
# Created: 2026-06-30
# NOTE: Each financial year the filename and url will require changing.


# load the necessary R packages -------------------------------------------
library(tidyverse)


# Read in the data -------------------------------------------
df_raw <- read_csv("https://www.trafford.gov.uk/sites/default/files/2026-05/trafford-card-spend-2026-27.csv")

# Tidy up the data
# - nothing required for this dataset


# Write out the cleaned data -------------------------------------------
write_csv(df_raw, "government_procurement_card_transactions_2026-27.csv")
