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

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Locality Income vs. Housing Costs in Virginia"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      h4("In many places, higher local incomes can be partially offset by higher cost of living, especially housing costs."),
      h4("Use the slider below to select a locality median income in percent relative to the Virginia statewide mean."),
      h4("The text and plot to the right will then change to show the local median housing cost (again relative to mean) that we would predict for that local income level"),
       sliderInput("income",
                   "Select a Locality Median Income (as percent relative to mean):",
                   min = 47.93,
                   max = 230.30,
                   value = 100)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h4("Predicted housing cost relative to mean:"),
      textOutput("prediction"),
      plotlyOutput("scatterplot")
    )
  )
))
