library(purrr)
library(microbenchmark)
library(ggplot2)
mat <- matrix(nrow = 5000, ncol = 100000)
set.seed(123)
a <- Sys.time()
mat[] <- rweibull(n = (nrow(mat) * ncol(mat)), shape = 2.58, scale = 14000)
b <- Sys.time() - a
print(b)

# sparse matrices are very time inefficient for this specific task. 
# benchmarking classic weibulldraws and drawing from columns of the predefined random numbers

lookup <- function() {
  ret <- mat[, rdunif(n = 1, 1, ncol(mat))]
  return(ret)
}

mbm <- microbenchmark(
  lkp = lookup(),
  drw = rweibull(n = nrow(mat), shape = 2.58, scale = 14000), 
  times = 1000,
  control = list(order = "block", warmup = 100)
)

autoplot(mbm)
t1 <- mean(mbm$time[1:1000])/1000000000
t2 <- mean(mbm$time[1001:2000])/1000000000
t2/t1

# performance increase by a factor of 18
# the only downside is, that a 5000*100000 matrix would take up around 3.7 GB of RAM. 
# but ram is cheap so we should not worry