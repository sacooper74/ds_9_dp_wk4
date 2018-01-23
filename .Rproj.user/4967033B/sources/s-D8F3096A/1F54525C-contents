#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# libraries
library(shiny)
library(tidyverse)

shinyServer(function(input, output) {
  # import the dataset
  runlog <- read_csv("runlog.csv", 
                     col_types = list(AvgPace = col_time(format = "%M:%S")))
  runlog$AvgCadence <- as.numeric(runlog$AvgCadence)

  # linear model to predict average pace based upon average cadence
  model1 <- lm(AvgPace ~ AvgCadence, data = runlog)
  model1$coefficients

  # Perform the prediction in a reactive function
  model1pred <- reactive({
    cad_input <- input$slider_cad
    predict(model1, newdata = data.frame(AvgCadence = cad_input))
  })
  
  # Output the plot
  output$plot1 <- renderPlot({
    cad_input <- input$slider_cad
    
    runlog %>%
      ggplot(mapping = aes(AvgPace, AvgCadence)) +
      geom_point() +
      # geom_abline(intercept = model1$coefficients[1], slope = model1$coefficients[2]) +
      geom_smooth(method = "lm") +
      geom_point(mapping = aes(model1pred(), cad_input), size = 5, colour = "red", alpha = 0.4)
    
    # plot(runlog$AvgPace, runlog$AvgCadence, xlab = "Average Pace", ylab = "Average Cadence", bty = "n", pch = 16)
    # abline(model1, col = "red", lwd = 2)
    # points(cad_input, model1pred(), col = "red", pch = 5, cex = 2, lwd = 10)
  })
    
    output$pred1 <- renderText({
      model1pred() # model1 prediction
  })
})

# Reference:
# https://deanattali.com/blog/building-shiny-apps-tutorial/#4-load-the-dataset
# https://shiny.rstudio.com/articles/shinyapps.html
# https://support.rstudio.com/hc/en-us/articles/220339568-What-does-Disconnected-from-Server-mean-in-shinyapps-io-
