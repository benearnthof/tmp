source("montecarlointegration.R")
curve(df(x, df1 = 5, df2 = 15), from = 0, to = 8)
curve(dnorm(x, mean = 0, sd = 1), from = -5, to = 5)

for (i in 1:1000) {
  x <- runif(1, min = -4, max = 4)
  y <- runif(1, min = 0, max = 0.4)
  points(x, y)
}

suspension <- 25000
curve(dweibull(x, shape = 2.51, scale = 14400), from = 0, to = 50000)
abline(v = suspension)
abline(h = 0)
cord.x <- c(0, seq(from = 0, to = suspension, by = 50), suspension)
cord.y <- c(0, dweibull(seq(0,suspension,50), shape = 2.51, scale = 14400), 0)
polygon(cord.x,cord.y,col = 'skyblue')

pweibull(suspension, 2.51, 14400)

form <- "(1/(sqrt(2*pi)))*exp(-(x^2)/2)"
form <- "dweibull(x, shape = 2.51, scale = 14400)"

poc <- fastmcintegrate(upp = 50000, def = form, steps = 100000000, fast = F)
heuristic <- fastmcintegrate(upp = suspension, def = form, steps = 100000000, fast = F)
exact <- pweibull(suspension, 2.51, 14400)

print(heuristic)
print(exact)
