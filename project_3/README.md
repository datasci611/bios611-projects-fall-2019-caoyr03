## Background

Urban Ministries of Durham (UMD) is
a non-profit organization aims to end homelessness and to meet urgent needs of those in hunger and poor.
They offers food, shelter and future to about 6,000 men, women and children annually. Partly their program does includes:
* Help prevent homelessness by providing food and clothing to offset living expenses and by referring guests to others in the community who may be able to provide additional help;
* Assist those who are homeless by providing emergency shelter, stabilization assistance such as recovery programs and medical referrals, and  to help them connect with the resources that will enable them to return to stable housing as quickly as possible;
* Foster collaboration with community partners so that coordinated efforts can provide needed  longer term housing and supportive service needs; and
* Offer support with dignity and compassion to neighbors in need, regardless of their ability to leave homelessness at the time.

## Project Scope

For this project, target audience are the potential sponsors for UMD and the management in UMD organizatino. They are mainly concerned with the demographis and related service records of their clients. We helped the identified several patterns for their consideration: 1) Who are those short-term clients vs. those loyal long-term clients? 2) What are the time series patterns for those who receive help from UMD to exit program? 3) The health/living conditions of clients 4) Prior living conditions vs Destination after they exit

## Method

This analysis will rely on Python to clean and wrangle data, R to visualize data, Docker to contain requisite dependencies, and Make for reproducitility.

## Dataset

The dataset was provided by UMD services databases which were extracted in November, 2019. We used three datatable for this project which included:
* CLIENT_191102.tsv 
* EE_UDES_191102.tsv 
* ENTRY_EXIT_191102.tsv 

## Research Variable

Service Unique ID, Client Unique ID,Client Primary Race, Client ethnicity, Client Veteran Status, Prior Living Situation, Housing Status, Disability condition, Health Insurance condition, Domestic violance victim, Date of Birth, Destination, Reason for Leaving

## To run the project
1. Git clone https://github.com/datasci611/bios611-projects-fall-2019-caoyr03.git
2. Navigate to bios611-projects-fall-2019-caoyr03/project_3
3. Run 'Make' command

