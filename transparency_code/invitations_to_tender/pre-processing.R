## Transparency Code - Invitations to Tender ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/council-data-and-democracy/transparency-and-accountability/invitations-tender
# Licence: Open Government Licence
# Created: 2026-08-24

# Purpose:
# Produce 3-star open data files from the latest CSV files uploaded to the council website open data section.
# The source CSVs are created from the original XLSX files provided by STAR Procurement, and so have been converted into 3-star open data already.
# Additionally, the latest data is added to the relevant financial year file so that the data can be queried from one place.
# This gives users a choice of having separate files for each period (via the Council website) or datasets for a complete financial year from the council_open_data repo.


# load the necessary R packages -------------------------------------------
library(tidyverse) ; library(lubridate) ;


# Read in the latest data ---------------------------
df_raw <- read_csv("https://www.trafford.gov.uk/sites/default/files/2026-08/2026-27-Q1-Published-Tenders-Trafford.csv")


# No requirement to tidy up the raw data, it's already OK ---------------------------
df <- df_raw


# Read in the current data file and add the latest data to it ---------------------------
# At the beginning of each financial year there is no current data, so skip the following 2 lines if it's Q1
df_current <- read_csv("2026-27_invitations_to_tender.csv")

# Add the new data to the top of the existing file
df <- bind_rows(df, df_current)


# Write out the processed data ---------------------------
write_csv(df, "2026-27_invitations_to_tender.csv", na = "")

