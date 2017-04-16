#### Data Structures #### 


#### vector: 1d ####
# c(): combine
a1 <- c(1,2,3,4,5) 
a1
length(a1)

# subsetting
a1[2]
a1[2:4]
a1[-2]
a1[c(2,4)]
a1[-c(3,5)]

a2 <- 1:5 # creating sequence 
a2

a3 <- seq(1,5)
a3
?seq
seq(1,5,2) # seq(from=1,to=5,by=2)

a4 <- rep(5,2) # rep(5, times=2)
a4

a5 <- rep(6:7, 2)
a5

?rep
a6 <- rep(6:7, each = 2)
a6

a <- c(a2, a4, a5)
a
length(a)
class(a)
mode(a)

# sequence
seq(0,100,25) 
seq(0,100,length.out = 5) # length for the output sequence 
diff(seq(0,100,length.out = 5))

# recycling rule
b1 <- seq(1,10, by=2) # seq(1,10,2)
b1
length(b1)

b2 <- 1:10
b2
length(b2)

b3 <- b1 + b2
b3
length(b3)

b4 <- b2/b1
b4
b4 <- round(b4, 2) # round(b4, digits=2)
?round
cbind(b1, b2, b3, b4)
class(cbind(b1, b2, b3, b4)) # cbind(): combine by column

# comparing vectors 
i <- 3
i == 3 # == : test for equality -> returns boolean value
i == pi 
i > 3 # > : bigger than
i >= 3 # >= : bigger or equal to 
i <= 3 # <= : smaller or equal to 
i < 3 # < :smaller than

i1 <- c(0,1,1,2,3, pi,4,5)
i2 <- c(0,1,0,2,3,pi,pi,5)
class(i1)
length(i1)
i1 == i2
i1 != i2 # != : not equal to 
i1 < i2
i1 <= i2
i1 > i2
i1 >= i2
which(i1==pi) # which() 
i1[6]
any(i1==pi) # returns TRUE if any value of i1 equals pi
all(i1==pi) # returns TRUE is all value of i1 are pi 

i3 <- 1:100
i3 < 3 # TRUE whenever i3 is less than 3
which(i3<3)
i3[i3<3] 
i3[which(i3<3)]
i3[c(1,2)]
i3[i3 %% 2 == 0] # return even number elements
i3[i3>median(i3)] # select all elements greater than the median 

i3 <- 100:1
i3
i3 %% 2 == 1
i3[i3 %% 2 == 1]
i3[i3 %% 2 == 0]
i3 %% 2 == 0
i3 <- c(101:2)
i3
i <- 1:10
i[c(T,T,T,T,T,F,F,T,F,T)]

# vector arithmetic
i4 <- 1:5
i5 <- 11:15
i4 + i5
i5-i4
i4*i5
i5/i4
i5^i4
log(10^2)
sqrt(i4)
log(i4)


#### List: 1d, vector #### 
mylist <- list(name="John", age=24, myvector=c("a","b","c"))
mylist
str(mylist)
mylist[1]
mylist[[1]]
mylist$name
class(mylist)
class(mylist$name)


#### Matrix: 2d, Homogeneous ####
?matrix
mat1 <- matrix(c(1:10,rep(1:5,2),seq(1,20, by=2)), nrow=10, ncol=3,
               byrow = TRUE, dimnames = list(c(letters[1:10]),c("one","two","three")))
mat2 <- matrix(c(1:10, rep(1:5,2), seq(1,20,by=2)), 10, 3,
               dimnames=list(c(letters[1:10]), c("one","two","three")))
mat1
mat2

mat1
class(mat1)
dim(mat1)
# dim(mat1) <- c(3,10)
a <- 1:20
dim(a) <- c(4,5)
a
?dim
mat1[1,] # index by row
mat1[,1] # index by column
mat1[3,3]
mat1[1:5,] # index first five rows
mat1[c(1,3),] # index first and third rows 
mat1[c(1,3), 2:3] # index second and third columns from first and third rows 
mat1[,3]
mat1[,3] <- sample(c(0,1),10,replace=TRUE) # replace column with new values
# ?sample
mat1
mat1[8,3] <- 10

mat2 <- t(mat1) # t(): transpose 
mat2


#### Factors ####
?factor
# a factor is a vector object used to specify a discrete classification of the 
# components of other vectors of the same length.
# level: each unique value in a vector
LETTERS
alphabet1 <- factor(LETTERS)
alphabet1

alphabet2 <- factor(LETTERS[1:10])
alphabet2
str(alphabet2)

alphabet3 <- factor(LETTERS[1:10], levels=LETTERS)
alphabet3 <- ordered(, levels = )
alphabet3
str(alphabet3)
class(alphabet3)
mode(alphabet3)
typeof(alphabet3)

g1 <- c("a", "b", "b", "a")
class(g1)
mode(g1)
g1

g <- factor(c("a","b","b","a"))
g
unique(g)
class(g)
mode(g)
levels(g)
g[3]
g[3] <- c("c")
g
levels(g) <- factor(c("a","b","c"))
levels(g)
g

number <- 1:3
num2 <- factor(number)
num2
num3 <- as.vector(num2)
class(num3)
# or
g2 <- factor(c("a","b","b","a"), levels=c("a","b","c"))
g2[5] <- c("c")
g2
summary(g2)

#### Data Frame: 2d, Heterogeneous ####
name <- c("Ellie","Taylor","Luke","Drake")
class(name)
gender <- c("Female","Female","Male","Male")
class(gender)
age <- c(20,25,26,23)
class(age)
weight <- c(50,55,70,75)

friends <- data.frame(name,gender,age,weight, stringsAsFactors = F)
friends
friends$gender
friends$gender <- factor(friends$gender)
str(friends)
dim(friends)
class(friends)
summary(friends)
ncol(friends)
nrow(friends)
colnames(friends)
rownames(friends)

friends$name
friends[,1]
friends[1,]
friends2 <- cbind(friends, data.frame(year=c(2,5,7,3)))
friends2
friends2[6] <- 1:4
friends2
colnames(friends2)
colnames(friends2)[6] <- "number"
friends2[6] 
class(colnames(friends))

# stringsAsFactors = FALSE : not transform character into factor
friends1 <- data.frame(name,gender,age,weight, stringsAsFactors = T)
friends1
str(friends1)
friends1$gender <- factor(friends1$gender)
summary(friends1)
length(friends2)
friends2[6]

#### Iris data ####
data(iris)
str(iris)
head(iris)
head(iris,10)
tail(iris)
View(iris)
summary(iris)

mytable <- table(iris$Species) # table()
mytable
str(mytable)
names(mytable)
df <- data.frame(mytable)
df
mytable[2][[1]]
mytable[[2]]
mytable[2][1]
mytable[2]

# draw samples
dim(iris)
nrow(iris)
ncol(iris)
irissample <- sample(1:nrow(iris),10) # nrow(): number of rows 
irissample
iris[irissample,]    


# different ways of indexing
colnames(iris)    # names(iris)
iris[10:20,  "Sepal.Length"]
iris[10:20, 1]
iris$"Sepal.Length"[10:20]
iris$Sepal.Length[10:20]

# subset
setosa1 <- subset(iris, Species == "setosa")
head(setosa1)
summary(setosa1)
setosa2 <- iris[iris$Species == "setosa",]
setosa3 <- iris[which(iris$Species == "setosa"),]
which(iris$Species == "setosa")
iris2 <- subset(iris, Species == "setosa", select=-c(Sepal.Length, Species))
head(iris2)

setosavirgnica <- iris[which(iris$Species %in% c("setosa","virginica") & iris$Sepal.Width > 3.5),]
str(setosavirgnica)
summary(setosavirgnica)

# explore variables 
# summary(): distributions for numeric variables, frequency for categorical variables 
summary(iris)
quantile(iris$Sepal.Length) # 꽃받침 
quantile(iris$Sepal.Length, c(0.1,0.5,0.9)) # designate quartiles
var(iris$Sepal.Length) # variance of Sepal.Length
sd(iris$Sepal.Length)

# histogram
hist(iris$Sepal.Length)

?hist

# install packages
install.packages("ggplot2")
library(ggplot2)
ggplot(iris, aes(x=Sepal.Length)) + 
  geom_histogram(bins=12, fill="white", colour="black")


# facet_grid() for histograms of multiple groups
ggplot(iris, aes(x=Sepal.Length)) +
  geom_histogram(fill="white", colour="black", binwidth = 0.2) +
  facet_grid(Species ~ .)

# density curve
plot(density(iris$Sepal.Length))
ggplot(iris, aes(x=Sepal.Length)) + 
  geom_density(fill="blue", alpha=.2)
ggplot(iris, aes(x=Sepal.Length)) + 
  geom_line(stat="density") + 
  expand_limits(y=0)

# overlay densitivy curve and histogram
ggplot(iris, aes(x=Sepal.Length, y=..density..))+
  geom_histogram(fill="cornsilk", colour="grey60", binwidth=.25) +
  geom_density() +
  xlim(2,10)
?ggplot
?geom_bar

table(iris$Species) # table(): frequency of categorical(factor) variable
pie(table(iris$Species))
barplot(table(iris$Species))
ggplot(iris, aes(x=Species, fill=Species)) +
  geom_bar(width=0.7) 

# explore multiple variables 
cor(iris$Sepal.Length, iris$Petal.Length) # correlation
cor(iris[,1], iris[,4])
cor(iris[,1:4]) # correlation matrix 

install.packages("corrplot")
library("corrplot")
??corrplot
corrplot(cor(iris[, 1:4]))
corrplot(cor(iris[, 1:4]), method = "ellipse")
corrplot(cor(iris[, 1:4]), method = "number")
corrplot(cor(iris[, 1:4]), method = "number", type = "lower")
plot(iris[,1:4])

# aggregate()
aggregate(Sepal.Length~Species, iris, summary)
aggregate(Sepal.Length~Species, iris, mean) # mean of Sepal.Length of every Species


# boxplot: IQR(interqurtile range, 25%-75%), median, max, min
boxplot(Sepal.Length~Species, iris)

# boxplot using ggplot2
ggplot(iris, aes(x=Species, y=Sepal.Length, fill=Species)) + 
  geom_boxplot()


# scatter plot: numeric variables  
with(iris, plot(Sepal.Length, Sepal.Width, col=Species, pch=as.numeric(Species)))
plot(iris$Sepal.Length, iris$Sepal.Width, col=iris$Species, pch=as.numeric(iris$Species))
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, colour=Species))+
  geom_point()



apply(iris[,1:4], 2, mean)
lapply(iris[,1:4], mean)
sapply(iris[,1:4], mean)
tapply(iris$Sepal.Length, iris$Species, mean)
by(iris$Sepal.Length, iris$Species, mean)
byspecies <- split(iris, iris$Species)  # list
head(byspecies)
str(byspecies)

