library(dplyr)
library(shiny)
library(DiagrammeR)
library(networkD3)


list_initiators <- read.csv("https://raw.githubusercontent.com/Okssana/shiny_app_network/master/nodes_amends_29_09_2020.csv", 
                            fileEncoding = "Windows-1251") %>%
  select(-X)

edges_for_gephy <- read.csv("https://raw.githubusercontent.com/Okssana/shiny_app_network/master/edges_amends_29_09_2020.csv") %>% 
  select(-X)


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      
      sliderInput("amends_connection",
                  "Кількість поданих спільно поправок",
                  min = 1, 
                  max = 15,
                  value = 5)),
    
    mainPanel(forceNetworkOutput("network_amends")
    )
  )
)
