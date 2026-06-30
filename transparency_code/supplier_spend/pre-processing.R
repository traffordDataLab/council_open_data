## Transparency Code - Expenditure exceeding £500 (known as Supplier Spend on the Trafford website and details all expenditure) ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/council-data-and-democracy/transparency-and-accountability/supplier-spend
# Licence: Open Government Licence
# Created: 2026-06-29
# NOTE: Each financial year the file_name and file_url will require changing. These files are large, so we are just saving the ZIPs, rather than extracting them.

# Load the necessary R packages -------------------------------------------
library(tidyverse)


# Download the current data -------------------------------------------
file_name <- "trafford-supplier-spend-2026-27.zip"
file_url <- paste0("https://www.trafford.gov.uk/sites/default/files/2026-05/", file_name)

unlink(file_name)   # delete the current file first before downloading the updated version
download.file(file_url, file_name)
