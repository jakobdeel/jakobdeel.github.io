#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Data loading and processing
#reads in ngrams frequency list
ngramslist <- readRDS("ngramslist.RDS")

#reads in txtpredict function
load("txtpredict.R")

# Define server logic required to output word prediction list and plot
shinyServer(function(input, output) {
  
  #runs txtpredict function on input phrase string
  prediction <- txtpredict(input$inputstring)

  #outputs list of 5 most likely next word predictions
  output$predlist <- renderPrint({
    cat(prediction$next_word[1:5])
  })
    
  #creates and outputs bar chart to show likelihood of each next word
  output$plot <- renderPlotly({
    plot <- plot_ly(data = prediction, x = prediction$next_word[1:5], y = prediction$prop[1:5], 
                    name = "Prediction Visualization", type = "bar")
    plot <- layout(plot, 
                   xaxis = list(title = "Predicted Next Words"),
                   yaxis = list(title = "Predicted Likelihood"),
                   showlegend = FALSE)
    plot
})
})
