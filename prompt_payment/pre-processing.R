# Trafford Council Payment Performance #
# Source: Trafford Council
# URL: https://www.trafford.gov.uk/sites/default/files/2026-05/trafford-payment-performance.csv
# Licence: OGL v3.0

# Load the necessary R packages
library(tidyverse)

# Read in the data to a tibble
df_raw <- read_csv("https://www.trafford.gov.uk/sites/default/files/2026-05/trafford-payment-performance.csv")

# Tidy up the data
# - nothing required for this dataset

# Write out the cleaned data
write_csv(df_raw, "prompt_payment.csv")
