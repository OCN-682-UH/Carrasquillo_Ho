##This is code for Week 4 homework
##by: Solimar Carrasquillo Ho
##created: 2024-09-17
##last modified: 2024-09-17

#load libraries

library(palmerpenguins)
library(tidyverse)
library(here)
library(praise)
library(ggplot2)

#data analysis

#1. calculate the mean and variance of body mass by species, island, 
#and sex without any NAs

penguins %>%
  drop_na(island, sex, species)%>%
  group_by(island, sex, species) %>%
  summarise(mean_body = mean(body_mass_g, na.rm = TRUE),
  variance_body = var(body_mass_g, na.rm = TRUE))



#2. filter out male penguins, calculate log body mass, 
#select only the columns for species, island, sex and log body mass
#use data to make any plot 

gurl_penguins <- penguins %>%
  filter(sex != "male") %>%
  mutate(log_mass = log(body_mass_g)) %>%
  select(c(species, island, sex, log_mass))

#view the dataframe
view(gurl_penguins)

#create a graph w/ ggplot w/ hello kitty theme
ggplot(gurl_penguins, 
       mapping = aes(x = island, y = log_mass, fill = island)) +
         geom_boxplot() +
  labs(x = "Island", y = "Log Body Mass (g)") + 
  scale_fill_manual(values = c("#FFC0CB", "#FF8096", "#FF4162" ))
  theme_bw() 

#adding pink colors text
  hello_kitty <- ggplot(gurl_penguins, 
         mapping = aes(x = island, y = log_mass, fill = island)) +
    geom_boxplot() +
    labs(x = "Island", y = "Log Body Mass (g)") + 
    scale_fill_manual(values = c("#FFC0CB", "#FF8096", "#FF4162" ))
  theme_bw() 
  
  
  #save ggplot jpg
  ggsave(here("Week_04", "Output", "hellokitty.jpg"),
         width = 7, height = 5)
  
  
#save ggplot pdf
  ggsave(here("Week_04", "Output", "hellokitty.pdf"),
         width = 7, height = 5)
0


  

  