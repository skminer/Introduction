#---------------------------------------------------------#

#### Market Basket Analysis ####

#---------------------------------------------------------#

# Groceries data: Michael Hahsler, Kurt Hornik, and Thomas Reutter (2006) 
# Implications of probabilistic data modeling for mining associaiton rules.


#### install packages ####
install.packages("arules")
install.packages("arulesViz")
install.packages("RColorBrewer")
install.packages("cluster")

library(arules)  # association rules
library(arulesViz)  # data visualization of association rules
library(RColorBrewer)  # color palettes for plots
library(cluster)  # cluster analysis for market segmentation

# load data
??Groceries
data(Groceries)  # grocery transcations object from arules package

# show the dimensions of the transactions object
dim(Groceries)
dim(Groceries)[1]  # 9835 market baskets for shopping trips 
# nrow(Groceries)
# length(Groceries)
dim(Groceries)[2]  # 169 initial store items  
# ncol(Groceries )


summary(Groceries)
# The density value of 0.02609146 (2.6 percent) refers to the proportion of 
# non-zero matrix cells. Since there are 9835 * 169 = 1662115 positions in the matrix, 
# we can calculate that a total of 1662115 * 0.02609146 = 43367 items were purchased during the store's 30 days of operation (assuming no duplicate items were purchased).
# we can determine that the average transaction contained 43367 / 9835 = 4.409 different grocery items. 

# A total of 2,159 transactions contained only a single item, 
# while one transaction had 32 items.

str(Groceries) # class: transactions 

inspect(Groceries[1:5]) # shows the first five transactions 
inspect(head(Groceries)) # shows the first six transactions 

# itemFrequency() function allows us to see the proportion of transactions that contain the item.
itemFrequency(Groceries[,1:3]) # itemFrequency() shows the frequency of items

itemFrequencyPlot(Groceries, support = 0.05)
itemFrequencyPlot(Groceries, topN = 10)
itemFrequencyPlot(Groceries, topN = 20) 
image(Groceries[1:10]) # visualizes sparse binary matrix for the first ten transactions 
image(sample(Groceries, 100)) # visualizes random sample of 100 transactions

#### examine frequency for each item with support greater than 0.025 ####
pdf(file="fig_market_basket_initial_item_support.pdf", 
    width = 8.5, height = 11)
itemFrequencyPlot(Groceries, support = 0.05, cex.names=0.8, xlim = c(0,0.3),
                  type = "relative", horiz = TRUE, col = "dark red", las = 2,
                  xlab = paste("Proportion of Market Baskets Containing Item",
                               "\n(Item Relative Frequency or Support)"))
dev.off()    


#### explore possibilities for combining similar items ####
head(itemInfo(Groceries)) 
head(Groceries@itemInfo)
levels(itemInfo(Groceries)[["level1"]])  # 10 levels... too few 
levels(itemInfo(Groceries)[["level2"]]) # 55 distinct levels

#### aggregate items using the 55 level2 levels for food categories ####
# to create a more meaningful set of items
groceries <- aggregate(Groceries, itemInfo(Groceries)[["level2"]])  

dim(groceries)[1]  # 9835 market baskets for shopping trips
dim(groceries)[2]  # 55 final store items (categories)  
summary(groceries)

itemFrequencyPlot(groceries, support = 0.1)
itemFrequencyPlot(groceries, topN = 10)

pdf(file="fig_market_basket_final_item_support.pdf", width = 8.5, height = 11)
itemFrequencyPlot(groceries, support = 0.05, cex.names=1.0, xlim = c(0,0.5),
                  type = "relative", horiz = TRUE, col = "blue", las = 1,
                  xlab = paste("Proportion of Market Baskets Containing Item",
                               "\n(Item Relative Frequency or Support)"))
dev.off()   

#### obtain large set of association rules for items by category and all shoppers ####
# this is done by setting very low criteria for support and confidence
first.rules <- apriori(groceries, 
                       parameter = list(support = 0.001, confidence = 0.05))
summary(first.rules)  # yields 69,921 rules... too many

#### select association rules using thresholds for support and confidence ####
second.rules <- apriori(groceries, 
                        parameter = list(support = 0.025, confidence = 0.05))
summary(second.rules)  # yields 344 rules
str(second.rules)
inspect(second.rules[100:110])
summary(second.rules@quality)
summary(second.rules@quality$lift)

#### data visualization of association rules in scatter plot ####
pdf(file="fig_market_basket_rules.pdf", width = 8.5, height = 8.5)
plot(second.rules, 
     control=list(jitter=2, col = rev(brewer.pal(9, "Greens")[4:9])),
     shading = "lift")   
dev.off()    

#### grouped matrix of rules ####
pdf(file="fig_market_basket_rules_matrix.pdf", width = 8.5, height = 8.5) # to check where this plot is stored, try getwd()
plot(second.rules, method="grouped",   
     control=list(col = rev(brewer.pal(9, "Greens")[4:9])))
dev.off()    
groceries@data
groceries@data@p

#### select rules with vegetables in consequent (right-hand-side) item subsets ####
itemInfo(groceries)[["level2"]]
vegie.rules <- subset(second.rules, rhs %in% "vegetables")
inspect(vegie.rules)  # 41 rules
summary(vegie.rules)
beef.rules <- subset(second.rules, subset = rhs %in% "beef" & lift > 1.3)
inspect(beef.rules) # 6 rules 

#### sort by lift and identify the top 10 rules ####
top.vegie.rules <- head(sort(vegie.rules, decreasing = TRUE, by = "lift"), 10)
inspect(top.vegie.rules) 

inspect(head(sort(vegie.rules, by = "confidence"), 5))
inspect(head(sort(vegie.rules, by = "support"), 5))

str(vegie.rules)

#### model subsetting ####
vegie.rules.sub <- vegie.rules[quality(vegie.rules)$confidence > 0.5]
length(vegie.rules.sub)
inspect(vegie.rules.sub)

#### plotting top.vegie.rules ####
plot(top.vegie.rules)
plot(top.vegie.rules, interactive = TRUE) # Interactive mode
plot(top.vegie.rules, measure = c("support", "lift"), 
     shading = "confidence",
     interactive = TRUE)

pdf(file="fig_market_basket_farmer_rules.pdf", width = 11, height = 8.5)
plot(top.vegie.rules, method="graph", 
     control=list(type="items"), 
     shading = "lift")
    # interactive = TRUE)
dev.off()  

plot(vegie.rules, method = "matrix", measure = "lift")
plot(vegie.rules, method = "matrix", measure = c("lift", "confidence"))
plot(vegie.rules, method = "matrix3D", measure = "lift")
plot(vegie.rules, method = "grouped")
plot(head(sort(vegie.rules, by = "lift"), 10),
      method = "graph", control = list(type = "items"))
