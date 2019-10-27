Project URL:
https://caoyr03.shinyapps.io/umddata/

## Dataset

The dataset was provided by UMD services which assist 6,000 homeless people each year with food, shelter, clothing and/or supportive services. Basic features included in the dataset are: family identifier(single or family), bus tickets, food provided for(# of people), food pound, clothing, diapers, school kits, hygiene kits, and financial support. The year ranges from 1931~2022 from which we only take 2000 ~ 2019 as effective data for analysis and visualizaton.

The database description listed as follows:
* Bus Tickets (Number of): Service discontinued
* Notes of Service: 
* Food Provided for:  Number of people in the family for which food was provided
* Food Pounds: Number of pounds of food that each individual or family received when shopping at UMD food pantry
* Clothing Items: Number of clothing items received per family or individual
* Diapers: Number of packs of diapers received (individuals/families are given 2 packs of diapers per child, and packs contain 22 diapers on average)
* School Kits
* Hygiene Kits: Number of kits received per individual or family. Kits contain soap, shampoo, conditioner, lotion, deodorant, a toothbrush, toothpaste, a washcloth, a disposable razor, and a bottle of shaving cream.
* Financial Support: Money provided. Service discontinued

## Project Scope

For this project, targeting audience are the potential sponsors for UMD or people who might need help from UMD. We will focus on the following question: How did the services provided by UMD change overtime? They are mainly concerned with the services quality and trend of service it is providing. Ideally they may want to know about who UMD is benefiting but this dataset could only offer a primary insight into their visiting pattern. The types of services are provided.

## Research Variable

I will work on the variables of family identifier, food provided, and diapers, clothing, school kits, higiene kits, and financial support. 

## Method

ggplot2, tidyverse will be used to visualize the dataset and preview the relationship between variables in dataset.
Outliers, missing data, ineffective data will be removed. 
R shiny will be implemented to give a interactive visualization dashboard for users. Date of range, Types of services will be provided as input. A time-series graph will show the trend line of services provided.

