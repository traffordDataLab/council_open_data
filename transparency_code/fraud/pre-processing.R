## Transparency Code - Fraud ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/Counter-Fraud-2018-19.csv
# Licence: Open Government Licence

# load the necessary R packages -------------------------------------------
library(tidyverse) ; library(lubridate)

# read in the data to a tibble
df_raw <- read_csv("https://www.trafford.gov.uk/about-your-council/data-protection/open-data/docs/Counter-Fraud-2018-19.csv")

# tidy up the data
df <- df_raw %>%
  # rename the columns for improved understanding
  rename(`Organisation URI` = `Organisation Code`,
         `Total Occasions Fraud Powers Used` = `Total Occasions Fraud Powers`,
         `FTE Fraud Specialists Count` = `FTE Fraud Specialist Count`,
         `Amount Spent Countering Fraud` = `Fraud Spent Amount`,
         `Total Cases Fraud Investigated` = `Total Investigated Fraud`,
         `Total Cases Fraud Identified` = `Total Identified Fraud`,
         `Value Fraud Identified` = `Value Fraud`,
         `Total Cases Irregularities Investigated` = `Total Investigated Irregularities`,
         `Total Cases Irregularities Identified` = `Total Identified Irregularities`,
         `Value Irregularities Identified` = `Value Irregularities`,
         `Reporting Period` = `Period`) %>%
  
  # transform dates into correct format
  mutate(`Reporting Date` = dmy(`Effective Date`)) %>%
  
  # select the columns in a more meaningful order
  select(`Organisation Name`,
         `Organisation URI`,
         `Reporting Date`,
         `Reporting Period`,
         `Total Occasions Fraud Powers Used`,
         `Total Fraud Employees Count`,
         `FTE Fraud Employees Count`,
         `Total Fraud Specialists Count`,
         `FTE Fraud Specialists Count`,
         `Amount Spent Countering Fraud`,
         `Total Cases Fraud Investigated`,
         `Total Cases Fraud Identified`,
         `Value Fraud Identified`,
         `Value Fraud Recovered`,
         `Total Cases Irregularities Investigated`,
         `Total Cases Irregularities Identified`,
         `Value Irregularities Identified`,
         `Value Irregularities Recovered`)

# Write out the cleaned data
write_csv(df, "trafford_counter_fraud.csv")
