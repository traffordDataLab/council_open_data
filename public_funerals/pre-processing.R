## Public Health Funerals ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/trafford-public-funeral-summary.csv
# Licence: Open Government Licence v3.0

# Load the necessary R packages
library(tidyverse)

# Read in the data to a tibble
df_raw <- read_csv("https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/trafford-public-funeral-summary.csv")

# Tidy up the data
df <- df_raw %>%
  # Rename the columns according to the LGA schema: https://schemas.opendata.esd.org.uk/Fraud
  # NOTE: we have added an extra field `Period` which contains the financial year to which the data belongs. This is because `EffectiveDate` doesn't convey this fully.
  rename(organisation_name = `Organisation Name`,
         organisation_code = `Organisation Code`,
         period = `Period`,
         number_of_funerals = `Number of Funerals`,
         cost = `Cost`,
         number_of_burials = `Number of Burials`,
         number_of_cremations = `Number of Cremations`)
  
# Write out the cleaned data
write_csv(df, "trafford_public_funeral_summary.csv")
