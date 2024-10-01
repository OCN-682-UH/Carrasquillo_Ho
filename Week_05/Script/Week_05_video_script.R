##This is code for Week 5 video
##by: Solimar Carrasquillo Ho
##created: 2024-09-27
##last modified: 2024-09-30

##load libraries 
library(tidyverse)
library(here)
library(lubridate) #package that deals with date and times
library(devtools)

#awesome R package that changes plots into cats
install_github("Gibbsdavidl/Catterplots")

######
#lubridate can be used to tell the time, automatically checks your timezone
now()

#you can ask for time in other time zones, EST, GMT
now("EST")

#use today() if you only want date and not time
today()

#can ask for morning or night lol
#will give you true or false depending on when you run the function
am(now())

#ask for leap year too 
leap_year(now())

#the lubridate package does a good job at guessing the format of the date
#dates MUST BE A CHARACTER for this to work 
#if dates are listed as a FACTOR then you will get an ERROR

# converting a character string to ISO date format
ymd("2021-02-24")

#if its in mdy format to ISO 
mdy("02/24/2021")

#convert date from february 
mdy("February, 24, 2021")

#date month year
dmy("24/02/2021")

#if you have date, time, min, sec can you convert 
##2021-02-24 10:22:20 PM -- ymd_hms()
##02/24/2021 22:22:22 -- mdy_hms(
## February 24, 2021 10:22 PM -- mdy_hm()


#excel will hide the seconds & errors may be bc seconds arent accounted for


#try it out w/o sec
ymd_hm("2021-02-24 10:22:20 PM")

#w/ sec

ymd_hms("2021-02-24 10:22:20 PM")

#lets create a character string for specific date and times
datetimes<- c ("02/24/2021 22:22:20",
               "02/25/2021 22:22:20",
               "02/26/2021 22:22:20")

#convert the datetimes to wanted formated
datetimes<- mdy_hms(datetimes)

#select the month date and times
#this is useful if you have analysis where months is important 

#write the function as below if you want the dates to be spelled out
#THIS LINE ISN'T WORKING ? FROM HERE BELOW
######################
##################

month(datetimes, label = TRUE, abbr = FALSE)

#extract the day of the week
day(datetimes)

#can use this function for the day of the week
wday(datetimes, label = TRUE, abbr = FALSE)

#change character from factor?? 
factor(datetimes)

#extract hour, min, sec
#why didn't this work?? 
hour(datetimes)
minute(datetimes)
second(datetimes)

#convert if you need to edit the timezone
#scenario where youre fixing the time zone 

#day() extracts the hour component from a time
#days()is used to add hours to a date time
#you can use this with minutes(), seconds(), months(), years()...etc

#the hours (notice the s is there!) would add 4 hours
datetimes + hours(4)

#you can also round the dates
round_date(datetimes, "minute") #rounds to the nearest minute

#can do this if you want to add two days
datetimes + days(2)

#round to the nearest minute too!
round_date(datetimes, "5 mins") #rounds to nearest 5 minute


#challenge for homework
#copy two datasets (CondData.csv)
#convert date column to datetime
#keep using tidyverse %>%
#you can pipe into lubridate function



##have her walk through git push again since was docked on points
##gabby will look at the script Week_04 again 
##see if I can have wk 4 turned in late for the push