##This is code for Week 4 homework
##by: Solimar Carrasquillo Ho
##created: 2024-09-24
##last modified: 2024-09-24

#load libraries
library(tidyverse)
library(here)
library(praise)
library(ggplot2)

#load & view data
chemdata <- read.csv(here("Week_04", "Data","chemicaldata_maunalua.csv"))
glimpse(chemdata)
view(chemdata)

##data analysis 

#remove all NAs from dataset
#separate tide and time columns & delete old column
chemdata_clean <- chemdata%>%
  drop_na()%>%
  separate(col = Tide_time,
           into = c("Tide", "Time"),
           sep = "_",
           remove = FALSE)
head(chemdata_clean)

#change data set to long
chemdata_long <-chemdata_clean%>%
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values")
view(chemdata_long)

#change data set to wide
chemdata_wide <-chemdata_long %>%
  pivot_wider(names_from = Variables,
              values_from = Values)
view(chemdata_wide)

#summary statistics
chemdata_wide <-chemdata_long %>%
  drop_na()%>%
  separate(col = Tide_time, #selects tide_time column
           into = c("Tide", "Time"), #makes two new columns
           sep = "_", 
           remove = FALSE) %>%
  select(c(Salinity, Site, Season, Tide, Time, pH)) %>%
  pivot_wider(cols = pH:Salinity,
              names_to = "Salinity",
              values_to = "Values") %>%
  group_by(Site, Season, Tide, Time) %>%
  summarise(mean_sal = mean(Values),
            var_sal = var(Values)) %>% 
  pivot_wider(names_from = Variables,
              values_from = Values)
  write_csv(here("Week_04", "Output", "Week_04_homework_summary.csv"))


#now let's make a graph! yay :-) 
  ggplot(chemdata_wide, 
         mapping = aes(x = Site, y = Salinity)) +
    scale_color_viridis_d() +
    geom_violin() +
    facet_wrap(~Season) +
    labs(title = "Maunalua Bay Salinity",
         x = "Site",
         y ="Salinity",
         color = "Season") + theme_bw()
  
  #change color & color 
  ggplot(chemdata_wide, 
         mapping = aes(x = Site, y = Salinity,
                       fill = Season)) +
    scale_color_viridis_d() +
    geom_violin() +
    facet_wrap(~Season) +
    labs(title = "Maunalua Bay Salinity",
         x = "Site",
         y ="Salinity")

  #save ggplot pdf
  ggsave(here("Week_04", "Output", "Week_04_homework_graph.pdf"),
         width = 7, height = 5)  
  

  
  