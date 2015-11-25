library(RMySQL)

con <- dbConnect(RMySQL::MySQL(), user="root", password="root", dbname = "gdelt")

res <- dbSendQuery(con, "select * from usa_events_subset_random")
# n = -1 fetches all results, instead of default limit of first 500
data <- dbFetch(res, n = -1)

num_mentions_quants <- quantile(na.omit(data$std_num_mentions), probs = seq(0,1,0.02))
num_articles_quants <- quantile(na.omit(data$std_num_articles), probs = seq(0,1,0.02))
# select SOURCEURL from usa_events_subset_random where std_num_mentions < -0.5547 and SQLDATE > 20150101 and (QuadClass = 3 or QuadClass = 4) LIMIT 10;
# select SOURCEURL from usa_events_subset_random where std_num_articles < -0.5497 and SQLDATE > 20150101 and (QuadClass = 3 or QuadClass = 4) LIMIT 10;

