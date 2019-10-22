read_and_clean = function(file_path){
  
  # Read in the dataset
  data = read.csv(file_path,sep="\t")[,-c(14,15,16,17,18)] %>%
    # Filter year between 2000 to 2019
    mutate(Date = as.Date(Date,format="%m/%d/%Y")) %>%
    mutate(Year = as.integer(format(Date,"%Y"))) %>%
    filter(Year <= 2019 & Year >= 2000)
  return(data)
}

pplot_helper = function(data, type, starty, endy){
  # Wrangle the data into Year and Type of service
  data_plot = data %>% 
    filter(Year >= starty & Year <= endy) %>%
    select(Year, type) %>%
    na.omit() %>%
    group_by(Year) %>%
    summarise(Count = n()) 
  
  # Histogram data with trend line
  ggplot(data = data_plot, aes(Year)) +
    geom_bar(aes(weight = Count)) +
    geom_smooth(aes(y = Count)) +
    ggtitle('Total counts of different services each year ')
  }

table_helper = function(data, type, starty, endy){
  # Wrangle the data into Year and Type of service
  data_plot = data %>% 
    filter(Year >= starty & Year <= endy) %>%
    select(Year, type) %>%
    na.omit() %>%
    group_by(Year) %>%
    summarise(Count = n()) 
  
  return (data_plot)
}
helper = function(data,type, starty, endy){

  return(data_plot)
}
