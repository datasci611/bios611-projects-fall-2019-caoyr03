## Project Name

Urban Ministries of Durham Data Exploration

## Dataset

The dataset was provided by UMD services which assist 6,000 homeless people each year with food, shelter, clothing and/or supportive services. Basic features included in the dataset are: family identifier(single or family), bus tickets, food provided for(# of people), food pound, clothing, diapers, school kits, hygiene kits, and financial support. The year ranges from 1931~2022 from which we only take 2008 ~ 2019 as effective data for analysis.

## Research Question

1.How average food providing per capital has changed?
The primary question is how the resources(food) provided by UMD have changed with time.
2.What's the relationship between food provide and diapers?
Correlation problem whether diapers has positive relationship with food provide per household are also considered.

## Research Variable

I will work on the variables of family identifier, food provided ratio/person, and diapers.

## Method

ggplot2, tidyverse will be used to visualize the dataset and preview the relationship between variables in dataset.
For data preparation, food.per.capita needed to be calculated based on headcounts food provided for and its amount. 
Outliers, missing data, ineffective data will be removed. 
