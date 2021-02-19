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
  # Rename the columns according to the LGA schema: https://schemas.opendata.esd.org.uk/Fraud
  # NOTE: we have added an extra field `Period` which contains the financial year to which the data belongs. This is because `EffectiveDate` doesn't convey this fully.
  rename(OrganisationLabel = `Organisation Name`,
         OrganisationCode = `Organisation Code`,
         EffectiveDate = `Effective Date`,
         TotalOccasionsFraudPowers = `Total Occasions Fraud Powers`,
         TotalFraudEmployeesCount = `Total Fraud Employees Count`,
         FTEFraudEmployeesCount = `FTE Fraud Employees Count`,
         TotalFraudSpecialistsCount = `Total Fraud Specialists Count`,
         FTEFraudSpecialistCount = `FTE Fraud Specialist Count`,
         FraudSpentAmount = `Fraud Spent Amount`,
         TotalInvestigatedFraud = `Total Investigated Fraud`)
  
# Write out the cleaned data
write_csv(df, "trafford_counter_fraud.csv")
