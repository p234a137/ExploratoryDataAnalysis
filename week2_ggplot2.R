# What is ggplot2?        
# • An implementation of the Grammar of Graphics by Leland Wilkinson
# • Written by Hadley Wickham (while he was a graduate student at Iowa State)  
# • A “third” graphics system for R (along with base and lattice)
# • Available from CRAN via install.packages()
# • Web site: http://ggplot2.org (better documentation)
# 
# • Grammar of graphics represents and abstraction of graphics ideas/objects
# • Think “verb”, “noun”, “adjective” for graphics
# • Allows for a “theory” of graphics on which to build new graphics and graphics objects
# • “Shorten the distance from mind to page”

# Grammar of Graphics 
# “In brief, the grammar tells us that a statistical
# graphic is a mapping from data to aesthetic
# attributes (colour, shape, size) of geometric
# objects (points, lines, bars). The plot may also
# contain statistical transformations of the data
# and is drawn on a specific coordinate system”
# from ggplot2 book

# The Basics: qplot()
# • Works much like the plot func:on in base graphics system
# • Looks for data in a data frame, similar to la$ce, or in the parent environment
# • Plots are made up of aesthetics (size, shape, color) and geoms (points, lines)

# • Factors are important for indicating subsets of the data 
#   (if they are to have different properties); they should be labeled
# • The qplot() hides what goes on underneath, which is okay for most operations
# • ggplot() is the core function and very flexible for doing things qplot() cannot do

library(ggplot2)
str(mpg)
qplot(displ, hwy, data = mpg)
# modifying aesthetics, color using factor, auto-generated legend
qplot(displ, hwy, data = mpg, color = drv)
# adding a geom
qplot(displ, hwy, data = mpg, geom = c("point","smooth"))
# histograms
qplot(hwy, data = mpg, fill = drv)
# facets (multiplots, split along factors)
qplot(displ, hwy, data = mpg, facets = .~drv)
qplot(hwy, data = mpg, facets = drv~., binwidth = 2)


#
maacs <- readRDS("data/maacs_env.rds")
str(maacs)
# add a factor variable
maacs$MxFactor <- ifelse(maacs$MxNum > 7600,"lower-Mx", "higher-Mx")
$ plot
# histogram
qplot(log(no2),  data	=	maacs)
# histogram by group
qplot(log(no2),  data	=	maacs,	fill	=	MxFactor) # <- does not work, need a factor variable
# density smooth
qplot(log(no2),  data	=	maacs,	geom	=	"density")
# by group
qplot(log(no2),  data	=	maacs,	geom	=	"density",	color	=	MxFactor)	
# scatterplots
qplot(log(pm25),  log(no2),	data	=	 maacs)	
qplot(log(pm25),  log(no2),	data = maacs,	shape	=	MxFactor)
qplot(log(pm25),  log(no2),  data = maacs,	color	=	MxFactor)
# scatterplot with smooth linear model
qplot(log(pm25), log(no2), data = maacs, color = MxFactor,
      geom = c("point", "smooth"), method = "lm")       
# facets
qplot(log(pm25), log(no2), data = maacs, color = MxFactor,
      geom = c("point", "smooth"), method = "lm", facets = .~MxFactor)  


################
# Basic  Components of a ggplot2 Plot   
# • A data frame 
# • aesthetic mappings: how data are mapped to color, size      
# • geoms: geometric objects like points, lines, shapes.  
# • facets: for conditional plots.      
# • stats: statistical transforma:ons like binning, quantiles, smoothing.  
# • scales: what scale an aesthe:c map uses (example: male = red, female = blue).       
# • coordinate system   

# Building Plots with ggplot2
# • When building plots in ggplot2 (rather than using qplot) the “artist’s palettee” model may be the closest analogy
# • Plots are built up in layers
# – Plot the data 
# – Overlay a summary
# – Metadata and annotations

# example
# Does BMI (normal vs. overweight) modify the relationship between PM2.5 and asthma symptoms?
# I do not have the original dataset, so doing what I can
qplot(log(pm25), VisitNum, data = maacs, facets = . ~ MxFactor, geom = c("point", "smooth"), method = "lm")

## Layers with ggplot
# initial call
g <- ggplot(maacs, aes(log(pm25), VisitNum))
summary(g)
print(g) # will get error, no layers in plot yet
p <- g + geom_point()
print(p)
# adding more layers, smooth
g + geom_point() + geom_smooth()
# choosing smooth method
g + geom_point() + geom_smooth(method = "lm")
# adding facets
g + geom_point() +  facet_grid(. ~ MxFactor) + geom_smooth(method = "lm")

# Annotation
# • Labels: xlab(), ylab(), labs(), ggtitle()
# • Each of the “geom” functions has options to modify    
# • For things that only make sense globally, use theme()         
# – Example: theme(legend.position = "none")      
# • Two standard appearance themes are included   
# – theme_gray(): The default theme (gray background) 
# – theme_bw(): More stark/plain  

# modifying aesthetics
# using constant values
g + geom_point(color = "steelblue", size = 4, alpha = 1/2)
# using data variable
g + geom_point(aes(color = MxFactor), size = 4, alpha = 1/2)
# modifying labels
g + geom_point(aes(color = MxFactor)) + labs(title = "Main Title") + labs(x = expression("log "* PM[2.5]), y = "vertical axis")
# customizing the smooth, se = FALSE => no standard error band
g + geom_point(aes(color = MxFactor), size = 2, alpha = 1/2) + geom_smooth(size = 4, linetype = 3,  method = "lm", se = FALSE)
# changing theme
g + geom_point(aes(color = MxFactor)) + theme_bw(base_family = "Times") # Times = the font family for everything

# note on axis limits
# regular plot
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50,2] <- 100 ## Outlier!
plot(testdat$x, testdat$y, type = "l", ylim = c(-3,3)) # outlier is outside the vertical plot limits
# ggplot2
g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line() # outlier inside plot vertical limits
g + geom_line() + ylim(-3, 3) # outlier missing altogether from data
g + geom_line() + coord_cartesian(ylim = c(-3, 3)) # outlier in data but outside plot limits

# make categorical data using cut()
cutpoints <- quantile(maacs$no2, seq(0, 1, length = 5), na.rm = TRUE)
maacs$no2dec <- cut(maacs$no2, cutpoints)
levels(maacs$no2dec)
## Setup ggplot with data frame
g <- ggplot(maacs, aes(log(pm25), VisitNum))
## Add layers
g + geom_point(alpha = 1/3) +
  facet_wrap(MxFactor ~ no2dec, nrow = 2, ncol = 5) +
  geom_smooth(method="lm", se=FALSE, col="steelblue") +
  theme_bw(base_family = "Avenir", base_size = 10) +
  labs(x = expression("log " * PM[2.5])) +
  labs(y = "Nocturnal Symptoms") +
  labs(title = "MAACS Cohort")
       
       











