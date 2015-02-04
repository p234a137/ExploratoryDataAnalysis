
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

# # plotting systems
# Base: "artist's palette" model
# Lattice: Entire plot specified by one function; conditioning
# ggplot2: Mixes elements of Base and Lattice

# Base plotting system
library(datasets)
data(cars)
with(cars, plot(speed, dist))

# Lattice plot
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))

# ggplot2
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)


# Base plotting system
# simple graphics
par(mfrow=c(1,1))
library(datasets)
hist(airquality$Ozone)  ## Draw a new plot
with(airquality, plot(Wind, Ozone))
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")
# with annotation
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City")  ## Add a title
#
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
#
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))
# with regression line
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)
# multiple base plots
par(mfrow = c(1, 2))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})
#
par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "Ozone and Temperature")
  mtext("Ozone and Weather in New York City", outer = TRUE)
})

# graphics devices

# screen
par(mfrow = c(1, 1))
library(datasets)
with(faithful, plot(eruptions, waiting))  ## Make plot appear on screen device
title(main = "Old Faithful Geyser data")  ## Annotate with a title

# pdf file
pdf(file = "myplot.pdf")  ## Open PDF device; create 'myplot.pdf' in my working directory
## Create plot and send to a file (no plot appears on screen)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")  ## Annotate plot; still nothing on screen
dev.off()  ## Close the PDF file device
## Now you can view the file 'myplot.pdf' on your computer

# copying plots
library(datasets)
with(faithful, plot(eruptions, waiting))  ## Create plot on screen device
title(main = "Old Faithful Geyser data")  ## Add a main title
dev.copy(png, file = "geyserplot.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!






















