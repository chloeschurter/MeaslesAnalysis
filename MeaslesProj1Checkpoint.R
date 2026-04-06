# Project 1 Checkpoint

#This data was collected by World Health Organisation Provisional 
# monthly measles and rubella on 6/12/2025. The data tracks the number of measles
# cases by country. We can observe variables like the country, year, amount of 
# measles suspects (case where a patient with fever and # non-vesicular rash, or 
# patient whom health-care worker suspects measles), amount of measles from clinical
# (clinically-compatible measles cases), discarded (measles was suspected, but 
# was investigated and discarded as not measles), etc 

# data loading
install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-06-24')

cases_month <- tuesdata$cases_month
cases_year <- tuesdata$cases_year
head(cases_month)
names(cases_month)
head(cases_year)
names(cases_year)

# the variable "iso3" was created in the data, as a 3 letter code for each country
# also in cases_year, the variable measles_total (which is the sum of 
# clinically-compatible, epidemiologically linked and laboratory-confirmed cases)
# a total variable was also made for rubella cases
# discarded_non_measles_rubella_cases_per_100000_total_population	
# is a variable for	discarded cases per million people

# data cleaning 
install.packages("janitor")
install.packages("here")
library(tidyverse)
library(here)
library(readxl)
library(janitor)

cases_month <- read_xlsx(here("404-table-web-epi-curve-data.xlsx"), 2) %>%
  janitor::clean_names() %>%
  dplyr::mutate(
    dplyr::across(year:discarded, as.numeric)
  )

cases_year <- read_xlsx(here("403-table-web-reporting-data.xlsx"), 2) %>%
  row_to_names(1) %>%
  clean_names() %>%
  rename(
    country = member_state,
    iso3 = iso_country_code,
    measles_total= number_of_measles_cases_by_confirmation_method,
    measles_lab_confirmed = na,
    measles_epi_linked = na_2,
    measles_clinical = na_3,
    rubella_total = number_of_rubella_cases_by_confirmation_method,
    rubella_lab_confirmed = na_4,
    rubella_epi_linked = na_5,
    rubella_clinical = na_6
  ) %>%
  slice(-1)

# in cases_month, variable names were cleaned with clean_names() to convert
# all letters to lowercase and place _ in between spaces (so all variable names 
# are uniform)
# also, all year columns were converted to numeric variables 
# in cases_year, the raw data uses rows_to_names to use the first row as the 
# column names, and the clean_names() function was used again
# also some variable names were renamed to be shorter (ex: 
# iso_country_code was shortened to become iso3)
# the slice(-1) at the end removes the first row of data (because we used these
# as the column names)

# Possible research questions that could be answered with the data:
# 1: Which country has the largest amount of measles cases?
# 2: Are there different times of year where measles outbreaks are more common 
# across these countries?

# Possible research questions with supplemental data:
# 1: Is there a positive correlation between total measles cases and the total
# number of people with long-term immune system complications? 
# 2: With the presence of a vaccine, how does the total amount of measles cases 
# change? 





