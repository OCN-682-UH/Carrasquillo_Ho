##This is code from Week 4 lecture
##by: Solimar Carrasquillo Ho
##created: 2024-09-17
##last modified: 2024-09-17

#load libraries

library(palmerpenguins)
library(tidyverse)
library(here)
library(praise)

#analysis begins here

#take a look at the data
view(penguins)
glimpse(penguins)
head(penguins)

#filter only the female penguins
#using two equal signs will only pull exactly match. This will filter out males & NAs

filter(.data = penguins, sex == "female")

#how to filter fat penguins
filter(.data = penguins, body_mass_g > 5000, year == "2008")

#filter the female penguins 
filter(.data = penguins, sex == "female")

#using the & sign in a filter. It literally means AND. 
#! means where this is not true
#| means this or that

#& and , do the same thing in R. It's preferred to use the comma in R

#filter and boolean logic in either 2008 or 2009, not from island dream, and the species adelie and gentoo 


filter(.data = penguins,year == "2008|2009", islands == !"Dream", species == "Adelie" & "Gentoo")

#how to filter multiple years w/ or
filter(.data = penguins, year == "2008" | year == "2009")

#how to filter w/ in function
filter(.data =penguins, year %in% c("2008", "2009"))

#how to filter penguins that are not from dream 
filter(.data = penguins, islands != "Dream")

#filter penguins that are in the species Adelie and Gentoo
filter(.data = penguins, species %in% c("Adelie", "Gentoo"))

#using mutate, which creates new columns
#lets convert a new column to convert body mass in g to kg

data2<- mutate(.data = penguins, body_mass_kg = body_mass_g/1000)

#dont forget to view your filters to make sure they actually worked!
view(data2)

#adding multiple new columns at once
data2 <- mutate (.data = penguins,
                 body_mass_kg = body_mass_g/1000,
                 bill_length_depth = bill_length_mm/bill_depth_mm)
view(data2)


#look up these on your own to see how they work 
?mutate_if()
?mutate_at()
?mutate_all()

#conditional tests within mutate function using ifelse()
data2<- mutate(.data = penguins,
               after_2008 = ifelse(year>2008, "After 2008", "Before 2008"))
view(data2)

#mutate to create a new column to add flipper length and body mass together
flipper_mass <- mutate(.data = penguins,
                       flipper_mass = flipper_length_mm + body_mass_g, 
                       phatty = ifelse(body_mass_g> 4000, "Big boi", "Smol boi"))
view(flipper_mass)

#%>% function is part of the tidyverse package
#|> doesnt require the tidyverse package though 

#so now we wont need to use list .data if we use %>% after the name of dataframe

penguins %>% #use the penguin dataframe
  filter(sex == "female") %>%
  mutate(log_mass = log(body_mass_g)) %>%
  select(species, island, sex, log_mass)

#you can use select to rename columns
#lets rename species column to capiltalize 
penguins %>%
  filter(sex == "female") %>%
  mutate(log_mass = log(body_mass_g)) %>%
           select(Species = species, island, sex, log_mass)

#computer a table f summarized data & calculate the mean flipper length & remove na
#na.rm function means it removes all the na in the missing data 
penguins %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE))

#calculate the mean and min flipper length
penguins %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE),
            min_flipper = min(flipper_length_mm, na.rm=TRUE))

#group_by function to summarize by certain groups
#lets calculate mean and max bill length by island
penguins %>%
  group_by(island)%>%
  summarise(mean_bill = mean(bill_length_mm, na.rm=TRUE),
            max_bill_length = max(bill_length_mm, na.rm = TRUE))

#group by island AND sex
penguins %>%
  group_by(island, sex)%>%
  summarise(mean_bill = mean(bill_length_mm, na.rm=TRUE),
            max_bill_length = max(bill_length_mm, na.rm = TRUE))

#lets remove NAs drop_na function from 
penguins %>%
  drop_na(sex)

#lets put it into ggplot. dont forget to start using + w/ ggplot instead of %>%
penguins %>%
  drop_na(sex)%>%
  ggplot(aes(x= sex, y = flipper_length_mm)) + 
  geom_boxplot()

