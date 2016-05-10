#' Project: project-app
#' File: server.R
#' This applications creates a webapp that displays the result of fitting a 
#' linear model to the mtcars datasets. The model uses mpg as an outcome and at
#' least one variable as a predicor.
#' The user is allowed to control the number of predictors and the detail for 
#' the model summary report.
#' In addition, the output also plots the 4 residual graphs for the model.

library(shiny)

shinyServer(function(input, output) {
    # loads the data
    data(mtcars)
    
    # Reactive function to create the formula as a single text string
    getformula <- reactive({
        tmp <- paste("mpg~",paste(input$checkGroup,collapse="+"),sep="")
        print(tmp)
    })
    
    # Reactive function to run the lm modelling
    getlm <- reactive({
        # fit is assigned as a global variable
        fit <<- lm(as.formula(getformula()), data=mtcars)
    })
    
    # Reactive function to plot graphs
    getPlot <- reactive({
        par(mfrow=c(2,2),mar=c(2,2,2,2))
        plot(getlm())
    })
    
    # Output the formula
    output$form <- renderPrint(getformula())
    
    # Output the summary based on user option
    output$value <- renderPrint({
        if(as.numeric(input$reptype)==1)
            summary(getlm())
        else if(as.numeric(input$reptype)==2)
            summary(getlm())$coefficients
        else if(as.numeric(input$reptype)==3)
            summary(getlm())$residuals
        else if(as.numeric(input$reptype)==4)
            summary(getlm())$r.squared
        })
    
    # Output the plot
    output$plot <- renderPlot(getPlot())
})
