#### R Colors ####
colors()
color <- c("#FF0000", "#FFFF00","#00FF00", "#00FFFF", "#0000FF", "#FF00FF")
pie(rep(1,5), col = color, labels = color)
par(new = T)
pie(rep(1,1), col = "white", radius = 0.5, labels = "")
dev.off()

pie(rep(1,12), col = rainbow(12), border = "black",
    clockwise = TRUE, labels = "")
par(new = T)
pie(rep(1,1), col = "white", radius = 0.3, border = "white", labels = "")

# colors that grDevices pakcage provide
n <- 11
barplot(rep(1,n), col = rainbow(n, alpha = 1), axes = F, main = "rainbow colors")
barplot(rep(1,n), col = rainbow(n, alpha = 0.3), axes = T, main = "rainbow colors")
barplot(rep(1,n), col = heat.colors(n, alpha = 1), axes = F, main = "heat colors")
barplot(rep(1,n), col = terrain.colors(n, alpha = 1), axes = F, main = "terrain colors")
barplot(rep(1,n), col = topo.colors(n, alpha = 1), axes = F, main = "topo colors")
barplot(rep(1,n), col = cm.colors(n, alpha = 1), axes = F, main = "cyan-magenta colors")

n <- 11
pie(rep(1,n), col = rainbow(n), main = "rainbow colors")
pie(rep(1,n), col = heat.colors(n), main = "heat colors")
pie(rep(1,n), col = terrain.colors(n), main = "terrain colors")
pie(rep(1,n), col = topo.colors(n), main = "topo colors")
pie(rep(1,n), col = cm.colors(n), main = "cyan-magenta colors")
dev.off()

# HEX code
rainbow(8, alpha = 1)
cm.colors(12, alpha = 0.3)
cm.colors(12)

# RColorBrewer package
# install.packages("RColorBrewer")
library(RColorBrewer)

# sequential
display.brewer.all(type = "seq")

barplot(rep(1,7), col = brewer.pal(7,"Reds"), axes = F, main = "Brewer Reds")
barplot(rep(1,7), col = brewer.pal(7,"Greens"), axes = F, main = "Brewer Greens")
barplot(rep(1,7), col = rev(brewer.pal(7,"Greens")), axes = F, main = "Brewer Greens")


# diverging
display.brewer.all(type = "div")

# qualitative
display.brewer.all(type = "qual")



#### Stem-and-Leaf Plots ####

BabeRuth <- data.frame(year = 1920:1934, 
                       homerun = c(54,59,35,41,46,25,47,60,54,46,49,46,41,34,22))
BabeRuth
?stem
stem(BabeRuth$homerun)
stem(BabeRuth$homerun, scale = 2)


#### Histogram ####
hist(BabeRuth$homerun)
hist(BabeRuth$homerun, xlim = c(0, max(BabeRuth$homerun)*1.2))
hist(BabeRuth$homerun, xlim = c(0, max(BabeRuth$homerun)*1.2), breaks = 10)
hist(BabeRuth$homerun, xlim = c(0, max(BabeRuth$homerun)*1.2), 
     main = "Home runs of Babe Ruth",xlab = "Number of Home runs", ylab = "Frequency",
     col = c(rep("lightblue",2), rep("royalblue",2), rep("navyblue",4)))


#### Bar graph #### 
bloodtype <- c(rep("A", 25), rep("B", 50), rep("O", 20), rep("AB", 15))
table(bloodtype)
sort.bloodtype <- sort(table(bloodtype), decreasing = T)
sort.bloodtype
par(mfrow = c(1,2))
slices <- c("red", "blue", "yellow", "green")
pie(sort.bloodtype, col = slices, radius = 1, main = "pie chart")
barplot(sort.bloodtype, col = slices, main = "bar graph of blood type")
dev.off()

# pie chart
?"grDevices"
require(grDevices)
parties <- c("first","second","third","fourth")
seats <- c(122,123,38,6)
pie.vote <- round(prop.table(seats),4) 
pie.vote
seats/sum(seats)
prop.table(seats)
table(seats)
names(pie.vote) <- paste(parties, seats, "명", sep = "")
par(mfrow = c(1,2))
cols <- c("red", "midnightblue", "green", "magenta", "yellow")
par(family = "AppleGothic")
pie(pie.vote, col = cols, main = "pie chart")
par(new = T)  
pie(seats, radius = 0.8, col = "white", label = NA, border = NA)
text(0,0,paste("all seats are:", sum(seats), sep = ""))
dev.off()
par(family = "AppleGothic")
barplot(pie.vote, col = cols, 
        main = "bar graph of seats of the parties", 
        legend.text = parties)
dev.off()
windowsFonts(malgun = windowsFont("?????? ??????"))


#### Bar Graph ####
install.packages("gcookbook")
library(gcookbook)
install.packages("ggplot2")
library(ggplot2)

# x-axis here is discrete (representing groups)
pg_mean
ggplot(pg_mean, aes(x=group, y=weight)) +
  geom_bar(stat="identity") 

BOD
# factor() : convert the continuous -> discrete variable
str(BOD)

ggplot(BOD, aes(x=factor(Time), y=demand)) + 
  geom_bar(stat="identity", fill="deeppink", color="purple")

#### Grouping bars together by a second variable ####
cabbage_exp
cabbage_exp <- cabbage_exp[,c(1:3)]
cabbage_exp
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity", position="dodge", color="black") + 
  scale_fill_brewer(palette="Pastel1")

