# install.packages(RMySQL)
library(RMySQL)

con <- dbConnect(RMySQL::MySQL(),
  dbname = "gdelt",
  host = "ds-group8.cgwo8rgbvpyh.eu-west-1.rds.amazonaws.com",
  user = "group8",
  password = Sys.getenv("DB_PASSWORD"))

res <- dbSendQuery(con, "select * from random_events")
# n = -1 fetches all results, instead of default limit of first 500
data <- dbFetch(res, n = -1)
