gibbs = function(N,thin) {
  x=0
  y=0
  mat <- matrix(nrow = N, ncol = 2)
  cat(paste("Iter","x","y","n"))
  for (i in 1:N) {
    for (j in 1:thin) {
      x=rgamma(1,3,y*y+4)
      y=rnorm(1,1/(x+1),1/sqrt(2*x+2))
    }
    cat(paste(i,x,y,"n"))
    mat[i,] <- c(x,y)
  }
  return(mat)
}
matrix <- gibbs(10000,1)

# Packages
library(hexbin)
library(RColorBrewer)

# Create data
x <- matrix[,1]
y <- matrix[,2]

# Make the plot
bin<-hexbin(x, y, xbins=50)
my_colors=colorRampPalette(rev(brewer.pal(11,'Spectral')))
plot(bin, main="" , colramp=my_colors , legend=F ) 

library(MASS)
den3d <- kde2d(x, y)
persp(den3d, box=FALSE)

library(plotly)
plot_ly(x=den3d$x, y=den3d$y, z=den3d$z) %>% add_surface()
