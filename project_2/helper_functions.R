read_and_clean = function(file_path){
  
  # Read in the dataset
  data = read.csv(file_path,sep="\t")[,-c(3,5,12,14,15,16,17,18)] %>%
    # Filter year between 2000 to 2019
    mutate(Date = as.Date(Date,format="%m/%d/%Y")) %>%
    mutate(Year = as.integer(format(Date,"%Y"))) %>%
    filter(Year <= 2019 & Year >= 2000)
  return(data)
}

pplot_helper = function(data, type, starty, endy){
  # Wrangle the data into Year and Type of service
  data_plot = table_helper(data, type, starty, endy)
  
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
chart_helper = function(data, type){
  client.duration<- data %>%
    select(Year, type, Client.File.Number) %>%
    na.omit() %>%
    group_by(Client.File.Number) %>% 
    summarize(Duration=max(Year)-min(Year))
  
  client.duration$Duration[client.duration$Duration >3] = '>3'
  client.duration$Duration[client.duration$Duration <= 3 & client.duration$Duration > 1] = '1~3'
  client.duration$Duration[client.duration$Duration <= 1] = '<1'
  chart <- client.duration %>% 
    group_by(Duration) %>%
    summarise(Count = n()) %>%
    mutate(per = paste0(round(100*Count/sum(Count),2),'%'))
  
  ggplot(chart,aes(x = '',y = per, fill = Duration))+
    geom_bar(stat = "identity",width=1) +
    labs(x = NULL, y = 'Percentage of clients', fill = 'Duration (years)') +
    coord_polar() +
    ggtitle('Client- Duration Distribution')
}

chart_builder = function(data, type){
  client.assistance <-data %>%
    select(Date, type, Client.File.Number) %>%
    na.omit() %>%
    group_by(Client.File.Number) %>%
    summarize(First = min(Date),Last=max(Date)) %>%
    filter(First==Last)
  
  client.back <- data %>%
    select(Date, type, Client.File.Number) %>%
    na.omit() %>%
    group_by(Client.File.Number) %>%
    summarize(First = min(Date),Last=max(Date)) %>%
    filter(First!=Last)
  
  chart <- data.frame('Client'=c('New Client','Visited Client'),'Number'=c(nrow(client.assistance),nrow(client.back)))
  ggplot(chart, aes(x='', y = Number, fill = Client)) +
    geom_bar(stat = 'identity',width =1) +
    labs(x = NULL, y = 'Number of clients', title = 'Client Category')
}
