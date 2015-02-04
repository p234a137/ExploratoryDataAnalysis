
# # Principles of Analytic Graphics
# Principle 1: Show comparisons
# Principle 2: Show causality, mechanism, explanation
# Principle 3: Show multivariate data
# Principle 4: Integrate multiple modes of evidence
# Principle 5: Describe and document the evidence
# Principle 6: Content is king
# Edward Tufte (2006). Beautiful Evidence, Graphics Press LLC. www.edwardtufte.com

# # Exploratory graphs
# To understand data properties
# To find patterns in data
# To suggest modeling strategies
# To "debug" analyses
# # Characteristics of exploratory graphs
# They are made quickly
# A large number are made
# The goal is for personal understanding
# Axes/legends are generally cleaned up (later)
# Color/size are primarily used for information

#
if(!file.exists("./data")){dir.create("./data")}
# https://github.com/DataScienceSpecialization/courses
pollution <- read.csv("data/avgpm25.csv", colClasses = c("numeric", "character", 
                                                         "factor", "numeric", "numeric"))
head(pollution)

# # Simple Summaries of Data
# # One dimension
# Five-number summary
summary(pollution$pm25)
# Boxplots
boxplot(pollution$pm25, col = "blue")
abline(h = 12)
# Histograms
hist(pollution$pm25, col = "green")
rug(pollution$pm25)
# Density plot
# Barplot
barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")

##
# # Two dimensions
# Multiple/overlayed 1-D plots (Lattice/ggplot2)
boxplot(pm25 ~ region, data = pollution, col = "red")
par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")
# Scatterplots
par(mfrow=c(1,1))
with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)
# color
with(pollution, plot(latitude, pm25, col = region))
abline(h = 12, lwd = 2, lty = 2)
# multiple
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))
# Smooth scatterplots
# >2 dimensions
# Overlayed/multiple 2-D plots; coplots
# Use color, size, shape to add dimensions
# Spinning plots
# Actual 3-D plots (not that useful)


# Exploratory plots are "quick and dirty"
# Let you summarize the data (usually graphically) and highlight any broad features
# Explore basic questions and hypotheses (and perhaps rule them out)
# Suggest modeling strategies for the "next step"
