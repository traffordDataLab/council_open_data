## Transparency Code - Fraud ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/trafford-counter-fraud.csv
# Licence: Open Government Licence v3.0

# Load the necessary R packages
library(tidyverse)

# Read in the data to a tibble
df_raw <- read_csv("https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/trafford-counter-fraud.csv")

# Tidy up the data
df <- df_raw %>%
  # Add the extra optional columns according to the LGA schema: https://schemas.opendata.esd.org.uk/Fraud
  mutate(`TotalIdentifiedFraud` = NA,
         `ValueFraud` = NA,
         `ValueFraudRecovered` = NA,
         `TotalInvestigatedIrregularities` = NA,
         `TotalIdentifiedIrregularities` = NA,
         `ValueIrregularities` = NA,
         `ValueIrregularitiesRecovered` = NA)
  
# Write out the cleaned data
write_csv(df, "trafford_counter_fraud.csv")
