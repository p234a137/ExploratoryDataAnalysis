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
