##This is code for Week 4 video
##by: Solimar Carrasquillo Ho
##created: 2024-09-23
##last modified: 2024-09-23

#load libraries
library(tidyverse)
library(here)
library(praise)

#load data
chemdata <- read_csv(here("Week_04", "Data", "chemicaldata_maunalua.csv"))
view(chemdata)
