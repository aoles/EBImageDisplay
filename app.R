library(shiny)
library(EBImage)

ui <- fluidPage(
  
  # Application title
  titlePanel("Image display"),
  
  # Sidebar with a select input for the image
  sidebarLayout(
    sidebarPanel(
      selectInput("image", "Sample image:", list.files(system.file("images", package="EBImage")))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Static raster", plotOutput("raster")),
        tabPanel("Interactive browser", displayOutput("widget"))
      )
    )
  )
  
)

server <- function(input, output) {
  
  img <- reactive({
    f = system.file("images", input$image, package="EBImage")
    readImage(f)
  })
  
  output$widget <- renderDisplay({
    display(img())
  })
  
  output$raster <- renderPlot({
    plot(img(), all=TRUE)
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)
