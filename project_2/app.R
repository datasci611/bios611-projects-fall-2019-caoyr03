library(shiny)
library(tidyverse)
library(dplyr)
library(shinydashboard)

library(rsconnect)


#setwd('/Users/caoyuru/Desktop/BIOS 611/project2/UMDdata')
source("helper_functions.R")
#rsconnect::deployApp(server='shinyapps.io')

data = read_and_clean('UMD_Services_Provided_20190719.tsv')

# Define UI for app that draws a histogram and a data table----
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Background", tabName = "background",icon = icon("Background")),
    menuItem("Analysis Dashboard", tabName = "dashboard",icon = icon("Purpose"))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = 'dashboard',
            fluidPage(
              sidebarLayout(
                sidebarPanel(
                  selectInput(inputId = 'service_type', 
                              label = 'Service Type',
                              choices = c('Food' = 'Food.Pounds',
                                          'Bus Tickets' = 'Bus.Tickets..Number.of.',
                                          'Clothing' = 'Clothing.Items',
                                          'Diapers' = 'Diapers',
                                          'School Kits' = 'School.Kits',
                                          'Hygiene Kits' = 'Hygiene.Kits',
                                          'Financial Support' = 'Financial.Support')),
                  # Select bin for year range of services
                  sliderInput(inputId = 'year_range',
                              label = 'Year Range',
                              min = 2000,
                              max = 2019,
                              value = c(2000, 2019))
                ),
                mainPanel(
                  plotOutput(outputId = 'pplot'),
                  dataTableOutput(outputId = "table"))
              )
            )
    ),
    
    tabItem(tabName = 'background',
            htmlOutput('org'))
  )
)




# Put them together into a dashboardPage
ui <- dashboardPage(
  dashboardHeader(title = "UMD Data Exploration"),
  sidebar,
  body
)


# Define server logic required to draw a histogram ----
server <- function(input, output){
  output$pplot = renderPlot(pplot_helper(data, input$service_type, input$year_range[1], input$year_range[2]))
  output$table = renderDataTable(table_helper(data, input$service_type, input$year_range[1], input$year_range[2]))
  output$comment = renderPrint({helper(data, input$service_type, input$year_range[1], input$year_range[2])})
  output$org = renderUI({HTML('<h2>Urban Ministries of Durham:</h2><br/>UMD is a non-profit organization aims to end homelessness and to meet urgent needs of those in hunger and poor 
                              <br/>They offer food, shelter and future to about 6,000 men, women and children annually')})
}      


shinyApp(ui = ui, server = server)





