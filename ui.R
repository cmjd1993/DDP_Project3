library(shiny)
library(plotly)

shinyUI(fluidPage(
  
  # Give title to my app
  titlePanel("US Arrests for Violent Crimes in 1973 by State"),
  

fluidRow(
    # add help text to add context to map
    helpText("The data is taken from the USArrets dataset from the datasets package in R.
             Select a violent crime to see the number of arrests per 100,000 people. 
             Move your mouse over each state to see the individual state rate."),
    
    # add a select input to split the data
    selectInput("crime", "Crime Type", choices = c("Murder","Assault", "Rape"), selected = "Murder")
),
    # ensure that the output is plotly or else it will return a non interactive plot
  mainPanel(
    plotlyOutput("plot",  width = 850, height = 600)
    )
  )
  )
   
  
  

