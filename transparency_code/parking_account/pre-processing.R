## Transparency Code - Parking Account ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/trafford-parking-account.csv
# Licence: Open Government Licence v3.0

# Load the necessary R packages
library(tidyverse)

# Read in the data to a tibble
df_raw <- read_csv("https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/trafford-parking-account.csv")

# Tidy up the data
df <- df_raw %>%
  # Rename the columns to snake case
  rename(organisation_name = `Organisation Name`,
         organisation_code = `Organisation Code`,
         period = `Period`,
         on_street_income_parking = `On Street Income:Parking`,
         on_street_income_permit = `On Street Income:Permit`,
         on_street_income_pcn = `On Street Income:PCN`,
         on_street_income_blue_badge = `On Street Income:Blue Badge`,
         on_street_income_other = `On Street Income:Other`,
         on_street_income_total = `On Street Income:Total`,
         on_street_costs_enforcement = `On Street Costs:Enforcement`,
         on_street_costs_admin = `On Street Costs:Admin`,
         on_street_costs_schemes = `On Street Costs:Schemes`,
         on_street_costs_capital = `On Street Costs:Capital`,
         on_street_costs_other = `On Street Costs:Other`,
         on_street_costs_total = `On Street Costs:Total`,
         on_street_surplus_deficit = `On Street Surplus/Deficit`,
         on_street_surplus_deficit_spend_off_street_parking = `On Street Surplus/Deficit Spend:Off Street Parking`,
         on_street_surplus_deficit_spend_park_and_ride = `On Street Surplus/Deficit Spend:Park and Ride`,
         on_street_surplus_deficit_spend_supported_bus = `On Street Surplus/Deficit Spend:Supported Bus`,
         on_street_surplus_deficit_spend_concessionary_fares = `On Street Surplus/Deficit Spend:Concessionary Fares`,
         on_street_surplus_deficit_spend_community_transport = `On Street Surplus/Deficit Spend:Community Transport`,
         on_street_surplus_deficit_spend_shopmobility = `On Street Surplus/Deficit Spend:Shopmobility`,
         on_street_surplus_deficit_spend_school_crossing = `On Street Surplus/Deficit Spend:School Crossing`,
         on_street_surplus_deficit_spend_highway_maintenance = `On Street Surplus/Deficit Spend:Highway Maintenance`,
         on_street_surplus_deficit_spend_transport_planning = `On Street Surplus/Deficit Spend:Transport Planning`,
         on_street_surplus_deficit_spend_other = `On Street Surplus/Deficit Spend:Other`,
         off_street_income_parking = `Off Street Income:Parking`,
         off_street_income_pcn = `Off Street Income:PCN`,
         off_street_income_other = `Off Street Income:Other`,
         off_street_income_total = `Off Street Income:Total`,
         off_street_costs_total = `Off Street Costs:Total`,
         off_street_surplus_deficit = `Off Street Surplus/Deficit`)
  
# Write out the cleaned data
write_csv(df, "trafford_parking_account.csv")
