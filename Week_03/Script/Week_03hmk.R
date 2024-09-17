## Week_04 in homework assignment. We'll be creating plots in ggplot2. 
## Created by: Solimar Carrasquillo Ho
## Created on: 2024-09-16
##########

#load libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(devtools)
library(usethis)
library(beyonce)
library(ggthemes)
library(ggplot2)

#take a look at the dataset using glimpse function;
#shows each variable and if function is facto, double, interger...etc...
glimpse(penguins)

#make a plot using ggplot

ggplot(data = penguins,
       mapping =aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point() +
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)")

#question geom_smooth to learn more about function
#can add standard error w/ geom_smooth function
#you can set method to be a linear model (best way to map a regression)
?geom_smooth

#lets add a best fit line to data

ggplot(data = penguins,
       mapping =aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point() + geom_smooth()+
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)")

#set the method in geom_smooth as "lm" to set it as a linear model
ggplot(data = penguins,
       mapping =aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point() + geom_smooth(method = "lm")
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)")

#set standard error bar ?? 
  ggplot(data = penguins,
         mapping =aes(x = bill_depth_mm, y = bill_length_mm)) +
    geom_point() + geom_smooth(method = "lm", level = TRUE)
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)")
  
#plot relationship by species using group feature in aesthetics
  ggplot(data = penguins,
         mapping =aes(x = bill_depth_mm, 
                      y = bill_length_mm, group = species)) +
    geom_point() + geom_smooth(method = "lm")
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)")
  
  #add layer for color
  ggplot(data = penguins,
         mapping =aes(x = bill_depth_mm, 
                      y = bill_length_mm, group = species, color = species)) +
    geom_point() + geom_smooth(method = "lm")
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)")
  
#add colorblindness color gradient
#this didn't work??
ggplot(data = penguins,
         mapping =aes(x = bill_depth_mm, 
                      y = bill_length_mm, group = species, color = species)) +
    geom_point() + geom_smooth(method = "lm")
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)" 
       ) + 
    scale_color_viridis_b()

#load the praise package
install.packages("praise")
library(praise)
praise()

#changing primary aestetics in ggplot 
#add the x axis scale 
ggplot(data = penguins,
       mapping =aes(x = bill_depth_mm, 
                    y = bill_length_mm, 
                    group = species, 
                    color = species)) +
  geom_point() + geom_smooth(method = "lm") +
labs(x = "Bill Depth (mm)", y = "Bill Length (mm)") +
  scale_color_viridis_d()
  scale_x_continous(limits = c(0,20))


#add scale limits for the y axis
ggplot(data = penguins,
       mapping =aes(x = bill_depth_mm, 
                    y = bill_length_mm, 
                    group = species, 
                    color = species)) +
  geom_point() + geom_smooth(method = "lm") +
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)") +
  scale_color_viridis_d()
scale_x_continous(limits = c(0,20)) + 
scale_y_continuous(limits = c(0,50))

#adding breaks to the graph 
#not sure why this code is working prior, but not here??? 
ggplot(data = penguins,
       mapping =aes(x = bill_depth_mm, 
                    y = bill_length_mm, 
                    group = species, 
                    color = species)) +
  geom_point() + geom_smooth(method = "lm") +
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)") +
  scale_color_viridis_d()
scale_x_continuous(limits = c(0,22), 
                   breaks = c(0, 14, 17, 21)) 

#these labels don't work. I think the scale_x_continuous function isn't working
ggplot(data = penguins,
       mapping =aes(x = bill_depth_mm, 
                    y = bill_length_mm, 
                    group = species, 
                    color = species)) +
  geom_point() + geom_smooth(method = "lm") +
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)") +
  scale_color_viridis_d()
scale_x_continuous(labels = c("low", "medium", "high"))
                   breaks = c(14, 17, 21) 

#change colors manually
ggplot(data = penguins,
       mapping =aes(x = bill_depth_mm, 
                    y = bill_length_mm, 
                    group = species, 
                    color = species)) +
  geom_point() + geom_smooth(method = "lm") +
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)") +
  scale_color_viridis_d()
scale_x_continuous(breaks = c("low", "medium", "high")) +
  scale_color_manual(values = c("orange", "purple", "green"))

#installing a cute beyonce color palate 
devtools::install_github("dill/beyonce")

#make a cute beyonce graph
ggplot(data = penguins,
       mapping =aes(x = bill_depth_mm, 
                    y = bill_length_mm, 
                    group = species, 
                    color = species)) +
  geom_point() + 
  geom_smooth(method = "lm") +
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)") +
  scale_color_viridis_d() +
scale_x_continuous(breaks = c(14, 17, 21),
  labels = c("low", "medium", "high")) +
  scale_color_manual(values = beyonce_palette(18))

#flip coordinates
ggplot(data = penguins,
       mapping =aes(x = bill_depth_mm, 
                    y = bill_length_mm, 
                    group = species, 
                    color = species)) +
  geom_point() + 
  geom_smooth(method = "lm") +
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)") +
  scale_color_viridis_d() +
  scale_x_continuous(breaks = c(14, 17, 21),
                     labels = c("low", "medium", "high")) +
  scale_color_manual(values = beyonce_palette(18))+ 
  coord_flip()

#make it squeezed
ggplot(data = penguins,
       mapping =aes(x = bill_depth_mm, 
                    y = bill_length_mm, 
                    group = species, 
                    color = species)) +
  geom_point() + 
  geom_smooth(method = "lm") +
  labs(x = "Bill Depth (mm)", y = "Bill Length (mm)") +
  scale_color_viridis_d() +
  scale_x_continuous(breaks = c(14, 17, 21),
                     labels = c("low", "medium", "high")) +
  scale_color_manual(values = beyonce_palette(18))+ 
  coord_fixed(ratio = 1.5)

#make a simple diamond plot
ggplot(diamonds, aes(carat, price)) + geom_point() 

#add log to make data more digestable 
ggplot(diamonds, aes(carat, price)) + geom_point() +
  coord_trans(x= "log10", y = "log10")

#make them polar coordinates
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+ 
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill Depth (mm)",
       y = "Bill Length (mm") +
  scale_color_manual(values = beyonce_palette(2))+
  coord_polar("x")
  )

#change to theme bw
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+ 
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill Depth (mm)",
       y = "Bill Length (mm") +
  scale_color_manual(values = beyonce_palette(2))+
theme_bw()


#other complete themes linedraw
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+ 
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill Depth (mm)",
       y = "Bill Length (mm") +
  scale_color_manual(values = beyonce_palette(2))+
  theme_linedraw()

##theme light
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+ 
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill Depth (mm)",
       y = "Bill Length (mm") +
  scale_color_manual(values = beyonce_palette(2))+
  theme_void()

#theme classic
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+ 
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill Depth (mm)",
       y = "Bill Length (mm") +
  scale_color_manual(values = beyonce_palette(2))+
  theme_classic()

#wall street journal theme
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+ 
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill Depth (mm)",
       y = "Bill Length (mm") +
  scale_color_manual(values = beyonce_palette(2))+
  theme_wsj()

#change the axis title to make it bigger and easier to read
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+ 
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill Depth (mm)",
       y = "Bill Length (mm") +
  scale_color_manual(values = beyonce_palette(2))+
  theme_bw()+
  theme(axis.title = element_text(size = 20))

#change the color to be reddddd
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+ 
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill Depth (mm)",
       y = "Bill Length (mm") +
  scale_color_manual(values = beyonce_palette(2))+
  theme_bw()+
  theme(axis.title = element_text(size = 20, color = "red"))

#change panel background
#doesn't actually change the panel background, but works in the next line of code
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+ 
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill Depth (mm)",
       y = "Bill Length (mm") +
  scale_color_manual(values = beyonce_palette(2))+ 
  theme_bw()+
  theme(axis.title = element_text(size = 20, color = "red"),
        panel.background = element_rect(color = "linen")

?theme
        
#me trying to make my own plot and change the theme. Let's try something pink and girly
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+ 
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill Depth (mm)",
       y = "Bill Length (mm") +
  scale_color_manual(values = beyonce_palette(1))+ 
  theme_bw()+
  theme(axis.title = element_text(size = 14, color = "pink"),
        panel.background = element_rect(fill = "linen"))

#save the plot
ggsave(here("Week_03", "Output", "penguin.jpg"))

#lets change the height and width in the ggsave function
#default settings are not the best
ggsave(here("Week_03", "Output", "penguin.jpg"), 
       width = 7, height = 5)

#save as a pdf
ggsave(here("Week_03", "Output", "penguin.pdf"), 
       width = 7, height = 5)

#you can save your plot as an object!
plot1<-ggplot(data = penguins,
              mapping = aes(x = bill_depth_mm,
                            y = bill_length_mm,
                            group = species,
                            color = species))+ 
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill Depth (mm)",
       y = "Bill Length (mm") +
  scale_color_manual(values = beyonce_palette(1))+ 
  theme_bw()+
  theme(axis.title = element_text(size = 14, color = "pink"),
        panel.background = element_rect(fill = "linen"))

#recall the plot 1
plot1


#homework is to make up literally any plot in an hour
ggplot(data = penguins,
       mapping = aes(x = ""))