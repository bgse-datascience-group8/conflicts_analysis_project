# mysql import:
# $ mysql -uroot -p gdelt < usa_events_subset_random.sql
# install.packages(RMySQL)
library(RMySQL)

con <- dbConnect(RMySQL::MySQL(), user="root", password="root", dbname = "gdelt")

res <- dbSendQuery(con, "select * from city_day_event_counts")
# n = -1 fetches all results, instead of default limit of first 500
data <- dbFetch(res, n = -1)
