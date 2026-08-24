## Transparency Code - Contracts Register ##
# Source: Trafford Council
# Publisher URL: https://www.trafford.gov.uk/council-data-and-democracy/transparency-and-accountability/contracts-register
# Licence: Open Government Licence
# Created: 2026-08-24

# Purpose:
# Produce 3-star open data files in as close to the LGA schema as possible from the latest CSV files uploaded to the council website open data section.
# The source CSVs are created from the original XLSX files provided by STAR Procurement, and so have been converted into 3-star open data already. This script amends the schema.
# Additionally, the latest data is added to the relevant financial year file so that the data can be queried from one place.
# This gives users a choice of having separate files for each period (via the Council website) or datasets for a complete financial year from the council_open_data repo.


# load the necessary R packages -------------------------------------------
library(tidyverse) ; library(lubridate) ;


# Read in the latest data
df_raw <- read_csv("https://www.trafford.gov.uk/sites/default/files/2026-08/2026-27-Q1-Contracts-Register-Trafford.csv")


# tidy up the latest data and put it into the schema ---------------------------
df <- df_raw %>%
    rename(ContractReference = UID,
           ContractTitle = SourcingToContractRecordName,
           ContractType = AgreementType,
           OrganisationalUnit = CouncilDepartment,
           ServiceCategoryLabel = CouncilDirectorate,
           CPVLabel = CPVCode,
           LastExtensionDate = MaximumExtensionDate,
           SupplierName = Supplier,
           VCFSESupplier = SupplierIsVCFSE,
           ContactName = STARResponsibleOfficer,
           ProcessType = RouteToMarket) %>%
    mutate(SMESupplier = case_when(str_detect(SupplierSize, "Large") ~ "FALSE",
                                   str_detect(SupplierSize, "Other/Not known") ~ NA_character_,
                                   TRUE ~ "TRUE"),
           VCFSESupplier = case_when(VCFSESupplier == "Yes" ~ "TRUE",
                                     VCFSESupplier == "No" ~ "FALSE",
                                     TRUE ~ VCFSESupplier),
           ContractValue = as.character(str_trim(format(OriginalContractValue, scientific = FALSE, nsmall = 2))),
           AnnualValue = as.character(str_trim(format(AnnualValue, scientific = FALSE, nsmall = 2))),
           TotalSavings = as.character(str_trim(format(TotalSavings, scientific = FALSE, nsmall = 2)))) %>%
    select(OrganisationLabel,
           OrganisationURI,
           EffectiveDate,
           ContractReference,
           ContractTitle,
           ContractType,
           OrganisationalUnit,
           ServiceCategoryLabel,
           Description,
           CPVLabel,
           StartDate,
           EndDate,
           LastExtensionDate,
           ContractValue,
           SupplierName,
           SMESupplier,
           VCFSESupplier,
           STARCategory,
           STARCategoryManager,
           ContactName,
           ProcessType,
           Status,
           InitialEndDateOriginalTerm,
           LastPossibleEndDateCalc,
           BudgetType,
           AnnualValue,
           CriticalityStatus,
           CollaborativeGroup,
           TotalSavings,
           SavingsRealisationDate,
           SavingsType,
           RecurringOrOneOff,
           SupplierSize)
           

# Read in the current data file and add the latest data to it ---------------------------
# At the beginning of each financial year there is no current data, so skip the following 2 lines if it's Q1
df_current <- read_csv("2026-27_contracts_register.csv") %>%
    mutate(ContractValue = as.character(str_trim(format(ContractValue, scientific = FALSE, nsmall = 2))),
           AnnualValue = as.character(str_trim(format(AnnualValue, scientific = FALSE, nsmall = 2))),
           TotalSavings = as.character(str_trim(format(TotalSavings, scientific = FALSE, nsmall = 2))),
           SMESupplier = as.character(SMESupplier),
           VCFSESupplier = as.character(VCFSESupplier))

# Add the new data to the top of the existing file
df <- bind_rows(df, df_current)

  
# Write out the processed data ---------------------------
write_csv(df, "2026-27_contracts_register.csv", na = "")

