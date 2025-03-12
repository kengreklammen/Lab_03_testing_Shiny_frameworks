if(!require("shiny")) install.packages("shiny")
if(!require("shiny.semantic")) install.packages("shiny.semantic")
if(!require("ggplot2")) install.packages("ggplot2")

library(shiny)
library(shiny.semantic)

ui <- semanticPage(
  title = "Let's test Shiny Semantic!",
  sidebar_layout(
    sidebar_panel(
      sliderInput("bins",
                  "Number of bins",
                  min = 5,
                  max = 50,
                  value = 25),
      dropdown_input("color", c("Blue", "Red", "Green"), c("#007bc2", "#c20000", "#00c244"), value = "Blue"),
      dropdown_input("theme", c("Classic", "Minimal", "Dark"), value = "Classic"),
      width = 1
    ),
    main_panel(
      cards(
        class = "three",
        card(class = "blue",
             div(class = "content",
                 div(class = "header", "Mean Waiting Time"),
                 field(
                   shiny::textOutput("mean_waiting", container = shiny::span)
                 )
             )
        ),
        card(class = "blue",
             div(class = "content",
                 div(class = "header", "Median Waiting Time"),
                 field(
                   shiny::textOutput("median_waiting", container = shiny::span)
                 )
             )
        ),
        card(class = "blue",
             div(class = "content",
                 div(class = "header", "Total Eruptions"),
                 field(
                   shiny::textOutput("eruption_count", container = shiny::span)
                 )
             )
        )
      ),
      
      cards(
        class = "two",
        card(class = "green",
             div(class = "content",
                 div(class = "header", "Histogram"),
                 plotOutput("distPlot")
             )
        ),
        card(class = "green",
             div(class = "content",
                 div(class = "header", "Density Plot"),
                 plotOutput("densityPlot")
             )
        ),
      ),
      
      cards(
        class = "two",
        card(class = "red",
             div(class = "content",
                 div(class = "header", "Box Plot"),
                 plotOutput("boxPlot")
             )
        ),
        card(class = "red",
             div(class = "content",
                 div(class = "header", "Scatter Plot"),
                 plotOutput("scatterPlot")
             )
        )
      )
      
    ),
    mirrored = FALSE
  )
)

server <- function(input, output) {
  
  theme_choice <- reactive({
    switch(input$theme,
           "Classic" = theme_classic(),
           "Minimal" = theme_minimal(),
           "Dark" = theme_dark())
  })
  
  output$mean_waiting <- renderText({
    paste(round(mean(faithful$waiting), 2), "mins")
  })
  
  output$median_waiting <- renderText({
    paste(round(median(faithful$waiting), 2), "mins")
  })
  
  output$eruption_count <- renderText({
    paste(nrow(faithful))
  })
  
  output$distPlot <- renderPlot({
    x <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    ggplot(data.frame(x), aes(x)) +
      geom_histogram(breaks = bins, fill = input$color, color = "white") +
      labs(x = "Waiting time to next eruption (in mins)", y = "Frequency") +
      theme_choice()
  })
  
  output$densityPlot <- renderPlot({
    x <- faithful$waiting
    
    ggplot(data.frame(x), aes(x)) +
      geom_density(fill = input$color, alpha = 0.5) +
      labs(title = "Density Plot of Waiting Times", x = "Waiting Time (mins)", y = "Density") +
      theme_choice()
  })
  
  output$boxPlot <- renderPlot({
    x <- faithful$waiting
    
    ggplot(data.frame(x), aes(y = x)) +
      geom_boxplot(fill = input$color, color = "black") +
      labs(title = "Boxplot of Waiting Times", y = "Waiting Time (mins)") +
      theme_choice()
  })
  
  output$scatterPlot <- renderPlot({
    ggplot(faithful, aes(x = eruptions, y = waiting)) +
      geom_point(color = input$color) +
      labs(title = "Scatter Plot of Eruptions vs Waiting Time", x = "Eruption Duration (mins)", y = "Waiting Time (mins)") +
      theme_choice()
  })
}

shinyApp(ui, server)