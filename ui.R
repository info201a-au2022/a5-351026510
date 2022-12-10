library(tidyverse)
library(shiny)
library(plotly)

co2 <- read.csv("owid-co2-data.csv")
co2_avg <- round(mean(co2$co2[co2$year==max(co2$year)], na.rm=T), 2)
co2_per_capita_avg <- round(mean(co2$co2_per_capita[co2$year==max(co2$year)], na.rm=T), 2)
co2_per_unit_energy <- round(mean(co2$co2_per_unit_energy[co2$year== max(co2$year)], na.rm=T), 2)

ui <- navbarPage("CO2 Emission",
    tabPanel("Introduction",
          h2("Data Description"),
          p("This visualization will focus on the CO2 emission situations of the top three countries that have the largest population, which are China, India, and the United States. Specifically, their CO2 emission, CO2 per unit energy, and CO2 per capita will be shown in the interactive visualization, as well as the analysis of their patterns. The measure of C02 is million tonnes."),
          p(paste0('The average CO2 across all the countries in ', max(co2$year), " is ", co2_avg, 
                   " million tonnes, the average amount of CO02 is released to produce electricity is ", co2_per_unit_energy, 
                   " CO2 per unit of energy, and the average of the total emissions divided by population is ",
                   co2_per_capita_avg, " CO2 per capita."))
    ),
    tabPanel("Interactive Visualization",
        sidebarLayout(
          sidebarPanel(
            selectInput("country", "Country:",
                        choices = c("United States", "China", "India"),
                        selected="China", multiple=T),
            radioButtons(inputId = "var",
                        label = "Variable:",
                        choices = c("co2", "co2_per_unit_energy", "co2_per_capita"),
                        selected = "co2")
            
            
          ),
          mainPanel(
            plotlyOutput(outputId = "plot"),
            p("The above visualization shows the overall CO2 emission, CO2 per unit energy, and CO2 per capita situations of all three countries with the largest populations in the world.The visualization gives insight into the trend of a country’s CO2 emissions and the relationships with its energy or population. In both China and India, the CO2 emissions present rising trends; whereas , the CO2 emission of the U.S. started to decrease in 2005. Despite the huge increase in CO02 emissions, all countries have decreasing trends for their CO2 per unit energy, which could indicate a global electricity consumption increase. A decline in CO2 per capita suggests that the U.S. may have an increasing CO02 emission and/or a decreasing population, which could be opposite situations for India and China.")
          )
        )         
    )
)
