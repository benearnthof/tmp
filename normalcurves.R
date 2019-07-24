curve(df(x, df1 = 5, df2 = 15), from = 0, to = 8)
curve(dnorm(x, mean = 0, sd = 1), from = -5, to = 5)

for (i in 1:1000) {
  x <- runif(1, min = -4, max = 4)
  y <- runif(1, min = 0, max = 0.4)
  points(x, y)
}

curve(dweibull(x, shape = 2.51, scale = 14400), from = 0, to = 50000)
abline(v = 22000)
abline(h = 0)
pweibull(22000, 2.51, 14400)
