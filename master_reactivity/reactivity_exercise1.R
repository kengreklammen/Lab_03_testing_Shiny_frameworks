library(shiny)

ui <- fluidPage(
  titlePanel("Iris database with reactive approach"),
  sidebarLayout(
    sidebarPanel(
      selectInput("item", "Choose an Item", choices = NULL), # to choose a species from iris$Species.
      sliderInput("slider1", "Set value", min = 0, max = 100, value = 50), # to select a range of Sepal.Length values.
      actionButton("action", "Action") # to filter the data
    ),
    mainPanel(
      tableOutput("iristable")
    )
  )
)

server <- function(input, output, session) {
  data <- subset(iris, Species == input$species)

}

shinyApp(ui, server, options = list(display.mode = "showcase"))