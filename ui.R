#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  titlePanel("Predict Average Running Pace from Average Cadence"),
  sidebarLayout(
    sidebarPanel(
      # slider, two checkboxes
      sliderInput("slider_cad", "What is your target running cadence (strides per minute)?", 100, 200, value = 180),
      sliderInput("slider_elev", "What is your target elevation gain (meters)?", 0, 500, value = 100)
#     submitButton("Submit") # delayed reactivity
    ),
    mainPanel(
      # from server, we get a plot and two texts
      plotOutput("plot1"),
      h3("Predicted Average Pace (seconds per km):"),
      textOutput("pred1"),
      h3("R Squared (variance explained by predictor):"),
      textOutput("pred2")
    )
  )
))