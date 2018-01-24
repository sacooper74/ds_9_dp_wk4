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
  runlog$pace_num <- as.numeric(as.POSIXct(runlog$AvgPace, "%M:%S", tz = GMT))

  # linear model to predict average pace based upon average cadence and elevation gain
  model1 <- lm(pace_num ~ AvgCadence + ElevGain, data = runlog)
  # model1$coefficients

  # Perform the prediction in a reactive function
  model1pred <- reactive({
    cad_input <- input$slider_cad
    elev_input <- input$slider_elev
    predict(model1, newdata = data.frame(AvgCadence = cad_input, ElevGain = elev_input))
  })
  
  # Output the plot
  output$plot1 <- renderPlot({
    cad_input <- input$slider_cad
    elev_input <- input$slider_elev
    
    runlog %>%
      ggplot(mapping = aes(AvgPace, AvgCadence)) +
      geom_point(mapping = aes(color = ElevGain)) +
      # scale_colour_gradient2() +
      # geom_abline(intercept = model1$coefficients[1], slope = model1$coefficients[2]) +
      geom_smooth(method = "lm") +
      geom_point(mapping = aes(model1pred(), cad_input), size = 3, colour = "red", alpha = 0.4)
    
  })
    
    output$pred1 <- renderText({
      model1pred() # model1 prediction
  })
    output$pred2 <- renderText({
      summary(model1)$adj.r.squared # r squared of model
    })
})
