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
#reads in data obtained from census.gov
dat <- read.csv("JD_ACS_17_5YR_S2503_with_ann.csv")

#creates variables for locality median income and housing costs compared to mean
dat$medianincomevsmean <- (dat$medianincome/mean(dat$medianincome))*100
dat$housingmedianvsmean <- (dat$housingmedian/mean(dat$housingmedian))*100

#runs simple prediction algorithm on housing vs. mean as function of median income vs. mean
m1 <- lm(dat$housingmedianvsmean~dat$medianincomevsmean)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$scatterplot <- renderPlotly({
    # create plot with vertical line at chosen income
    plot <- plot_ly(data = dat, x = dat$medianincomevsmean, y = dat$housingmedianvsmean, 
                    text = dat$geography, type = "scatter")
    plot <- add_lines(plot, x = dat$medianincomevsmean, y = predict(m1))
    vline <- function(x = 100, color = "red") {
      list(
        type = "line", 
        y0 = 0, 
        y1 = 1, 
        yref = "paper",
        x0 = x, 
        x1 = x, 
        line = list(color = color)
      )
    }
    plot <- layout(plot, 
                   xaxis = list(title = "Locality Median Income vs. statewide mean"),
                   yaxis = list(title = "Locality Median Housing Cost vs. statewide mean"),
                   shapes = list(vline(x = input$income)),
                   showlegend = FALSE)
    plot
  })
  
  #outputs predicted housing cost relative to mean for chosen income
  output$prediction <- renderText(m1$coefficients[2]*input$income)
  
})
