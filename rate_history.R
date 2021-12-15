# TIPS Rates
library(tidyverse)
library(rvest)
library(quantmod)

# Retreieve current rate data from treasurydirect.gov
content <- read_html("https://www.treasurydirect.gov/indiv/research/indepth/ibonds/res_ibonds_iratesandterms.htm#fixed")
tables <- content %>% html_table(fill = TRUE)

# Table 3 contains fixed rates
ibond_rates <- tables[[3]]

getSymbols('DFII10', src='FRED')