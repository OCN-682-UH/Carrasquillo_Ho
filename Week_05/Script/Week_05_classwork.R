##This is code for Week 5 script w/ joins
##by: Solimar Carrasquillo Ho
##created: 2024-09-30
##last modified: 2024-09-30

#load libraries
library(tidyverse)
library(here)


#joint function allows you to combine multiple datasets
#important to create unique ID for every sample

####load data
#environmental data from each site
EnviroData<- read_csv(here("Week_05", "Data", "site.characteristics.data.csv"))

#Thermal performance data
TPCData <-read_csv(here("Week_05", "Data","Topt_data.csv"))

#lets take a look
glimpse(EnviroData)
glimpse(TPCData)

#lets convert the EnviroData from wide to long format
EnviroData_wide <- EnviroData %>%
  pivot_wider(names_from = parameter.measured,
              values_from = values)
view(EnviroData_wide)

#lets sort thru the data so sites are in order
EnviroData_wide <- EnviroData %>%
  pivot_wider(names_from = parameter.measured, #pivot data to wide
              values_from = values) %>%
  arrange(site.letter) ##arrange the dataframe by site

view(EnviroData_wide)

#lets look at the relationship between nutrient loading from site and diff. thermal performace
#you use the left_join() to bring two data frames together 

#for left_join() to work, you need a key thats identical in both dataframes
#spelling, capitlation...everything
FullData_left <- left_join(TPCData, EnviroData_wide)

#join with by = join_by(site.letter)
head(FullData_left)

#rearrange the metadata so all characters are on the left and numeric data on the right
FullData_left<- left_join(TPCData, EnviroData_wide) %>%
  relocate(where(is.numeric), .after = where(is.character)) #relocate all the numeric data after character data

head(FullData_left)

#think, pair, share (homework is similar to this)
#calculate the mean and variance of a collected (TPC and environment by site)
challenge <- FullData_left %>%
  group_by(site.letter) %>%
  summarise(across(c(E:substrate.cover), list(mean = mean, var = var), na.rm= TRUE))
  
#this way didn't work :( try again later? you could type them in manually booo
#you would need to list each column....
FullData_left %>%
  group_by(site.letter) %>%
  summarise_at(c(E:substrate.cover), list(mean =mean, var = var), na.rm= TRUE)

#make the data set long to do less code? 
#this didn't work, probably longer...
FullDataleft_long <- FullData_left %>%
  pivot_longer(cols = E:substrate.cover,
                values_to = "values")
view(FullDataleft_long)



#other join functions to know and well learn
#right_join()
#inner_join()
#full_join()
#semi_join()
#anti_join()

#create a tibble, which is a simple data frame
#make 1 tibble
T1 <- tibble(Site.ID = c("A", "B", "C", "D"),
             Temperature = c(14.1, 16.7, 15.3, 12.8))

#make second tibble
T2 <- tibble(Site.ID = c("A", "B", "D", "E"), 
         pH = c(7.3, 7.8, 8.1, 7.9))
#lets join the two tibbles
left_join(T1, T2) #joins to T1
right_join(T1, T2) #joins to T2


#inner_join vs full_join
#inner only keeps data thats complete in both datasets
#full join keeps everything 
#semi join kepps all rows from first data set where there are matching values
#anti joins saves rows in first data that dont match anything in second. this is useful when youre looking for missing data across datasets

#need to complete R markdown from week 2!!!!
