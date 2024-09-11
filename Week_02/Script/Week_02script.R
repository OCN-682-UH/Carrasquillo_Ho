## This is my first script! I am learning how to import data
## Created by: Solimar Carrasquillo Ho
## Created on: 2024-09-09
##########

##load libraries###
install.packages("here")
install.packages("tidyverse")
library(here)
library(tidyverse)

## Read in data ##
WeightData <-read_csv(here("Week_02", "Data", "weightdata.csv"))

## Data Analysis ###

#looks at the top 6 lines of data
head(WeightData)

#looks at the bottom 6 lines of data
tail(WeightData)

#looks at entire dataset in new csv
view(WeightData)
