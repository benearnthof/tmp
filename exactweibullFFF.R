sus <- c(seq(from = 50, to = 5500, by = 10))

heuristic <- function(suspensions, nw, beta, theta) {
  ret <- numeric(length = length(suspensions))
  for (i in 1:length(suspensions)) {
    susp_line <- suspensions[i]
    draws <- rweibull(nw, shape = beta, scale = 14400)
    check <- as.numeric(susp_line > draws)
    errors <- sum(check)
    ret[i] <- errors/nw
  }
  return(ret)
}

heur <- heuristic(suspensions = sus, nw = 5000, beta = 2.51, theta = 14400)

exact <- function(suspensions, beta, theta) {
  ret <- pweibull(sus, shape = beta, scale = theta)
  ret <- round(ret, digits = 4)
  return(ret)
}

exac <- exact(suspensions, beta = 2.51, theta = 14400)

simulation <- function(start = 1, end = 1000, susp, beta, theta) {
  ret <- numeric(length = length(start:end))
  for (i in start:end) {
    heu <- heuristic(suspensions = susp, nw = i, beta, theta)
    exa <- exact(suspensions = susp, beta, theta)
    ret[i] <- mean(abs(heu - exa))
  }
  x <- start:end
  lo <- loess(ret~x)
  plot(ret~x, pch = 4, cex = 0.25)
  lines(predict(lo), col='lightblue', lwd=2)
}

simulation(start = 1, end = 5000, susp = sus, beta = 2.51, theta = 14400)

mbm <- microbenchmark::microbenchmark(
  heur <- heuristic(suspensions = sus, nw = 1000, beta = 2.51, theta = 14400),
  exac <- exact(suspensions = sus, beta = 2.51, theta = 14400),
  times = 100L, 
  control = list(order = "block", warmup = 25)
)

result <- cbind(mbm$expr, mbm$time)
result <- as.data.frame.matrix(result)
names(result) <- c("Expression", "Time")

ggplot2::ggplot(data = result, aes(x=result$Expression, y=result$Time)) + 
  geom_boxplot(aes(group = result$Expression))

autoplot(mbm)
