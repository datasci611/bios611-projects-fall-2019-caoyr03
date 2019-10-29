#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(DT)
library(shiny)
library(tidyverse)
library(dplyr)
library(shinydashboard)
library(qwraps2)

library(rsconnect)


#setwd('/Users/caoyuru/Desktop/BIOS 611/project2/UMDdata')
source("helper_functions.R")
#rsconnect::deployApp(server='shinyapps.io')

data = read_and_clean('UMD_Services_Provided_20190719.tsv')

# Define UI for app that draws a histogram and a data table----
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Introduction", tabName = "background",icon = icon("home")),
    menuItem("Goals", tabName = "goals", icon = icon("star")),
    menuItem("Data Source", tabName = "data", icon = icon("database")),
    menuItem("Analysis Dashboard",icon = icon("chart-bar"),startExpanded = TRUE,
      menuSubItem("Service Count by Year", tabName = "dashboard", icon = icon("bullet")),
      menuSubItem("Client Distribution", tabName = "client", icon = icon("bullet"))
    )
    
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = 'dashboard',
            fluidPage(
              sidebarLayout(
                sidebarPanel(
                  h5('Please select a type of service and range of year to show data'),
                  # Select option box for service types
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
                              value = c(2000, 2019)),
                  
                  verbatimTextOutput('note')
                ),
                mainPanel(
                  plotOutput(outputId = 'pplot'),
                  dataTableOutput(outputId = "table"))
              )
            )
    ),
    tabItem(tabName = 'client',
            fluidPage(
              sidebarLayout(
                sidebarPanel(
                  h5('Please select a type of service to show client distribution:'),
                  selectInput(inputId = 'typeservice', 
                              label = 'Service Type',
                              choices = c('Food' = 'Food.Pounds',
                                          'Bus Tickets' = 'Bus.Tickets..Number.of.',
                                          'Clothing' = 'Clothing.Items',
                                          'Diapers' = 'Diapers',
                                          'School Kits' = 'School.Kits',
                                          'Hygiene Kits' = 'Hygiene.Kits',
                                          'Financial Support' = 'Financial.Support')),
                
                  h5('Here provide a pie chart and bar chart of how long and how many percentage of clients benefited from this type stick to this service.')
                ),
                  
                  mainPanel(
                    plotOutput(outputId = 'chart'),
                    plotOutput(outputId = 'bar')
                  )
                )
              )
            ),
                  
    
    tabItem(tabName = 'background',
            htmlOutput('org')),
    
    tabItem(tabName = 'goals',
            htmlOutput('gol')),
    
    tabItem(tabName = 'data',
            htmlOutput('dat'),
            dataTableOutput(outputId = "dataset"))
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
  output$table = renderDataTable(table_helper(data, input$service_type, input$year_range[1], input$year_range[2]),options=list(pageLength=5))
  output$org = renderUI({HTML('<h2>Background</h2><br/><ul><li>Urban Ministries of Durham (UMD):</li></ul>UMD is a non-profit organization aims to end homelessness and to meet urgent needs of those in hunger and poor. 
                              <br/>They offer food, shelter and future to about 6,000 men, women and children annually.')})
  output$gol = renderUI({HTML('<h2>Project Scope</h2><br/><ul><li>Targeting audience:</li></ul>1. the potential sponsors for UMD<br/>2. people who might need help from UMD<br/>
                              They are mainly concerned with the services quality and trend of service it is providing.<br/><br/>
                              <ul><li>Research Question:</li></ul> How did the services provided by UMD change overtime?<br/><br/>
                              <ul><li>Restrictions:</li></ul>Ideally they may want to know about who UMD is benefiting but this dataset could only offer a primary insight into their visiting pattern.
                              The types of services are provided.')})
  output$dat = renderUI({HTML('<h2>Dataset Overview</h2><br/>The dataset was provided by UMD services which assist 6,000 homeless people each year with food, shelter, clothing and/or supportive services. <br/>
                              Basic features included in the dataset are: family identifier(single or family), bus tickets, food provided for(# of people), food pound, clothing, diapers, school kits, hygiene kits, and financial support.<br/> 
                              UMD provided 54,378 nights of shelter to homeless neighbors (792 unique individuals) and ended homelessness for 243 individuals. Also, they provided over 500 households with clothing and groceries monthly.<br/><br/>')})
  output$dataset = DT::renderDataTable({DT::datatable(data,options = list(searching=FALSE),rownames= FALSE,colnames=c('Date of occurance','ID','Number of Bus Ticket','Food Provided for','Food Pounds','Clothing Items','Diapers','School Kits','Hygiene Kits','Financial Services','Year'))})
  output$note = renderPrint({
    des = table_helper(data, input$service_type, input$year_range[1], input$year_range[2])
    summary(des)
  })
  output$chart = renderPlot(chart_helper(data, input$typeservice))
  output$bar = renderPlot(chart_builder(data, input$typeservice))
}      


shinyApp(ui = ui, server = server)




