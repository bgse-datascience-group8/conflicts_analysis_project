library(RMySQL)
library(ggmap)
library(fields)
con <- dbConnect(MySQL(), user="root", password="3442", dbname = "gdelt")
res <- dbSendQuery(con, "select * from random_events")
data <- dbFetch(res, n = -1)

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

