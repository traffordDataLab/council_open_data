## Transparency Code - Senior structure dataset  ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/about-your-council/open-data/docs/senior-staff-organisation-structure.csv
# Licence: Open Government Licence v3.0

# Load the necessary R packages
library(tidyverse)

# Read in the data to a tibble
df <- read_csv("https://www.trafford.gov.uk/about-your-council/open-data/docs/senior-staff-organisation-structure.csv")

# Tidy up the data
# Not required for this dataset at this time

# Write out the cleaned data
write_csv(df, "trafford_council_organisation_structure.csv")
