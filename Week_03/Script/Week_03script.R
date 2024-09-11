## Week_03 in class assignment. We'll be creating plots in ggplot2. 
## Created by: Solimar Carrasquillo Ho
## Created on: 2024-09-10
##########

install.packages("palmerpenguins")
install.packages("tidyverse")

#libraries
library(palmerpenguins)
library(tidyverse)

#view the dataset!
view(penguins)
head(penguins)
tail(penguins)

#another way to look at data & tells you how many rows, columns, names...etc.
glimpse(penguins)

#making my very first plot hehe. this gives us an empty box
ggplot(data = penguins)

#we'll start by mapping on the aesthetics. missing the y and how to plot it! so nothing shows
ggplot(data = penguins, 
       mapping = aes(x = bill_depth_mm))

#we can continue adding on y
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, y = bill_length_mm))

#so we'll layer on our first geometry, which will tell us how we want it to plot. + will add functions.
#the commas will connect the functions, while + will be adding! 
ggplot(data = penguins, 
       mapping = aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point()

#we want to color points by species. we're connecting fucntion of color by adding a comma
#you can change the color by any variable in the data set
ggplot(data = penguins,
      mapping = aes(x = bill_depth_mm, y = bill_length_mm, color = species)) + 
  geom_point()

#we can another layer to change label axis
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, y = bill_length_mm, color = species)) +
  geom_point() + 
  labs(title = "Bill depth and length")

#you can add a subtitle by adding a comma to the labs function
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, y = bill_length_mm, color = species)) +
  geom_point() +
  labs(title = "Bill depth and length", subtitle= "Dimensions for Adelie, Chinstrap, and Gentoo Penguins")

#you can keep adding on the labs function to add x & y labels 
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, y = bill_length_mm, color = species)) +
  geom_point() +
  labs(title = "Bill depth and length", 
       subtitle= "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", y = "Bill Length (mm)")

#you can capitalize the label species in the labs function, although its lowercase in the dataset!! 
#so it looks niceee
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, y = bill_length_mm, color = species)) +
  geom_point() +
  labs(title = "Bill depth and length", 
       subtitle= "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", y = "Bill Length (mm)", 
       color =  "Species")

#you can add a caption also! 
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, y = bill_length_mm, color = species)) +
  geom_point() +
  labs(title = "Bill depth and length", 
       subtitle= "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", y = "Bill Length (mm)", 
       color =  "Species",
       caption = "Source: Palmer Station LTER / palmer penguins")

#add the package thats meant for colorblindness
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, y = bill_length_mm, color = species)) +
  geom_point() +
  labs(title = "Bill depth and length", 
       subtitle= "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", y = "Bill Length (mm)", 
       color =  "Species",
       caption = "Source: Palmer Station LTER / palmer penguins") +
       scale_colour_viridis_d()

#lets change the shape, which automatically assings a new shape per island
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, y = bill_length_mm, color = species,
                     shape = island)) +
  geom_point() +
  labs(title = "Bill depth and length", 
       subtitle= "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", y = "Bill Length (mm)", 
       caption = "Source: Palmer Station LTER / palmer penguins") +
  scale_colour_viridis_d()

#we can also add sizes to the funcitons
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, y = bill_length_mm, color = species,
                     size = body_mass_g)) +
  geom_point() +
  labs(title = "Bill depth and length", 
       subtitle= "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", y = "Bill Length (mm)", 
       color =  "Species",
       caption = "Source: Palmer Station LTER / palmer penguins") +
  scale_colour_viridis_d()

#change the alpha (transparency), which would change the points based on assigned data
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, y = bill_length_mm, color = species,
                     size = body_mass_g, alpha = flipper_length_mm)) +
  geom_point() +
  scale_colour_viridis_d()

#now we'll practice faceting. facet_grid has less customization
ggplot(data = penguins, 
       aes (x = bill_depth_mm, y = bill_length_mm)) +
  geom_point() +
  facet_grid(species~sex) +
  labs(title = "Bill depth and length", 
       subtitle= "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", y = "Bill Length (mm)", 
       color =  "Species",
       caption = "Source: Palmer Station LTER / palmer penguins") +
  scale_colour_viridis_d()

#facet_wrap has more customization features! 
ggplot(data = penguins, 
       aes (x = bill_depth_mm, y = bill_length_mm)) +
  geom_point() +
  facet_wrap(~species, ncol = 2) +
  labs(title = "Bill depth and length", 
       subtitle= "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", y = "Bill Length (mm)", 
       color =  "Species",
       caption = "Source: Palmer Station LTER / palmer penguins") +
  scale_colour_viridis_d()

#use the ? to search info on the function
?facet_wrap

#facet and color, w/ no legend, facet_grid
ggplot(data = penguins, 
       aes (x = bill_depth_mm, y = bill_length_mm, color = species)) +
  geom_point() +
  facet_grid(species~sex) +
  guides(color = FALSE) +
  labs(title = "Bill depth and length", 
       subtitle= "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", y = "Bill Length (mm)", 
       color =  "Species",
       caption = "Source: Palmer Station LTER / palmer penguins") +
  scale_colour_viridis_d()
