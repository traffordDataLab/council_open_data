## Trafford libraries ##
# Source: Trafford Council
# Data is currently published within our https://github.com/traffordDataLab/open_data repo. It is essentially replicated here for now.
# Publisher URL: https://github.com/traffordDataLab/open_data/tree/master/libraries
# Licence: Open Government Licence v3.0

# Load the necessary R packages
library(tidyverse); library(sf)

# Read in the data from the open_data repo
sf_libraries <- st_read("https://www.trafforddatalab.io/open_data/libraries/trafford_libraries.geojson") %>%
    rename_with(tolower) %>%
    select(name, type, address, postcode, email, website)

# Write out the new file
st_write(sf_libraries, "libraries.geojson")
