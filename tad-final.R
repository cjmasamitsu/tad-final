library(tidyverse)
library(shiny)
# install.packages("quanteda")
library(quanteda)

# Data Preparation --------------------------------------------------------



# Shiny UI ----------------------------------------------------------------

ui <- fluidPage(
  # Main Title
  titlePanel("How are United States Senators using Twitter to engage their constituents?"),
  navlistPanel(
    
    # Category 1
    "X y z",
    tabPanel("By State",
             mainPanel(
               h2("test 1"),
               h4("test 2")
             ))
  )
)


# Shiny Server ------------------------------------------------------------

server <- function(input, output){
  output$plot1 <- renderPlotly({
    ggplotly(viz_one)
    
  })
}
