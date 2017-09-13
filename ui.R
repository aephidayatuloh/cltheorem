#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(colourpicker)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  # titlePanel("Old Faithful Geyser Data"),
  headerPanel("Central Limit Theorem"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId="distribution", label = "Choose the distribution:", 
                  choices = c("Uniform", "Binomial", "Normal")),
      sliderInput(inputId = "n", label = "Choose the sample size:", min = 10, max = 1000, step = 10, value = 30),
      sliderInput(inputId = "bins", label = "Number of bins:", min = 1, max = 50, value = 30),
      conditionalPanel(condition = "input.distribution == 'Uniform'",
                       numericInput(inputId = "min", "Minimum:", value = 0, min = 0, max = 1000),
                       numericInput(inputId = "max", "Maximum:", value = 1, min = 0, max = 1000)),
      conditionalPanel(condition = "input.distribution == 'Binomial'",
                       numericInput(inputId = "size", label = "Size:", min = 0, max = 1000, value = 1, step = 1),
                       sliderInput(inputId = "p", label = "Probability:", value = 0.5, min = 0, max = 1)),
      conditionalPanel(condition = "input.distribution == 'Normal'",
                       numericInput(inputId = "mean", label = "Mean:", value = 0, min = 0, max = 10, step = 0.5),
                       numericInput(inputId = "sd", label = "Standard Deviation:", value = 1, min = 0, max = 10, step = 0.1)),
      colourInput(inputId = "cols", label = "Choose Colour:", value = "white", allowTransparent = TRUE)
      ),
    # Show a plot of the generated distribution
    mainPanel(
      tableOutput("summaries"),
      plotOutput('myplot'),
      plotOutput("density")
    )
  )
))