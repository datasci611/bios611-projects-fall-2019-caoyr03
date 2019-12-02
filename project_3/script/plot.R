library(ggplot2)
library(tidyverse)
library(dplyr)
data <- read_csv('/Users/caoyuru/Desktop/BIOS 611/project/bios611-projects-fall-2019-caoyr03/project_3/data/wrangle_data.csv') %>%
  select(-1)

# Wrangle the dataset group by Client while keeping other columns
client <- data %>%
  select(ClientID, Entrydate, Exitdate, Age_entry, Gender, Race, Ethnicity, Veteran) %>%
  mutate(Duration = as.Date(Exitdate,format="%m/%d/%Y") - as.Date(Entrydate,format="%m/%d/%Y")) %>%
  na.omit() %>%
  group_by(ClientID,Entrydate, Exitdate, Age_entry, Gender, Race, Ethnicity, Veteran) %>%
  summarise(Duration = sum(Duration))
# 1.age distribution with duration
age <- client[c('Duration','Age_entry','ClientID')] %>%
  group_by(Duration) %>%
  summarize(age = mean(Age_entry))
# plot
ggplot(age, aes(x=Duration,y=age)) +
  geom_point()
ggsave('../results/age_duration.png')
# 2.race distribution with duration
race <- client[c('Duration','Race')] %>%
  group_by(Duration,Race) %>%
  summarise(count = n())
# plot
ggplot(race, aes(x = Duration, fill=Race))+
  geom_bar(position = "fill")
ggsave('../results/race_duration.png')
# 3. gender distribution with duration
gender <- client[c('Duration','Gender')] %>%
  group_by(Duration,Gender) %>%
  summarise(count=n())
# plot
ggplot(gender, aes(x = Duration, fill = Gender)) +
  geom_bar(position = "fill")
ggsave('../results/gender_duration.png')
# 4. ethnicity distribution with duration
ethnicity <- client[c('Duration','Ethnicity')] %>%
  group_by(Duration, Ethnicity) %>%
  summarise(count=n())
# plot
ggplot(ethnicity, aes(x = Duration, fill = Ethnicity)) + 
  geom_bar(position = "fill")
ggsave('../results/ethnicity_duration.png')

# Converting the datetime variable
exit <- data %>%
  select(Exitdate, ClientID, Reason)
exit$Exitdate <- as.Date(exit$Exitdate,format="%m/%d/%Y")
# Picking 10 days as break points
ggplot(exit, aes(x=Exitdate, fill = Reason)) + 
  geom_histogram(binwidth=10)
ggsave('../results/reason_hist.png')

# Create a table by counts of these three variables
count <- data[c('Disability','HealthInsurance','ViolanceVictim')] %>% 
  gather(Category, Count) %>%
  table()
count
# Converting categorical data into numerical variable to do correlation matrix
data_new = drop_na(data)
data_new$HealthInsurance[data_new$HealthInsurance == 'Yes'] <- 1
data_new$HealthInsurance[data_new$HealthInsurance == 'No'] <- 0
data_new$HealthInsurance = as.numeric(data_new$HealthInsurance)
data_new$Disability[data_new$Disability == 'Yes'] <- 1
data_new$Disability[data_new$Disability == 'No'] <- 0
data_new$Disability = as.numeric(data_new$Disability)
data_new$ViolanceVictim[data_new$ViolanceVictim  == 'Yes'] <- 1
data_new$ViolanceVictim[data_new$ViolanceVictim == 'No']<- 0
data_new$ViolanceVictim = as.numeric(data_new$ViolanceVictim)

cor(na.omit(data_new[c('Disability','HealthInsurance','ViolanceVictim')]))

# Draw a histogram between living condition and destination
ggplot(data, aes(x=LivingSituation, fill = Destination)) + 
  geom_histogram(stat='count') + 
  theme(axis.text.x=element_text(angle=90, hjust=1, vjust=0.5),
        text=element_text(size=5),
        legend.position="bottom")
ggsave('../results/living_destination.png',width = 20, height = 20)
