getestimation <- function(k, t) {
  kt <- k * t
  x <- 1 - exp(-kt)
  term1 <- x / t
  term2 <- sum(sapply(1:2, function(i) (x^i) / i)) / t
  term3 <- sum(sapply(1:3, function(i) (x^i) / i)) / t
  term10 <- sum(sapply(1:10, function(i) (x^i) / i)) / t
  term100 <- sum(sapply(1:100, function(i) (x^i) / i)) / t
  return(data.frame(k = k, t = t, term1 = term1, term2 = term2, term3 = term3, term10 = term10, term100 = term100))
}

# Define parameter tval and kvals
tval <- 6
kvals <- seq(0.01, 0.69, by = 0.02)

# Compute estimation for all kvals
kestimated <- do.call(rbind, lapply(kvals, function(k) getestimation(k, tval)))

# Determine y-axis range
ymin <- min((kestimated$k - kestimated$term10) / kestimated$k)
ymax <- max((kestimated$k - kestimated$term1) / kestimated$k)

# Base R plot
plot(kestimated$k, (kestimated$k - kestimated$term1) / kestimated$k, type = "o", lty = 3, col = "red", pch = 16, xlab = "k", ylab = "k - Relative Error", main = paste("t =", tval), lwd = 0.7, ylim = c(ymin, ymax))
lines(kestimated$k, (kestimated$k - kestimated$term2) / kestimated$k, type = "o", lty = 3, col = "blue", pch = 16, lwd = 0.7)
lines(kestimated$k, (kestimated$k - kestimated$term3) / kestimated$k, type = "o", lty = 3, col = "green", pch = 16, lwd = 0.7)
lines(kestimated$k, (kestimated$k - kestimated$term10) / kestimated$k, type = "o", lty = 3, col = "purple", pch = 16, lwd = 0.7)
lines(kestimated$k, (kestimated$k - kestimated$term100) / kestimated$k, type = "o", lty = 3, col = "black", pch = 16, lwd = 0.7)

legend("topright", legend = c("n=1", "n=2", "n=3", "n=10", "n=100"), col = c("red", "blue", "green", "purple", "black"), lty = 3, pch = 16)