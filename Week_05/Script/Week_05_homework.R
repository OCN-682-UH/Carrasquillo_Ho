##This is code for Week 5 homework script
##by: Solimar Carrasquillo Ho
##created: 2024-09-30
##last modified: 2024-09-30

###load libraries 
library(tidyverse)
library(here)
library(lubridate) #package that deals with date and times
library(devtools)
library(ggplot2)
library(wesanderson)


#homework to-do list

#1. read in conductivity data
#2. convert date columns
#3. round conductivity data to nearest 10 seconds to match depth data
#4. join two dataframes together (no NAs, and where exact matches btwn dataframes are kept)
#5. average date, depth, temp, and salinity by minute
#6. make any plot using averaged data
#7. do the entire thing mostly pipes %>%
#8. make comments
#9. save output, data, scripts appropriately 

###load data
conduct <- read.csv(here("Week_05", "Data", "CondData.csv"))
depth <- read.csv(here("Week_05", "Data", "DepthData.csv")) 
view(conduct)
view(depth)


#----Data Analysis----

#check if conductivity date is a character
#yes!
is.character(conduct$date)
  
#convert conduct new date and round to 10 sec
conduct_df <- conduct %>%
  mutate(date = mdy_hms(date)) %>%
  mutate(date = round_date(date, "10 sec"))
view(conduct_df)

#check if depth date is a character
#yes!
is.character(depth$date)

#convert date in depth data in right format
depth_df <- depth %>%
  mutate(date= ymd_hms(date))

###join conduct and depth datasets 
#use inner join uses dataset in both 
#using inner join will automatically remove NAs

all_data <- inner_join(depth_df, conduct_df, by = "date") 
view(all_data)

#lets select the desired variables and round by minute
all_data_df <- all_data %>%
  select(date, Depth, Temperature, Salinity) %>%
  mutate(minutedate = floor_date(date, "1 minute"))
view(all_data_df)

#now, lets make our dataset long to be easier to graph
all_data_long <- all_data_df %>%
  pivot_longer(cols = c(Depth:Salinity),
               names_to = "Variables",
               values_to = "Values") %>%
                 group_by(minutedate, Variables) %>%
                 summarise(mean.values = mean(Values, na.rm = TRUE))
view(all_data_long)
               
#yay! it worked

#now let's make a plot
ggplot(all_data_long, aes(x = minutedate, y = mean.values, color = Variables)) +
  geom_point() +
  facet_grid("Variables")


#I want to make a graph with facet wrap for each variable...

ggplot(data = all_data_long, 
       aes (x = minutedate, y = mean.values, color = Variables)) +
  geom_point() +
  facet_grid("Variables") +
  labs(title = "Maunalua Bay Averaged Abiotic Factors", 
       x = "Time", y = "Mean", 
       color =  "Variables") +
  scale_color_manual(values = wes_palette("FantasticFox1"))

#lets try making scales fit

ggplot(all_data_long, aes(x = minutedate, y = mean.values, color = Variables)) +
  facet_wrap(~Variables, scales = "free") +
  geom_point(size = 0.5) + 
  geom_blank(data=all_data_long) + 
  theme_bw() +
  labs(title = "Maunalua Bay Averaged Abiotic Factors", 
       x = "Time", y = "Mean", 
       color =  "Variables") +
  theme(axis.title = element_text(size = 9),
        axis.text = element_text(size = 9),
        legend.position = "none") +
  scale_color_manual(values = wes_palette("FantasticFox1"))

#I like this plot, but I couldnt figure out how to make the last x labe (14:00) to wrap or squeeze.
#it got cut off a little bit!

#save the plot
ggsave(here("Week_05", "Output", "Week_05_homework_graph.pdf"),
       width = 10, height = 5)  
