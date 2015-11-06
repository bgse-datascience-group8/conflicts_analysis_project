library(RMySQL)
library(ggmap)
library(fields)
con <- dbConnect(MySQL(), user="root", password="3442", dbname = "gdelt")
res <- dbSendQuery(con, "select * from random_events")
data <- dbFetch(res, n = -1)

geodata <- subset(data, select=c(GLOBALEVENTID, EventCode, NumMentions, ActionGeo_Lat, ActionGeo_Long))

# It is much better to use the logarithm of the number of mentions
# to measure relevance, rather than the absolute value

hist(geodata$NumMentions)
hist(log(geodata$NumMentions))

geodata$LogMentions = log(geodata$NumMentions)

map <- get_map(location = 'united states', zoom = 3, source = 'google')
#map <- get_map(location = c(left = 51.4978, bottom = -60.4462, right = 16.0290, top = -133.5712), source = 'google')

firstlook <- ggmap(map) +
geom_point(aes(x = ActionGeo_Long, y = ActionGeo_Lat, size = LogMentions), data = geodata, colour="red", alpha=.5)

firstlook

# I created a matrix of dimension NumEvents x NumEvents indicating the distance
# between any pair of events from a random subset of 2000 and plotted the distribution

coordinates_matrix <- subset(geodata[round(runif(2000,1,20000),0),], select=c(ActionGeo_Lat, ActionGeo_Long))
distances = rdist(as.matrix(coordinates_matrix))
hist(as.vector(distances))





