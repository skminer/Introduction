# Jan 2016: bm1
bm1 <- read.csv("/Users/Sodami/Documents/OneDrive/R_Lecture/slack_assignments/bm_Jan2016.csv")
summary(bm1)
str(bm1)
head(bm1)
names(bm1[1:7])
bm1 <- na.omit(bm1[1:7])
sort(bm1$dollar_price, decreasing = T)

?levels


ggplot(bm1, aes(x=factor(Country), y=dollar_valuation)) +
  geom_bar(stat="identity")
library(ggplot2)
ggplot(bm1, aes(x=dollar_valuation)) +
  geom_histogram(binwidth = 10, fill = "burlywood1", col = "blue") 

bm1$undervalue <- with(bm1, ifelse((dollar_valuation >= 0), "overvalued",
                                   "undervalued"))
bm1$undervalue <- factor(bm1$undervalue, 
                         levels = c("overvalued", "undervalued"),
                         labels = c("over", "under"))
table(bm1$undervalue)

std <- bm1[bm1$Country == "United States", "dollar_price"]; std
class(std)
bm1[bm1$Country == "United States",]
bm1$percent <- with(bm1, round(((dollar_price/std)-1)*100),2)
bm1$percent
bm1$dollar_price/std-1
4.93*(0.5152733)

library(ggplot2)
bm1[,c("Country", "undervalue", "dollar_price")]



ggplot(bm1, aes(x=dollar_price, y=reorder(Country, dollar_price))) +
  geom_point(size = 3) +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(color = "#C3AEFF", linetype = "dashed")) +
  labs(title = "Big Mac Index of Jan 2016") +
  xlab("Dollar Price ($)") + 
  ylab("Country")
?theme
ggplot(bm1, aes(x=reorder(Country, dollar_price), y=dollar_price)) +
  geom_point(size = 3) +
  theme_bw()


ggplot(bm1, aes(x = dollar_price, y = reorder(Country, dollar_price))) +
  geom_segment(aes(yend = Country), xend = 0, colour = "#C3AEFF") +
  geom_point(size = 3, aes(colour=undervalue)) +
  scale_color_brewer(type = "seq", palette = "Reds", limits = c("under", "over")) +
  theme_bw() +
  theme(panel.grid.major.y = element_blank(),
        legend.position=c(1,0.5),
        legend.justification=c(1,0.5))

bm1$undervalue <- bm1$dollar_valuation >= 0 
ggplot(bm1[21:35,], aes(x=Country, y=dollar_valuation, fill=undervalue)) + 
  geom_bar(stat = "identity", position = "identity", colour = "midnightblue", size = 1.5) +
  scale_fill_manual(values = c("#B23C0D", "#12B298"), guide = FALSE)


