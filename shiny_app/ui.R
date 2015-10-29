library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("GDELT Event Data"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("eventType", label = h4("Event Type"), 
        choices = list(
          "Public Statement" = "public_statement",
          "Appeal" = "appeal",
          "Intent To Cooperate" = "intent_to_cooperate",
          "Consult" = "consult",
          "Diplomatic Cooperation" = "diplomatic_cooperation",
          "Material Cooperation" = "material_cooperation",
          "Provide Aid" = "provide_aid",
          "Yield" = "yield",
          "Investigate" = "investigate",
          "Demand" = "demand",
          "Disapprove" = "disapprove",
          "Reject" = "reject",
          "Threaten" = "threaten",
          "Protest" = "protest",
          "Exhibit Force" = "exhibit_force",
          "Reduce Relations" = "reduce_relations",
          "Coerce" = "coerce",
          "Assault" = "assault",
          "Fight" = "fight",
          "Mass Violence" = "mass_violence",
          selected = 'Public Statement')),
      textInput("centerMapLocation",
        label = h4("Center Map Location"),
        value = "New York City",
        width = NULL),
      numericInput("mapZoom",
        label = h4("Zoom"),
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
