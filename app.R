library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(tidyverse)
library(DT)
library(highcharter)

header <- dashboardHeaderPlus(
  titleWidth = 380,
  title = shiny::tagList(
    span(class = "logo-lg", 
         span(shiny::img(src = "logo.png",  height = "32", width = "32"),
              "International Housing Observatory")), 
    shiny::img(src = "logo.png",  height = "32", width = "32")
  )
)

sidebar <- 
  dashboardSidebar(
    collapsed = TRUE,
    sidebarMenu(
      id = "tabs", 
      menuItem("Financial Stability", tabName = "exuberance", icon = icon("chart-area")),
      menuItem(HTML('Uncertainty'), tabName = "uncertainty", icon = icon("underline")),
      menuItem("New House Price Indices", tabName = "indices", icon = icon("tv"), selected = TRUE), #house-damage
      menuItem("Download Data", icon = icon("download"), tabName = "download"),
      HTML('<li> <div class="line"></div></li> '),
      HTML('<li style = "position:absolute; padding-right:1rem; bottom:0; color:grey; font-size:12px;"> 
         <p> @ UKHO </p> </li>')
      )
    )

body <- dashboardBody(
  tabItems(
    source("ui/exuberance.R", local = TRUE)$value,
    source("ui/indices.R", local = TRUE)$value
    # source("ui/uncertainty.R", local = TRUE)$value
  )
)

server <- function(session, input, output) {
  
}

shinyApp(
  ui = , 
  server)