library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("GDELT Event Data"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      # sliderInput("alpha",
      #   "Alpha",
      #   min = 0,
      #   max = 0.25,
      #   value = 0.05),
      numericInput("mapZoom",
        label = h3("Zoom"),
        value = 5)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        #tabPanel("Distance between Actors", plotOutput("actorsMap")),
        tabPanel("Significance of Events", plotOutput("significanceMap"))
      )
    )
  )
))
