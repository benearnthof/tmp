# maximum likelihood for coin toss
smp10 <- sample(c(0, 1), size = 10, replace = T)
smp100 <- sample(c(0, 1), size = 100, replace = T)
smp1000 <- sample(c(0, 1), size = 1000, replace = T)

# basis: theta is element [0;1]

lkh <- function(sample) {
  ret <- numeric(length = 99L)
  for (theta in seq(from = 0.01, to = 0.99, by = 0.01)) {
    psampleoftheta <- (theta^sample) * ((1 - theta)^(1 - sample))
    ret[(100 * theta)] <- prod(psampleoftheta)
  }
  x <- seq(from = 0.01, to = 0.99, by = 0.01)
  plot(ret ~ x, ylim = c(0,(max(ret, na.rm = T) + mean(ret, na.rm = T))))
}

lkh(smp10)
lkh(smp100)
lkh(smp1000)

llkh <- function(sample) {
  ret <- numeric(length = 99L)
  for (theta in seq(from = 0.01, to = 0.99, by = 0.01)) {
    psampleoftheta <- (theta^sample) * ((1 - theta)^(1 - sample))
    ret[(100 * theta)] <- prod(psampleoftheta)
  }
  ret <- log(ret)
  x <- seq(from = 0.01, to = 0.99, by = 0.01)
  plot(ret ~ x)
}
llkh(smp10)
llkh(smp100)
llkh(smp1000)

t1 <- sample(c(0, 1), size = 10, replace = T, prob = c(0.25, 0.75))
t2 <- sample(c(0, 1), size = 100, replace = T, prob = c(0.25, 0.75))
t3 <- sample(c(0, 1), size = 1000, replace = T, prob = c(0.25, 0.75))

lkh(t1)
abline(v = 0.75)
lkh(t2)
abline(v = 0.75)
lkh(t3)
abline(v = 0.75)
