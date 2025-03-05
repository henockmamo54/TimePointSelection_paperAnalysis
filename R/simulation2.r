getestimation <- function(k, t) {
  kt <- k * t
  x <- 1 - exp(-kt)
  term1 <- x / t
  term2 <- sum(sapply(1:2, function(i) (x^i) / i)) / t
  term3 <- sum(sapply(1:3, function(i) (x^i) / i)) / t
  term10 <- sum(sapply(1:10, function(i) (x^i) / i)) / t
  return(data.frame(k = k, t = t, term1 = term1, term2 = term2, term3 = term3, term10 = term10))
}

# Define parameter kval
tvals <- 1:10
kval <- 0.3

# Compute estimation only for kval
kestimated <- do.call(rbind, lapply(tvals, function(t) getestimation(kval, t)))

# Determine y-axis range
ymin <- min((kestimated$k - kestimated$term10) / kestimated$k)
ymax <- max((kestimated$k - kestimated$term1) / kestimated$k)

# Base R plot
plot(kestimated$t, (kestimated$k - kestimated$term1) / kestimated$k, type = "o", lty = 3, col = "red", pch = 16, xlab = "t", ylab = "Relative Error", main = paste("k =", kval), lwd = 0.7, xaxt = "n", ylim = c(ymin, ymax))
axis(1, at = tvals, labels = tvals)
lines(kestimated$t, (kestimated$k - kestimated$term2) / kestimated$k, type = "o", lty = 3, col = "blue", pch = 16, lwd = 0.7)
lines(kestimated$t, (kestimated$k - kestimated$term3) / kestimated$k, type = "o", lty = 3, col = "green", pch = 16, lwd = 0.7)
lines(kestimated$t, (kestimated$k - kestimated$term10) / kestimated$k, type = "o", lty = 3, col = "purple", pch = 16, lwd = 0.7)

legend("topright", legend = c("n=1", "n=2", "n=3", "n=10"), col = c("red", "blue", "green", "purple"), lty = 3, pch = 16)
