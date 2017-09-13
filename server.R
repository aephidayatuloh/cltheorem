
library(shiny)
library(colourpicker)

shinyServer(function(input, output, session){
  d <- reactive({
    x <- switch(input$distribution,
                "Uniform" = runif(n = input$n,
                                  min = input$min,
                                  max = input$max),
                "Binomial" = rbinom(n = input$n,
                                    size = input$size,
                                    prob = input$p),
                "Normal" = rnorm(n = input$n,
                                 mean = input$mean,
                                 sd = input$sd)
    )
    return(x)
  })
  
  output$summaries <- renderTable({
    x <- d()
    Distribution <- input$distribution
    SampleSize <- input$n
    data.frame(Distribution, SampleSize, mean = mean(x), std = sd(x))
  })
  
  output$myplot <- renderPlot({
    x <- d()
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, freq = F, col = input$cols)
    lines(density(x), col="red", lwd=1) # add a density 
  })
}
  
)