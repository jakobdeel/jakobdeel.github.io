#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(shiny)
library(plotly)

# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Text Prediction Algorithm"),
  
  # Sidebar with a text input for input text string 
  sidebarLayout(
    sidebarPanel(
      h4("In the text box below, enter the text string that you would like a next-word prediction for."),
      textInput("inputstring",
                  label = NULL,
                  value = "",
                  Width = '100%',
                  placeholder = "I want to go to the")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h4("Next word predictions:"),
      textOutput("predlist"),
      plotlyOutput("plot")
    )
  )
))
