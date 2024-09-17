###this is my ggplot for week 3 homework
##by: Solimar Carrasquillo Ho
##created: 2024-09-16
##last date modified: 2024-09-17

#load libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(devtools)
library(usethis)
library(beyonce)
library(ggthemes)
library(ghibli)
library(ggplot2)
#this is my data analysis

#rules are I cannot make a scatter plot!!!
#within an hour and change the themes that is publication ready where you're learning something new

#installing packages from github
remotes::install_github("trevorld/ggpattern")

#look at the dataset
glimpse(penguins)

#data analysis

#begin with basic ggplot
ggplot(data = penguins,
       mapping =aes(x = island, 
                    y = body_mass_g, fill = species))

#add geom_violin
ggplot(data = penguins,
       mapping =aes(x = island, 
                    y = body_mass_g, fill = species)) +
  geom_violin() + theme_bw()

#add titles and theme
ggplot(data = penguins,
       mapping =aes(x = island, 
                    y = body_mass_g, fill = species)) +
  geom_violin() + theme_bw() + 
  theme(axis.title = element_text(size = 13)) +
  labs(x = "Sex", 
       y = "Body Mass (g)",
       title = "Penguin Weight at Palmer Station LTER") 

##add color
ggplot(data = penguins,
       mapping =aes(x = island, 
                    y = body_mass_g, fill = species)) +
  geom_violin() + theme_bw() + 
  theme(axis.title = element_text(size = 13)) +
  labs(x = "Sex", 
       y = "Body Mass (g)",
       title = "Penguin Weight at Palmer Station LTER") + 
  scale_color_viridis_d() 

#adding faceting
ggplot(data = penguins,
       mapping =aes(x = island, 
                    y = body_mass_g, fill = species)) +
  geom_violin() + facet_grid(species~sex) +
  guides(color = FALSE) + 
  theme_bw() + 
  theme(axis.title = element_text(size = 13)) +
  labs(x = "Island", 
       y = "Body Mass (g)",
       title = "Penguin Weight at Palmer Station LTER") + 
  scale_color_viridis_d() 

#save this plot
ggsave(here("Week_03", "Output", "penguin_homework_plot.jpg"), 
       width = 7, height = 5)

#save as pdf
ggsave(here("Week_03", "Output", "penguin_homework_plot.pdf"), 
       width = 7, height = 5)


##end. should probably delete what's below. 

#removed axis. Not sure i want to keep needed? 
ggplot(data = penguins,
       mapping =aes(x = island, 
                    y = body_mass_g, fill = species)) +
  geom_violin() + facet_grid(species~sex) +
  guides(color = FALSE) + 
  theme_bw() + 
  theme(axis.title = element_text(size = 14)) + 
  theme(legend.position="none") +
  labs(x = "Island", 
       y = "Body Mass (g)",
       title = "Penguin Weight at Palmer Station LTER") + 
  scale_color_viridis_d() 


######end###
