## Transparency Code - Parking Account ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/about-your-council/open-data/docs/trafford-parking-account.csv
# Licence: Open Government Licence v3.0

# Load the necessary R packages
library(tidyverse)

# Read in the data to a tibble
df_raw <- read_csv("https://www.trafford.gov.uk/about-your-council/open-data/docs/trafford-parking-account.csv")

# Tidy up the data
df <- df_raw %>%
  # Rename the columns to snake case
  rename(OrganisationLabel = `Organisation Name`,
         OrganisationURI = `Organisation Code`,
         Period = `Period`,
         OnStreetIncomeParking = `On Street Income:Parking`,
         OnStreetIncomePermit = `On Street Income:Permit`,
         OnStreetIncomePCN = `On Street Income:PCN`,
         OnStreetIncomeBlueBadge = `On Street Income:Blue Badge`,
         OnStreetIncomeOther = `On Street Income:Other`,
         OnStreetIncomeTotal = `On Street Income:Total`,
         OnStreetCostsEnforcement = `On Street Costs:Enforcement`,
         OnStreetCostsAdmin = `On Street Costs:Admin`,
         OnStreetCostsSchemes = `On Street Costs:Schemes`,
         OnStreetCostsCapital = `On Street Costs:Capital`,
         OnStreetCostsOther = `On Street Costs:Other`,
         OnStreetCostsTotal = `On Street Costs:Total`,
         OnStreetSurplusDeficit = `On Street Surplus/Deficit`,
         OnStreetSurplusDeficitSpendOffStreetParking = `On Street Surplus/Deficit Spend:Off Street Parking`,
         OnStreetSurplusDeficitSpendParkAndRide = `On Street Surplus/Deficit Spend:Park and Ride`,
         OnStreetSurplusDeficitSpendSupportedBus = `On Street Surplus/Deficit Spend:Supported Bus`,
         OnStreetSurplusDeficitSpendConcessionaryFares = `On Street Surplus/Deficit Spend:Concessionary Fares`,
         OnStreetSurplusDeficitSpendCommunityTransport = `On Street Surplus/Deficit Spend:Community Transport`,
         OnStreetSurplusDeficitSpendShopmobility = `On Street Surplus/Deficit Spend:Shopmobility`,
         OnStreetSurplusDeficitSpendSchoolCrossing = `On Street Surplus/Deficit Spend:School Crossing`,
         OnStreetSurplusDeficitSpendHighwayMaintenance = `On Street Surplus/Deficit Spend:Highway Maintenance`,
         OnStreetSurplusDeficitSpendTransportPlanning = `On Street Surplus/Deficit Spend:Transport Planning`,
         OnStreetSurplusDeficitSpendOther = `On Street Surplus/Deficit Spend:Other`,
         OffStreetIncomeParking = `Off Street Income:Parking`,
         OffStreetIncomePCN = `Off Street Income:PCN`,
         OffStreetIncomeOther = `Off Street Income:Other`,
         OffStreetIncomeTotal = `Off Street Income:Total`,
         OffStreetCostsTotal = `Off Street Costs:Total`,
         OffStreetSurplusDeficit = `Off Street Surplus/Deficit`)
  
# Write out the cleaned data
write_csv(df, "trafford_parking_account.csv")
