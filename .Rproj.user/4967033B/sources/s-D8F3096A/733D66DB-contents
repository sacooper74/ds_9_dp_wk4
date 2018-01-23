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
  titlePanel("Predict Running Average Pace from Average Cadence"),
  sidebarLayout(
    sidebarPanel(
      # slider, two checkboxes
      sliderInput("slider_cad", "What is your average Cadence (spm)?", 100, 200, value = 180)
#     submitButton("Submit") # delayed reactivity
    ),
    mainPanel(
      # from server, we get a plot and two texts
      plotOutput("plot1"),
      h3("Predicted Average Pace (seconds per km):"),
      textOutput("pred1")
    )
  )
))