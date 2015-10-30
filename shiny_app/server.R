library(shiny)
library(RMySQL)
library(ggmap)
library(grid)

shinyServer(function(input, output) {
  con <- dbConnect(RMySQL::MySQL(),
    dbname = "gdelt",
    host = "bgseds-group8-rds.cgwo8rgbvpyh.eu-west-1.rds.amazonaws.com",
    user = "group8",
    password = Sys.getenv("DB_PASSWORD"))

  output$significanceMap <- renderPlot({
    res <- dbSendQuery(con, paste0("select * from ", input$eventType))
    data <- dbFetch(res, n = -1)
    # Check out the distribution
    # Played with different intervals from 0.1, 0.05, 0.01 to get a reasonable subset
    qs <- quantile(data$NumMentions, probs = seq(0, 1, 0.01))
    data_subset <- subset(data, NumMentions > qs['99%'])

    # Make sure we have a reasonable distribution
    meanLogNumMentions <- mean(log(data_subset$NumMentions))
    #hist(log(data_subset$NumMentions))
    data_subset$logNumMentions <- log(data_subset$NumMentions)

    map <- NULL
    mapWorld <- borders("world", colour="gray40", fill="gray40")
    map <- get_map(input$centerMapLocation, zoom = input$mapZoom, maptype = 'satellite')
    map <- ggmap(map, extent = 'device') + 
      geom_point(data = data_subset, aes(x = ActionGeo_Long, y = ActionGeo_Lat, size = logNumMentions), colour = 'orange')

    map
  },
  width = 800, height = 500)
})
