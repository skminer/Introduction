#### Creating the stat data frame ####

squad <- c(2, 7, 10, 19, 27)
date <- c("01/01/17", "01/16/17", "02/01/17", "02/12/17", 
          "02/28/17")
gender <- c("M", "M", "M", "M", "F")
age <- c(25, 31, 24, 24, 97)
f1 <- c(4, 3, 2, 3, 2)
f2 <- c(4, 3, 5, 1, 2)
f3 <- c(5, 2, 5, 3, 1)
f4 <- c(4, 4, 5, NA, 4)
f5 <- c(3, 5, 2, NA, 2)
stat <- data.frame(squad, date, gender, age, 
                         f1, f2, f3, f4, f5, stringsAsFactors = FALSE)
stat

stat <- data.frame(squad = c(2, 7, 10, 19, 27),
                         date = c("01/01/17", "01/16/17", "02/01/17", "02/12/17", 
                                  "02/28/17"),
                         gender = c("M", "M", "M", "M", "F"),
                         age = c(25, 31, 24, 24, 97),
                         f1 = c(4, 3, 2, 3, 2),
                         f2 = c(4, 3, 5, 1, 2),
                         f3 = c(5, 2, 5, 3, 1),
                         f4 = c(4, 4, 5, NA, 4),
                         f5 = c(3, 5, 2, NA, 2), stringsAsFactors = FALSE)
stat

ls()

# the individual vectors are no longer needed
rm(squad, date, gender, age, f1, f2, f3, f4, f5)
ls()

#### Creating new variables ####

data <- data.frame(x1 = c(3, 2, 5, 1), 
                     x2 = c(3, 4, 6, 2))
data
data$sumx <- data$x1 + data$x2
apply(data, 1, sum)
data$meanx <- (data$x1 + data$x2)/2
apply(data, 1, mean)
data

data <- transform(data, sumx = x1 + x2,
                    meanx = (x1 + x2)/2)
data




ls()
rm()
# rm(list=ls())


# Recoding variables
stat
stat$age[stat$age == 97] <- NA
stat$age

# numeric -> categorical vaariables
stat$agecat[stat$age > 30] <- "Old"
stat$agecat[stat$age > 24 & 
                    stat$age <= 30] <- "Middle Aged"
stat$agecat[stat$age <= 24] <- "Young"
which(is.na(stat$agecat))
stat

# or use ifelse 
stat$agecat <- with(stat, 
                          ifelse((stat$age > 30), "Old",
                          ifelse((stat$age > 24 & stat$age <= 30), "Middle Aged", "Young")))
stat$agecat
stat

# or more compactly

stat <- within(stat, {
  agecat1 <- NA
  agecat1[age > 30] <- "Old"
  agecat1[age >= 25 & age <= 30] <- "Middle Aged"
  agecat1[age < 25] <- "Young"
})
stat

class(stat$agecat)
stat$agecat <- factor(stat$agecat, 
                            levels = c("Old", "Middle Aged", "Young"))
stat
table(stat$agecat)   # table drops NA by default 
table(stat$agecat, useNA = "ifany")
?table



# Renaming variables with the reshape package
install.packages("reshape")
library(reshape)
colnames(stat)
stat <- rename(stat, c(squad = "squadID", date = "testdate"))
stat

# or rename variables without using the reshape package

names(stat)
names(stat)[1] <- "squadID"
names(stat)[2] <- "testdate"
names(stat)[5:9] <- paste("field", 1:5, sep="")

y <- c(1, 2, 3, NA)
is.na(y)

# Applying the is.na() function
is.na(stat[, 5:9])
complete.cases(stat[, 5:9])

# recode 97 to missing for the variable age
stat$age[stat$age == 97] <- NA
stat

# na.rm=TRUE option
x <- c(1, 2, NA, 3)
x
y <- sum(x);y
y <- sum(x, na.rm = TRUE);y
x


# Using na.omit() to delete incomplete observations
stat
newdata <- na.omit(stat)
newdata
complete.cases(stat)
stat[complete.cases(stat),]   # na.omit(stat)


# default format for inputting dates: yyyy-mm-dd
mydates <- as.Date(c("2016-01-27", "2020-02-13")); mydates 
class(mydates)

# Converting character values to dates

strDates <- c("01/05/2000", "08/16/2000")
dates <- as.Date(strDates, "%m/%d/%Y"); dates

# stat$testDate is coded as a character variable in mm/dd/yy format.
myformat <- "%m/%d/%y"
stat$date <- as.Date(stat$testdate, myformat)
stat$date



library(chron)
Sys.Date()
date <- seq(Sys.Date(), by = 1, length.out = 7)
date

# Useful date functions

Sys.Date()
date()

# Use the format function to output dates in a specified format, 
# and to extract portions of dates
today <- Sys.Date()
today
format(today, format = "%B %d %Y")
format(today, format = "%A")

# Arithmetic operations on dates

startdate <- as.Date("2016-02-10")
enddate <- as.Date("2017-12-12")
days <- enddate - startdate; days
as.numeric(days)
difftime(enddate, startdate)
# difftime(Sys.Date()+1, as.Date("2016-05-07"))

# difftime function
# How old am I?
today <- Sys.Date()
dob <- as.Date("2010-10-10")
difftime(today, dob)
difftime(today, dob, units="weeks")
difftime(today, dob, units="days")  # default

# converting dates to character variables 
dates
class(dates)
strDates <- as.character(dates)
strDates
class(strDates)



#  Converting from one data type to another

a <- c(1, 2, 3)
a
is.numeric(a)
is.vector(a)
a <- as.character(a)
a

is.numeric(a)
is.vector(a)
is.character(a)



# Sorting a dataset

# create a new dataset containing rows sorted from youngest to oldest squad
newdata <- stat[order(stat$age),]
newdata$age

# sort the rows into female followed by male, 
# and youngest to oldest within each gender.
attach(stat)
newdata <- stat[order(gender, -age), ]    
newdata
detach()


# Selecting variables

newdata <- stat[, c(5:9)]; newdata 
variables <- paste("field", 1:5, sep = ""); variables
newdata <- stat[variables]; newdata


# Dropping variables
names(stat)[5:9] <- paste("field", 1:5, sep = "")
names(stat)
variables <- names(stat) %in% c("field3", "field4"); variables   # include
newdata <- stat[!variables]; newdata  # NOT

# or use column numbers to drop variables
t(colnames(stat))
newdata <- stat[-c(8, 9)]; newdata


# You could use the following to delete f3 and f4
# from the stat dataset (commented out so 
# the rest of the code in this file will work)
#
# stat$f3 <- stat$f4 <- NULL

# Selecting observations



newdata <- stat[1:3, ]; newdata

newdata <- stat[which(stat$gender == "M" & 
                              stat$age > 30), ]
newdata

attach(stat)
newdata <- stat[which(gender == "M" & age > 30), ]
detach(stat)

# or using subset function
newdata <- subset(stat, gender == "M" & age > 30); newdata

# Selecting observations based on dates

stat$date <- as.Date(stat$date, "%m/%d/%y")
stat
startdate <- as.Date("2017-02-01")
enddate <- as.Date("2017-02-28")
newdata <- stat[stat$date >= startdate & 
                        stat$date <= enddate, ]
newdata

# Using the subset() function

newdata <- subset(stat, age >= 35 | age < 24, 
                  select = c(field1, field2, field3, field4))
newdata
newdata <- subset(stat, gender == "M" & age > 
                    25, select = gender:field4)
newdata

