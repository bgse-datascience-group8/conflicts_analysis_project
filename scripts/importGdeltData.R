# Had to add the following to ~/.my.cnf before this will work:
#
# [gdelt]
# user=root
# password=root
#
# To execute from the commandline:
# nohup R CMD BATCH importGdeltData.R &
# 
#install.packages('RMySQL', dependencies=TRUE, repos='http://cran.rstudio.com/')
#install.packages('lubridate', dependencies=TRUE, repos='http://cran.rstudio.com/')

library(RMySQL)
library(lubridate)

# REMOTE DB
con <- dbConnect(RMySQL::MySQL(),
  dbname = "gdelt",
  host = "group8-db.cgwo8rgbvpyh.eu-west-1.rds.amazonaws.com",
  user = "group8",
  password = Sys.getenv("DB_PASSWORD"))

colHeaders <- c('GLOBALEVENTID', 'SQLDATE', 'MonthYear', 'Year',
'FractionDate', 'Actor1Code', 'Actor1Name', 'Actor1CountryCode',
'Actor1KnownGroupCode', 'Actor1EthnicCode', 'Actor1Religion1Code',
'Actor1Religion2Code', 'Actor1Type1Code', 'Actor1Type2Code',
'Actor1Type3Code', 'Actor2Code', 'Actor2Name', 'Actor2CountryCode',
'Actor2KnownGroupCode', 'Actor2EthnicCode', 'Actor2Religion1Code',
'Actor2Religion2Code', 'Actor2Type1Code', 'Actor2Type2Code',
'Actor2Type3Code', 'IsRootEvent', 'EventCode', 'EventBaseCode',
'EventRootCode', 'QuadClass', 'GoldsteinScale', 'NumMentions', 'NumSources',
'NumArticles', 'AvgTone', 'Actor1Geo_Type', 'Actor1Geo_FullName',
'Actor1Geo_CountryCode', 'Actor1Geo_ADM1Code', 'Actor1Geo_Lat',
'Actor1Geo_Long', 'Actor1Geo_FeatureID', 'Actor2Geo_Type',
'Actor2Geo_FullName', 'Actor2Geo_CountryCode', 'Actor2Geo_ADM1Code',
'Actor2Geo_Lat', 'Actor2Geo_Long', 'Actor2Geo_FeatureID', 'ActionGeo_Type',
'ActionGeo_FullName', 'ActionGeo_CountryCode', 'ActionGeo_ADM1Code',
'ActionGeo_Lat', 'ActionGeo_Long', 'ActionGeo_FeatureID', 'DATEADDED',
'SOURCEURL')

start <- 20130401
startdate <- strptime(start, "%Y%m%d")
ndays <- now() - startdate
enddate <- now()
days <- seq(startdate, enddate, by = 'day')
days <- format(days, '%Y%m%d')

for (nday in 1:ndays) {
  day <- days[nday]
  filename <- paste0(day, '.export.CSV')
  zip_filename <- paste0(filename, '.zip')
  download.file(paste0('http://data.gdeltproject.org/events/', zip_filename), zip_filename)
  print(paste0('Downloaded data for ', day))
  unzip(zip_filename)
  data <- read.csv(filename, sep = '\t', stringsAsFactors = FALSE)

  colnames(data) <- colHeaders
  data <- subset(data, SQLDATE > 20130330)

  print(paste0('Starting database write for ', day))
  dbWriteTable(con, "events", data, append = TRUE)
  unlink(filename)
  unlink(zip_filename)
  print(paste0('Done processing ', day))
}
