
# https://github.com/DataScienceSpecialization/courses/blob/master/04_ExploratoryAnalysis/hierarchicalClustering/index.Rmd
myplclust <- function( hclust, lab=hclust$labels, lab.col=rep(1,length(hclust$labels)), hang=0.1,...){
  ## modifiction of plclust for plotting hclust objects *in colour*!
  ## Copyright Eva KF Chan 2009
  ## Arguments:
  ##    hclust:    hclust object
  ##    lab:        a character vector of labels of the leaves of the tree
  ##    lab.col:    colour for the labels; NA=default device foreground colour
  ##    hang:     as in hclust & plclust
  ## Side effect:
  ##    A display of hierarchical cluster with coloured leaf labels.
  y <- rep(hclust$height,2); x <- as.numeric(hclust$merge)
  y <- y[which(x<0)]; x <- x[which(x<0)]; x <- abs(x)
  y <- y[order(x)]; x <- x[order(x)]
  plot( hclust, labels=FALSE, hang=hang, ... )
  text( x=x, y=y[hclust$order]-(max(hclust$height)*hang),
        labels=lab[hclust$order], col=lab.col[hclust$order], 
        srt=90, adj=c(1,0.5), xpd=NA, ... )
}

# Hierarchical clustering Hierarchical clustering
# An agglomerative approach
#  - Find closest two things
#  - Put them together
#  - Find next closest
# Requires
#  - A defined distance
#  - A merging approach
# Produces
#   A tree showing how close things are to each other

# How do we define close? Distance or similarity
#   - Continuous: euclidian distance
#   - Continuous: correlation similarity
#   - Binary: Manhattan distance

# http://rafalab.jhsph.edu/688/lec/lecture5-clustering.pdf
# http://en.wikipedia.org/wiki/Taxicab_geometry

set.seed(1234)
par(mar = c(0,0,0,0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1,2,1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x+0.05, y+0.05, labels = as.character(1:12))

dataFrame <- data.frame(x = x, y = y)
dist(dataFrame)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)
# prettier dendogram
myplclust(hClustering,lab=rep(1:3,each=4),lab.col=rep(1:3,each=4))
