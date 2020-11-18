## Transparency Code - Fraud ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/trafford-counter-fraud.csv
# Licence: Open Government Licence

# load the necessary R packages -------------------------------------------
library(tidyverse) ; library(lubridate)

# read in the data to a tibble
df_raw <- read_csv("https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/trafford-counter-fraud.csv")

# tidy up the data
df <- df_raw %>%
  # rename the columns for improved understanding
  rename(`Organisation URI` = `Organisation Code`,
         `Reporting Date` = `Effective Date`,
         `Total Occasions Fraud Powers Used` = `Total Occasions Fraud Powers`,
         `FTE Fraud Specialists Count` = `FTE Fraud Specialist Count`,
         `Amount Spent Countering Fraud` = `Fraud Spent Amount`,
         `Total Cases Fraud Investigated` = `Total Investigated Fraud`)
  
df <- df %>%
  # transform dates into correct format (**CHECK IF NECESSARY**)
  rename(`Reporting Date OLD` = `Reporting Date`,
         `Reporting Period Start OLD` = `Reporting Period Start`,
         `Reporting Period End OLD` = `Reporting Period End`) %>%

  mutate(`Reporting Date` = dmy(`Reporting Date OLD`),
         `Reporting Period Start` = dmy(`Reporting Period Start OLD`),
         `Reporting Period End` = dmy(`Reporting Period End OLD`))

df <- df %>%
  # select the columns in a more meaningful order
  select(`Organisation Name`,
         `Organisation URI`,
         `Reporting Date`,
         `Reporting Period Start`,
         `Reporting Period End`,
         `Total Occasions Fraud Powers Used`,
         `Total Fraud Employees Count`,
         `FTE Fraud Employees Count`,
         `Total Fraud Specialists Count`,
         `FTE Fraud Specialists Count`,
         `Amount Spent Countering Fraud`,
         `Total Cases Fraud Investigated`)

# Write out the cleaned data
write_csv(df, "trafford_counter_fraud.csv")
