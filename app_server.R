library(tidyverse)
library(shiny)
library(plotly)

server <- function(input, output) {
  output$plot <- renderPlotly({
    df <- co2 %>% filter(country %in% input$country)
    df <- df[, c("year", "country", input$var)]
    df <- na.omit(df)
    req(nrow(df)>0)
    ggplot(df, aes_string(x="year", y=input$var, color="country")) + geom_line() +
      labs(x="Year", y=str_replace_all(input$var, "_", " ")) 
  })
  
}