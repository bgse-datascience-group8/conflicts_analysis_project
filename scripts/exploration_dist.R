library(RMySQL)
library(ggmap)
library(fields)
con <- dbConnect(MySQL(), user="root", password="3442", dbname = "gdelt")
# res <- dbSendQuery(con, "select * from random_events")

res <- dbSendQuery(con, "select * from city_day_event_counts")
data <- dbFetch(res, n = -1)


#################################################################################################
# EXPLORATORY ANALYSIS OF THE GDELT DATABASE
#################################################################################################

geodata <- subset(data, select=c(GLOBALEVENTID, EventRootCode, NumMentions, ActionGeo_Lat, ActionGeo_Long))
geodata_us <- subset(geodata, ActionGeo_Lat < 55 & ActionGeo_Lat > 0 & ActionGeo_Long < -45 & ActionGeo_Long > -140)
time <- subset(data, select=c(GLOBALEVENTID, EventRootCode, DATEADDED))
time[,3] <- as.Date(as.character(time[,3]), "%Y%m%d")
time[,3] <- as.numeric(time[,3])

# It is much better to use the logarithm of the number of mentions
# to measure relevance, rather than the absolute value

hist(geodata$NumMentions)
hist(log(geodata$NumMentions))

geodata$LogMentions = log(geodata$NumMentions)

map <- get_map(location = 'united states', zoom = 3, source = 'google')
#map <- get_map(location = c(left = 51.4978, bottom = -60.4462, right = 16.0290, top = -133.5712), source = 'google')

firstlook_size <- ggmap(map) +
geom_point(aes(x = ActionGeo_Long, y = ActionGeo_Lat, size = LogMentions), data = geodata, colour="red", alpha=.5)
firstlook_size

firstlook_CAMEO <- ggmap(map) +
  geom_point(aes(x = ActionGeo_Long, y = ActionGeo_Lat, size = LogMentions, colour=EventRootCode), data = geodata, alpha=.5)
firstlook_CAMEO


# I created a matrix of dimension NumEvents x NumEvents indicating the distance
# between any pair of events from a random subset of 2000 and plotted the distribution

coordinates_matrix <- subset(geodata[round(runif(2000,1,20000),0),], select=c(ActionGeo_Lat, ActionGeo_Long))
distances = rdist(as.matrix(coordinates_matrix))
hist(as.vector(distances))


time_matrix <- subset(time[round(runif(2000,1,20000),0),], select=c(DATEADDED))
time_distance = rdist(as.matrix(time_matrix))

# either there is something wrong with the following graph or we have found something cool

hist(as.vector(time_distance))

# attempt of clustering analysis

# hierarcical 
# too big to work?
distances_k <- rdist(as.matrix(na.omit(coordinates_matrix)))
clusters <- hclust(distances_k, method="ward.D")
plot(clusters)

groups <- cutree(clusters, k=5)
rect.hclust(clusters, k=5, border="red")


# k-means

k = 5
set.seed(1)
geodata_us <- na.omit(geodata_us)
geodata_us$LogMentions = log(geodata_us$NumMentions)
geodata_k <- geodata_us[,4:5]
KMC = kmeans(geodata_k, centers = k, iter.max = 1000)
str(KMC)

# Extract clusters
Clusters = KMC$cluster
clust_plot <- cbind(geodata_us, Clusters)

library(cluster)
clusplot(geodata_k, Clusters, color=TRUE, shade=TRUE, 
         labels=2, lines=0)

install.packages("fpc")
library(fpc)
plotcluster(geodata_k, Clusters)

firstlook_clust <- ggmap(map) +
  geom_point(aes(x = ActionGeo_Long, y = ActionGeo_Lat, size = LogMentions, colour=Clusters), data = geodata_us, alpha=.5)
firstlook_clust

#################################################################################################
# ANALYSIS CITY EVENTS TABLE
#################################################################################################

# import table from SQL in an data.frame called "data"

library(RMySQL)
con <- dbConnect(MySQL(), user="root", password="3442", dbname = "gdelt")
res <- dbSendQuery(con, "select * from city_day_event_counts")
data <- dbFetch(res, n = -1)

num_of_cities = length(as.data.frame(table(data$feature_name))[,1])

# merge mentions, articles and sources into a "impact" variable
data$impact = data$sum_num_mentions + data$sum_num_articles + data$sum_num_sources

# get total number of events per day
events_by_date = tapply(data$num_conflicts, data$sqldate, sum)
events_by_date = as.data.frame(events_by_date)
events_by_date$sqldate = rownames(events_by_date)

# get total impact by day
impact_by_date = tapply(data$impact, data$sqldate, sum)
impact_by_date = as.data.frame(impact_by_date)
impact_by_date$sqldate = rownames(impact_by_date)

ncol(as.data.frame(events_by_date))

dates = rownames(as.data.frame(events_by_date))
dates = as.data.frame(dates)
head(dates)

# subsetting the cities with more activity


head(data)
data$city = paste(data$feature_name, "-", data$county_name, "-", data$state_alpha)

most_cities = tapply(data$num_conflicts, data$city, sum)
most_cities = as.data.frame(most_cities)
most_cities$city = rownames(most_cities) 
most_cities = most_cities[order(most_cities$most_cities, decreasing=TRUE),]
top_100 = most_cities[1:100,]
top_100_cities = top_100[,2]

head(top_100_cities)
# CREATE TABLE OF NUMBER OF EVENTS N (days) x P (cities)

library(plyr)

cities_matrix = dates
colnames(cities_matrix) = "sqldate"

for (i in 1:100) {
#for (i in 1:length(top_100_cities)) {
  cat('\r', i, 'of', length(top_100_cities) )
  cities = top_100_cities[i]
  city = data[ which(data$city == top_100_cities[i]), c(1,5)]
  colnames(city) = c(top_100_cities[i], "sqldate")
  cities_matrix = merge(cities_matrix, city, by.x ="sqldate", by.y = "sqldate", all.x=TRUE)
  #cities_matrix = join(cities_matrix, city, type = "inner")
}

cities_matrix[is.na(cities_matrix)] <- 0

# standardize cities matrix by total events per day and per city à la google trend

total_per_day = rowSums(cities_matrix[,-1])

cities_matrix_ext = cbind(cities_matrix, total_per_day)
cities_stand = cities_matrix[,2:101] / total_per_day 

max_per_city = sapply(cities_stand, max)
cities_plotting = matrix(0,nrow(cities_stand), 100)

for (i in 1:100) {
  cities_plotting[,i] = (cities_stand[,i] / max_per_city[i])*100
}
  
plot(1:nrow(cities_plotting), cities_plotting[,6], type = "l")

# compute convariance matrix for cities with more activity

for (i in 1:100) {
  city = data[ which(data$feature_name == top_100_cities[i]), c(1,5)]
  print(nrow(city))
}


# create normalized events per city per day and impact per city per day
data = merge(data, events_by_date, by.x = "sqldate", by.y = "sqldate")
data = merge(data, impact_by_date, by.x = "sqldate", by.y = "sqldate")
data$impact_norm = 
data$conflicts_norm = 

# rescale number 
  
# Predict number of events in city i based on:

# proving existance of autocorrelation / absence of iid of events in one city with respect to the city nearby
# check correlation of sequence of events in time of one city with that of another city

  