## Transparency Code - Senior Salaries ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/sites/default/files/2025-12/senior%20employees.csv
#                https://www.trafford.gov.uk/sites/default/files/2025-12/seniorsalariescount.csv
# Licence: Open Government Licence v3.0

# Load the necessary R packages
library(tidyverse)

# Read in the data to a tibble
df_employees <- read_csv("https://www.trafford.gov.uk/sites/default/files/2025-12/senior%20employees.csv")
df_count <- read_csv("https://www.trafford.gov.uk/sites/default/files/2025-12/seniorsalariescount.csv")

# Tidy up the data
# Not required for these datasets at this time

# Write out the cleaned data
write_csv(df_employees, "senior_salaries_employees.csv")
write_csv(df_count, "senior_salaries_count.csv")
