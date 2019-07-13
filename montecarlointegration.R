fastmcintegrate <- function(lwr = 0, upp = 1, def = "x^2", steps = 1000, ymin = 0) {
  x <- seq(from = lwr, to = upp, by = (upp - lwr)/steps)
  ymaxheuristic <- max(eval(parse(text = def)))
  x <- runif(steps, min = lwr, max = upp)
  ev <- eval(parse(text = def))
  ymax <- max(ymaxheuristic) + 1
  y <- runif(steps, min = ymin, max = ymax)
  area <- (upp - lwr) * ymax
  check <- y < ev
  ret <- (sum(check)/steps) * area
  return(ret)
}

form <- "(1/(sqrt(2*pi)))*exp(-(x^2)/2)"

fastmcintegrate(upp = 10, def = form, steps = 10000000)
fastmcintegrate(upp = 25, def = form, steps = 10000000)
system.time(fastmcintegrate(upp = 25, def = form, steps = 10000000))
# > fastmcintegrate(upp = 25, def = form, steps = 10000000)
# [1] 0.4998491
# > system.time(fastmcintegrate(upp = 25, def = form, steps = 10000000))
#  user  system elapsed 
# 0.966   0.111   1.086 

library(profvis)
profvis(fastmcintegrate(upp = 10, def = form, steps = 10000000))
