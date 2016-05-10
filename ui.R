#' Project: project-app
#' File: ui.R
#' This applications creates a webapp that displays the result of fitting a 
#' linear model to the mtcars datasets. The model uses mpg as an outcome and at
#' least one variable as a predicor.
#' The user is allowed to control the number of predictors and the detail for 
#' the model summary report.
#' In addition, the output also plots the 4 residual graphs for the model.

library(shiny)

shinyUI(fluidPage(
    
    # Application title
    titlePanel(title=h1("Data Products Project",align="center")),
    
    # The application uses a sidebarlayout with user buttons on the left side.
    sidebarLayout(
        
        sidebarPanel(
            # Multiple checkbox for the list of predictors
            # If no predictors are selected, then lm will throw an error so
            # no special logic to handle this case.
            checkboxGroupInput("checkGroup", label = h4("Please select features"), 
                               choices = list("Num of cylinders" = "cyl", 
                                              "Horsepower" = "hp", 
                                              "Weight (1000 lbs)" = "wt",
                                              "Auto Transmission*" = "am",
                                              "Displacement" = "disp",
                                              "Rear axle ratio" = "drat",
                                              "1/4 mile time" = "qsec",
                                              "V/S" = "vs",
                                              "Num of forward gears" = "gear",
                                              "Num of carburetors" = "carb"
                                              ),
                               selected = "cyl"),
            br(),
            # Select the level of detail for the summary
            selectInput("reptype", label=h4("Summary Type"),
                        choices = list("All"=1,
                                       "Coefficients"=2,
                                       "Residuals"=3,
                                       "R-Squared"=4),
                        selected = 1
                        ),
            submitButton("Submit"),
            br(),
            p("If automatic transmission is not selected, model will be based on manual transmission.")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            h2("Linear Regression Model for Mileage (miles per gallon)"),
            h3("For Motor Trend Car Road Tests"),
            br(),
            
            # Prints out the LM formula
            strong("LM Formula"),
            textOutput("form"),
            
            # Prints out the summary based on user choice
            strong("Summary of LM Results"),
            verbatimTextOutput("value"),
            br(),
            
            # Displays the graph
            strong("Residuals plot for model"),
            plotOutput("plot")
        )
    )
))
