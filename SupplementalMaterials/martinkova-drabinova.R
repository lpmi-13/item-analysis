install.packages("ShinyItemAnalysis")
library(ShinyItemAnalysis)

############################################
# Generating plots and tables from console #
############################################

##=======================#####
## Loading HCI data sets #####
##=======================#####

data(HCI, HCIkey, HCItest)

# binary data set
head(HCI)
dataBin <- HCI[, 1:20]

# nominal data set
head(HCItest)
dataNom <- HCItest[, 1:20]

# key for nominal data set
(key <- unlist(HCIkey))

# group
(gender <- HCI[, 21])

# criterion
(major <- HCI[, 22])

##==================================#####
## Difficulty - discrimination plot #####
##==================================#####
?DDplot

# DDplot of binary data set
DDplot(dataBin)

# DDplot of binary data using generalized ULI
# discrimination based on 5 groups, comparing 4th and 5th
DDplot(dataBin, k = 5, l = 4, u = 5)

# DDplot displaying other Discrimination indices
DDplot(dataBin, discrim = "RIT")
DDplot(dataBin, discrim = "RIR")
DDplot(dataBin, discrim = "none")

##=================#####
## Generalized ULI #####
##=================#####
?gDiscrim

# ULI for first 5 items for binary data set
gDiscrim(dataBin)

# Generalized ULI using 5 groups, comparing 4th and 5th for binary data set
gDiscrim(dataBin, k = 5, l = 4, u = 5)

##=================================#####
## Traditional item analysis table #####
##=================================#####
?ItemAnalysis

# Item analysis 
head(ItemAnalysis(dataBin, y = major))
round(ItemAnalysis(dataBin, y = major), 2)

##===========================#####
## Distractor analysis table #####
##===========================#####
?DistractorAnalysis

# distractor analysis for HCI data set
DistractorAnalysis(dataNom, key)

# distractor analysis for HCI data set with proportions
DistractorAnalysis(dataNom, key, p.table = T)

# distractor analysis for HCI data set for 6 groups
DistractorAnalysis(dataNom, key, num.group = 6)

##==========================#####
## Distractor analysis plot #####
##==========================#####
?plotDistractorAnalysis

# distractor analysis plot for items 7, 13 and 18
plotDistractorAnalysis(dataNom, key, item = 7)
plotDistractorAnalysis(dataNom, key, item = 13)
plotDistractorAnalysis(dataNom, key, item = 18)

# distractor analysis plot for item 13 and 6 groups
plotDistractorAnalysis(dataNom, key, num.group = 6, item = 13)

##==============#####
## Wright Map   ##### 
##==============#####
?ggWrightMap
library(mirt)

# fit Rasch model with mirt package
fit <- mirt(dataBin, model = 1, itemtype = "Rasch")
# factor scores
theta <- as.vector(fscores(fit))
# difficulty estimates
b <- coef(fit, simplify = T)$items[, "d"]

ggWrightMap(theta, b)

##==========================================#####
## plots for DIF analysis using IRT methods #####
##==========================================#####
?plotDIFirt
library(difR)
library(ltm)

# Estimation of 2PL IRT model and Lord's statistic
# by difR package
fitLord <- difLord(dataBin, group = gender, focal.name = 1, model = "2PL")

# plot of item 1 and Lord's statistic
plotDIFirt(fitLord$itemParInit, item = 1)

# Estimation of 2PL IRT model and Raju's statistic
# by difR package
fitRaju <- difRaju(dataBin, group = gender, focal.name = 1, model = "2PL")
# plot of item 1 and Lord's statistic
plotDIFirt(fitRaju$itemParInit, test = "Raju", item = 1)

##==============================================#####
## plots for DIF analysis using Logistic models #####
##==============================================#####
?plotDIFLogistic

# Characteristic curve by logistic regression model
plotDIFLogistic(dataBin, group = gender, item = 1)

# Characteristic curve by logistic regression model using scaled score
plotDIFLogistic(dataBin, group = gender, item = 1, IRT = T)

##================================#####
## Adding ShinyItemAnalysis theme #####
##================================#####
?theme_app
library(ggplot2)

# total score calculation
df <- data.frame(score = apply(dataBin, 1, sum))

# colors by cut-score
cut <- median(df$score) # cut-score 
color <- c(rep("red", cut - min(df$score)), "gray", rep("blue", max(df$score) - cut))

# histogram
g <- ggplot(df, aes(score)) +
  geom_histogram(binwidth = 1, fill = color, col = "black") + 
  xlab("Total score") +
  ylab("Number of respondents")

g
g + theme_app()

######################################
# Starting the ShinyItemAnalysis app #
######################################

rm(list = ls())
startShinyItemAnalysis()
