#### Grouped expressions ####
{
  a <- 2
  b <- 1:9
  a * b 
}


#### Writing functions ####
# polynomial function
f <- function(x) x^2 + 1
f
x <- seq(-1, 1, 0.1)
x
y <- f(x)
plot(x,y, type ="l")
?plot

# odd-even function
odd.even <- function(x){
  if(x %% 2 == 1) y <- "odd" else y <- "even"
  print(y)
}
odd.even(12)
odd.even(9)


#### Control structures ####
# If condition
x <- 75
if (x >= 90) "A"
if (x >= 90) "A" else "B"
if (x >= 90) "A" else if (x >= 80) "B" else "C"

# example: median
x <- c(3, 6, 4, 7, 5, 6, 11, 4, 7, 9)
length(x)
x.srt <- sort(x)
x.srt
x.len <- length(x)
if (x.len %% 2 == 1) {
  x.mode <- x.srt[(x.len + 1)/2]
} else {x.mode <- ((x.srt[x.len / 2] + x.srt[x.len/2 + 1]) / 2)
}
x.mode
(x.len + 1)/2
x.srt[(x.len + 1)/2]
x.len / 2
m <- function(x) {
  if (x.len %% 2 == 1) {
    x.mode <- x.srt[(x.len + 1)/2]
  } else {x.mode <- ((x.srt[x.len / 2] + x.srt[x.len/2 + 1]) / 2)
  }
  x.mode
}
m(x)
median(x)

#### Looping ####
# for 
for (i in c(1, 3, 4)) {
  print(i)
}

for (i in 10^(0:4)) print (sum(1:i))
# or
for (i in 10^(0:4)){
  print(sum(1:i))
}
10^(0:4)

for (i in 1:3) {
  for (j in 4:6) {
    print(i*j)
  }
}

x <- matrix(NA,3,3)
x
for (i in 1:3){
  for (j in 1:3) {
    x[i,j] <- i*j
  }
}
x


x <- colors()  # colors(): chacracter vector of length 657
for (i in 1:length(x)) {
  if (i %% 100 == 0)
    cat("x[", i, "]:", x[i], "\n", sep = "")  # "\n" for new line
}

# while
# repeats only when condition is TRUE, stops repeating when F
a <- 5
while(a > 0) {
  print(a)
  a <- a-1
}
a

i <- 1
while(i < 6){  
  print(i*2)
  i <- i+1
}
# compare the above while loop with for loop
for(i in 1:5){
  print(i*2)
}

x <- colors()
i <- 1
while(i <= length(x)) {
  if(x[i] == "orange") {
    cat("x[", i, "]:", x[i], "\n", sep = "")
    break
  }
  i <- i + 1
}

# repeat

## DO NOT RUN THIS INFINITE LOOPS CODE ##
## IF YOU RUN THIS CODE, CLICK RED BUTTON ON THE UPPER-RIGHT SIDE OF THE CONSOLE ##
i <- 1
while(T){
  print(i*2)
  i <- i+1 
}


## OK TO RUN CODE FROM HERE ##
i <- 1
while(T){
  print(i*2)
  i <- i+1
  if(i>5) break       # use if and break to avoid infinite loops
}


# cat function
x <- 11:20; x
y <- 11:15
x;y
cat(x, y, sep = "-")
print(x,y)
cat("x=", x, sep = " ")

# cat function can be used to write data
getwd()
setwd("/Users/Sodami/Documents/R programming/data")
list.files()

cat("x=", x, "\n", sep = "", file = "cat.txt")
cat("y=", y, "\n", sep = "", file = "cat.txt")
cat("y=", y, "\n", sep = "", file = "cat.txt", append = T)
cat("y=", 1:15, sep = "", file = "cat.txt", append = T)
cat("y=", 1892, "\n", sep = "", file = "cat.txt", append = T)
cat("y=", 1, sep = "", file = "cat.txt", append = T)



#### Reading data ####

# Accessing built-in datasets
data()
data(women)  # same as data("women")
# or
data(women, package = "datasets")
head(women)

# Reading data from files - Example

# Comma-separated values; CSV
airquality_csv <- read.table("airquality.csv", header = T, sep = ",")
# or
airquality_csv <- read.csv("airquality.csv")
airquality_csv

#  CSV2
airquality_csv2 <- read.table("airquality.csv2", header = T, sep = ";", dec = ",") 
# or
airquality_csv2 <- read.csv2("airquality.csv2")
airquality_csv2
?read.table

# Delimited file - defaulting to the TAB character for the delimiter.
airquality_txt <- read.table("airquality.txt", header = T, sep = "\t")
airquality_txt <- read.table("airquality.txt", header = T, sep = "\t", na.strings = ".")  # if the missing value is stored as .
# or
airquality_txt <- read.delim("airquality.txt")
airquality_txt 

#### Writing data ####

# example: TAB Delimited file & CSV
data(iris)
head(iris)
out.data <- iris[1:4]; out.data
# TAB character for the delimiter
# row.names = T by default, which prints row label.
write.table(out.data, "iris.txt", quote = F, sep = "\t",
            row.names = F, col.names = T)
# CSV
write.table(out.data, "/Users/Sodami/Documents/R programming/data/iris.csv", quote = T, sep = ",",
            row.names = F, col.names = T)
?write.table

#### Useful tricks ####

# Inserting Data into a Vector
x <- append(1:10, NA, after = 3)  # the new items will be inserted at the position given by after.
x
is.na(x)
which(is.na(x))
append(1:10, 0, after = 0)   # after = 0 means insert the new items at the head of the vector

# Combining Multiple Vectors into One Vector and a Factor
comb <- stack(list(group1 = 1:2, group2 = 3:4))
list(group1 = 1:2, group2 = 3:4)
print(comb)
str(comb)


# Appending Rows to a Data Frame 
dt.ori <- data.frame(x = 1:3, y = letters[1:3]); dt.ori
dt.tmp <- data.frame(x = 4:5, y = letters[4:5]); dt.tmp
dt <- rbind(dt.ori, dt.tmp)
dt

# Selecting Rows and Columns More Easily
data("airquality")
head(airquality)
subset(airquality, Temp > 80, select = c(Ozone, Temp))
subset(airquality, Day == 1, select = - Temp)
subset(airquality, select = 1:3)
subset(airquality, select = Ozone:Wind)


# Removing NAs from a Data Frame
df <- data.frame(x = c(NA, 2, 3), y = c(0, 10, NA)); df
cumsum(df)   # cumsum fails if the input contains NA values
df.clean <- na.omit(df)
df.clean
mean(df$x)
mean(df$x, na.rm = T)

# Combining Two Data Frames
dt.ori <- data.frame(x = 1:3, y = letters[1:3]); dt.ori
dt <- cbind(dt.ori, z = "a")
dt
dt <- cbind(dt.ori, i = 1:4)
dt <- cbind(dt.ori, i = 1:3)
dt
rbind(dt.ori, z = 0)                  # Check out for the recycling rule
rbind(dt.ori, data.frame(x = 0, y = letters[4]))


# Accessing Data Frame Contents More Easily
search()    # Environment of current R workspace
data(women)
head(women)
summary(women$height)             

head(women)
attach(women)  # for repetitive access, use attach to insert the data frame into your search list.
search()  # now you can refer to the data frame column by name without mentioning the data frame. 
summary(height)                   # The same variable now available by name

detach()                           # remove the second location in the search list
search()
summary(height)


# Splitting a Vector into Groups
library(MASS)
??MASS
str(Cars93) # Origin has two levels: USA and non-USA
?Cars93
group <- split(Cars93$MPG.city, Cars93$Origin) # split the MPG data according to origin
group
summary(group)
class(group)
median(group[[1]])
median(group[[2]])
class(group[1]) # list
class(group[[1]]) # integer
group$USA[1]
group$USA
group[[1]][1]
group[1]       
group
class(group)
group[1]
group[2]
group$USA[1]
group[[1]][1]
median(group$USA)
str(group)
group$USA[1]
group[1]

# Applying a Function to Every Row
data(co2) 
?co2
str(co2)
plot(co2)
?apply
means <- apply(matrix(co2, ncol = 12, byrow = T), 1, mean)  # {1: row}, {2: column}
dim(matrix(co2, ncol = 12, byrow = T))  
means   # 39 years 
names(means) <- 1959:1997
length(1959:1997)
plot(means)


# Applying a Function to Every Column
# For a matrix
data(co2)                     
means <- apply(matrix(co2, ncol = 12, byrow = T), 2, mean)
names(means) <- 1:12
plot(means)

# For a data frame
data(iris)
head(iris)
apply(iris[1:4], 2, mean)
sapply(iris[1:4], mean)    # sapply returns the results in a vector if possible.
lapply(iris[1:4], mean)    # lapply always returns the results in list.
apply(iris[1:4], 2, summary) 
sapply(iris[1:4], summary)
lapply(iris[1:4], summary)

# Applying a Function to Groups of Data
# contingency table from data.frame: array with named dimnames
data("warpbreaks")
?warpbreaks
str(warpbreaks)
head(warpbreaks)
?tapply
tapply(warpbreaks$breaks, warpbreaks[-1], mean)


# Applying a Function to Groups of Rows
head(iris)
by(iris, iris[5], summary)  # split data according to Species and call summary for the three groups


# Applying a Function to Parallel Vectors or Lists
mapply(rep, 1:4, 4:1)
rep(1,4)
rep(2,3)
rep(3,2)
rep(4,1)
mapply(rep, times = 1:4, x = 4:1)
mapply(seq, from = 1, to = 1:10)
?mapply


# Getting the Length of a String
nchar("Gerrard") # nchar returns a length of a string
msn <- c("Messi", "Suarez", "Neymar")
nchar(msn)

length("Gerrard")
length(msn) # length returns a length of a vector

# Concatenating Strings
class(paste(1:12))
paste(1:12)
as.character(1:12)
paste("A", 1:6, sep = "")
msn <- c("Messi", "Suarez", "Neymar")
shirtnumber <- c(10, 9, 11)
paste(msn, shirtnumber, sep="-")
paste(msn, "loves", "Barcelona.")
paste(msn, "loves", "Barcelona", collapse = ", and ")  # collapse parameter defines top-level separator
paste("Today is", date())
paste("Today is", Sys.Date())
Sys.Date() - 2

# Extracting Substrings
substr("Statistics", 1, 4)
substr("Statistics", 7, 10)

bpl <- c("Arsenal", "Tottenham", "Chelsea")
substr(bpl, 1, 3)  # extract first 3 characters of each string 

cities <- c("New York, NY", "Los Angeles, CA", "Peoria, IL")
substr(cities, nchar(cities) - 1, nchar(cities)) 
nchar(cities)

# Replacing Substrings
manager <- c("Mourinho is the normal one. Mourinho is the special one.")
sub("Mourinho", "Klopp", manager) # sub replaces the first instance of a substring
gsub("one", "manager", manager) # gsub replaces all instances of a substring

# Creating a Sequence of Dates 
s <- as.Date("2016-01-01"); e <- as.Date("2016-02-01") # as.Date("yyyy-mm-dd") format 
s
e
seq(from = s, to = e, by = 1)  # one month of dates  
seq.Date(from = s, to = e, by = 1)
# {from: starting date}, {by: increment}, {length.out: number of dates}
seq(from = s, by = 1, length.out = 7)  # Dates, one week apart
seq(from = s, by = "month", length.out = 6)  # First of the month for 6 months
seq(from = s, by = "3 months", length.out = 4) # Quarterly dates for one year
seq(from = s, by = "year", length.out = 10)  # Year-start dates for one decade

# Peeking at Your Data
head(women)
head(women, 10)
tail(women)



# Finding the Position of a Particular Value
match("s", letters)
letters
length(letters)
class(letters)
letters[19]


# Sorting a Data Frame
library(MASS)
data("Cars93")
names(Cars93)
t(names(Cars93))
Cars93.sub <- subset(Cars93, select = c(1,2,5))
attach(Cars93.sub)
head(Cars93.sub)
summary(Cars93.sub$Price)
Price
length(Price)
# order
order(Price)
order(Price, decreasing = T)
rev(order(Price))
# sort 
sort(Price)
sort(Price, decreasing = T)
rev(sort(Price))
Cars93.srt <- Cars93.sub[order(Price), ]
head(Cars93.srt); tail(Cars93.srt)


# Sorting by two columns
Cars93.srt <- Cars93.sub[order(Manufacturer, -Price),]
head(Cars93.srt)
detach()


