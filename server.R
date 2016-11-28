library(shiny)
library(mapproj)
library(maps)
library(ggplot2)
library(datasets)
library(plotly)

# load data
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)


# create function called "myplot" which will create the plot that will change for each 
# different crime type. 

myplot <-  function(type, pal){
  
  # get a states map
  states_map <- map_data("state")
  
  # will return the correct rate
  Arrests <- type[,2]
  
  # create plot of states using ggplot2 initially, name it "g" 
  
  g <- ggplot(type, aes(map_id = state)) +
    geom_map(map = states_map, aes(fill = Arrests)) +
    scale_fill_gradient2(low = "floralwhite", high = pal) +
    expand_limits(x = states_map$long, y = states_map$lat) +
    coord_map("polyconic") +
    theme(
      axis.ticks=element_blank(),
      axis.title=element_blank(),
      axis.text=element_blank(),
      panel.grid=element_blank(),
      panel.background = element_rect(fill = "white"))
  
  # use ggplotly to transform ggplot into a plotly plot
  ggplotly(g)
  
}

shinyServer(function(input, output) {
  
  # render plotly plot using renderPlotly()
  output$plot <- renderPlotly({
    
    # create "type" and "pal" that will create a reactive map with each crime type selected. 
    # Use with switch() command to acheive this.
    
    
    type <- switch(input$crime,
                   "Murder" = crimes[,c("state", "Murder")],
                   "Assault" = crimes[,c("state", "Assault")],
                   "Rape" = crimes[,c("state", "Rape")])
   
    
     pal <- switch(input$crime,
                    "Murder" = "orangered4",
                    "Assault" = "violetred4",
                    "Rape" = "darkblue")
    
    # run map function
    myplot(type, pal)
  
  }) 
   

  })

    

