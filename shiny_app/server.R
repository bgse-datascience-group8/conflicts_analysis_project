library(shiny)
library(RMySQL)
library(ggmap)
library(grid)

shinyServer(function(input, output) {
  output$significanceMap <- renderPlot({
    con <- dbConnect(RMySQL::MySQL(), "gdelt", group = "gdelt")
    # FIXME: SQLDATE CAN BE AN ARGUMENT OR SELECTION
    res <- dbSendQuery(con, "select * from events where SQLDATE > 20151020 and EventRootCode is not NULL;")
    data <- dbFetch(res, n = -1)
    print('LOADED EVENTS')

    qs <- quantile(data$NumMentions, probs = seq(0, 1, 0.01))
    data_subset <- subset(data, NumMentions > qs['99%'])

    meanLogNumMentions <- mean(log(data_subset$NumMentions))
    hist(log(data_subset$NumMentions))
    data_subset$logNumMentions <- log(data_subset$NumMentions)

    map <- NULL
    mapWorld <- borders("world", colour="gray40", fill="gray40")
    map <- ggplot() + mapWorld
    map <- map + geom_point(data = data_subset, aes(x = ActionGeo_Long, y = ActionGeo_Lat, size = logNumMentions))
    map
  })
})
