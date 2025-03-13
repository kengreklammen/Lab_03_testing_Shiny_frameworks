library(shiny)

ui <- fluidPage(
  titlePanel("Iris database with reactive approach"),
  sidebarLayout(
    sidebarPanel(
      selectInput("select_species", "Choose a species", choices = c("setosa", "versicolor", "virginica")), # to choose a species from iris$Species.
      sliderInput("slider_sepallength", "Set sepal length", min = 4.4, max = 7, value = 5), # to select a range of Sepal.Length values.
      actionButton("button_filter", "Filter data") # to filter the data
    ),
    mainPanel(
      tableOutput("iris_table")
    )
  )
)

server <- function(input, output, session) {
  filtered_data <- reactive({
    input$species
    subset(iris, Species == input$select_species)
  })

  output$iris_table <- renderTable({ filtered_data() })
  
  
  data2 <- eventReactive(input$button_filter, {
    subset(filtered_data, Sepal.Length == input$slider_sepallength)
    updateSliderInput(session, "slider_sepallength", 
                      min = min(filtered_data()$Sepal.Length), 
                      max = max(filtered_data()$Sepal.Length), 
                      value = min(filtered_data()$Sepal.Length))
  })
  output$iris_table <- renderTable({ data2() })
  
  
  observe({
    print(paste("The user selected a different Species: ", input$select_species))
  })
  
}

shinyApp(ui, server, options = list(display.mode = "showcase"))