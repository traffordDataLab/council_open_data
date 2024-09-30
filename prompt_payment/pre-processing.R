# Trafford Council Payment Performance #

# Source: Trafford Council
# URL: https://www.trafford.gov.uk/about-your-council/open-data/Payment-performance.aspx
# Licence: OGL v3.0

library(tidyverse) ; library(rvest)

# Set the source URL
webpage <- read_html("https://www.trafford.gov.uk/about-your-council/open-data/Payment-performance.aspx")

# Get the raw data to process
df_data <- webpage %>%
    html_element("table") %>%  # There is an implied assumption that this will be the only table on the page. Might be better in future to give the table an ID and reference it by html_node("#id").
    html_table(header = NA) %>% 
    as_tibble()

# Tidy the data
df_data_tidy <- df_data %>%
    # renaming of variables to shorter names as per associated metadata schema
    rename(period = `Financial Year`,
           proportion_paid_on_time = `Proportion of valid and undisputed invoices paid within 30 days in accordance with regulation 113`,
           interest_paid = `The amount of interest paid to suppliers due to a breach of the requirement in regulation 113`,
           liable_interest = `The total amount of interest that the contracting authority was liable to (whether or not paid and whether under any statutory or other requirement), due to a breach of Regulation 113`,
           number_not_paid_on_time = `*Number of invoices not paid within 30 days (Not mandatory requirement to publish requested as part of the FOIR)`) %>%
    # removing percentage and currency symbols and converting into correct type
    mutate(proportion_paid_on_time = str_replace(proportion_paid_on_time, "%", ""),
           proportion_paid_on_time = as.double(proportion_paid_on_time),
           interest_paid = str_replace(interest_paid, "£", ""),
           interest_paid = as.double(interest_paid),
           liable_interest = str_replace(liable_interest, "£", ""),
           liable_interest = str_replace(liable_interest, ",", ""),
           liable_interest = as.double(liable_interest))

# Output the tidy data
write_csv(df_data_tidy, "prompt_payment.csv")
