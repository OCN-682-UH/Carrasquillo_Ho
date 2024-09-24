##This is code for Week 4 video
##by: Solimar Carrasquillo Ho
##created: 2024-09-23
##last modified: 2024-09-23

#load libraries
library(tidyverse)
library(here)
library(praise)
library(ggplot2)

#load data
chemdata <- read_csv(here("Week_04", "Data", "chemicaldata_maunalua.csv"))
view(chemdata)
glimpse(chemdata)

###analyze data

#this filter cleans out everything that is not a complete row
chemdata_clean <-chemdata%>%
  filter(complete.cases(.))

#view clean data
view(chemdata_clean)

#fix column name for Tide_time into two separate columns
chemdata_clean

#learn about separate function
?separate

#separate the column Tide_day into two column
chemdata_clean <-chemdata%>%
  drop_na() %>% #filters out everything that isn't a complete row 
  separate(col = Tide_time,
           into = c("Tide", "Time"),
           sep = "_")
head(chemdata_clean)

#if you wanted to keep the original column you can add remove=FALSE
chemdata_clean <-chemdata%>%
  drop_na() %>% #filters out everything that isn't a complete row 
  separate(col = Tide_time,
           into = c("Tide", "Time"),
           sep = "_",
           remove = FALSE)
head(chemdata_clean)

#unite function bring two columns together
#difference between the spearate col and unite with the " "
#separate = col doesn't have "" because you are picking a name for new row
# unite = col has "" because you're creating a new row

chemdata_clean <-chemdata%>%
  drop_na() %>% #filters out everything that isn't a complete row 
  separate(col = Tide_time,
           into = c("Tide", "Time"),
           sep = "_",
           remove = FALSE) %>%
  unite(col = "Site_Zone",
        c(Site,Zone), #the columns to unite w/in parenthesis
        sep = ".", #joined together by a period
        remove = FALSE)

head(chemdata_clean)

#pivot the data to change from wide to long format 
#pivot_longer

chemdata_long <-chemdata_clean%>%
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values")
view(chemdata_long)


#calculate the mean and variance for all variables at each site
#if you group by variables and site then you can do calc for all in one line
chemdata_long %>%
  group_by(Variables, Site)%>%
  summarise(Param_means = mean(Values, na.rm = TRUE),
            Param_vars = Values, na.rm = TRUE)

#think pair share calculate mean, variance, sd by site, zone and tide
?summarise

chemdata_long %>%
  group_by(Site, Zone, Tide)%>%
  summarise(Param_means = mean(Values, na.rm = TRUE),
            Param_vars = var(Values, na.rm = TRUE),
            sd(Values, na.rm = TRUE)
  )

#i think i did it!! :)

#facet_wrap with long data 
chemdata_long%>%
  ggplot(aes (x = Site, y = Values)) +
  geom_boxplot() +
  facet_wrap(~Variables)

#setting scales = free will adjust the x and y axis 
chemdata_long%>%
  ggplot(aes (x = Site, y = Values)) +
  geom_boxplot() +
  facet_wrap(~Variables, scales = "free")

#convert long data to wide 
chemdata_wide <-chemdata_long %>%
  pivot_wider(names_from = Variables,
              values_from = Values)
view(chemdata_wide)

#play around with this data
#add another column in the wide data?

#calculate summary statistics and export the csv file
chemdata_clean<-chemdata %>%
  drop_na()

#always view the data after each line!!! you can do this in the console
view(chemdata_clean)

#put it all together
chemdata_clean<-chemdata %>%
  drop_na()
separate(col = Tide_time,
         into = c ("Tide","Time",
                   sep = "_",
                   remove = FALSE))

