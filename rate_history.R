# Needed packages
library(tidyverse)
library(rvest)
library(quantmod)

# Retreieve current rate data from treasurydirect.gov
content <- read_html("https://www.treasurydirect.gov/indiv/research/indepth/ibonds/res_ibonds_iratesandterms.htm#fixed")
tables <- content %>% html_table(fill = TRUE)

# Table 3 contains fixed rates; the dates need to be coerced into a date index
ibond_rates_raw <- as.data.frame(tables[[3]])
# Amend column names
names(ibond_rates_raw) <- c("Date","Rate")

# Function to coerce an individual date
date_coerce <- function(x){
  months <- c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
  date.list <- strsplit(x," ")
  month.no <- (which(!is.na(match(months,date.list[[1]][1]))))
  if (month.no < 10){
    month.no <- paste("0",month.no,sep="")
  }
  year <- date.list[[1]][3]
  day <- date.list[[1]][2]
  day <- gsub(",","",day)
  if (as.numeric(day) < 10){
    day <- paste("0",day,sep="")
  }
  return(paste(year,month.no,day,sep="-"))
}

ibond_rates_dates <- unlist(lapply(ibond_rates_raw$Date, date_coerce))

# Remove the "%" from the rates vector
ibond_rates <- unlist(lapply(ibond_rates_raw[,2], function(x){as.numeric(gsub("%","",x))}))

ibond_rates.xts <- xts(ibond_rates, order.by = as.Date(ibond_rates_dates) )

# Convert to daily for potential merging with other daily time series
# or subsetting via to.period() functions for monthly/weekly/etc.

# First grab any market data series like VTSMX to get a set of trading-day dates
ibond_start <- index(first(ibond_rates.xts))
ibond_window <- paste(ibond_start,"::",sep="")
  
getSymbols("VTSMX", from='1960-01-01')
temp <- cbind(Ad(VTSMX[ibond_window]),ibond_rates.xts)
for (i in 1:nrow(temp)){
  if(is.na(temp[i,2])){
    temp[i,2] <- temp[i-1,2]
  }
}

ibond_rates_daily.xts <- xts(temp[,2], order.by = index(temp))




