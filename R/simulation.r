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
kval <- 0.3
tvals <- 1:10

# Compute estimation only for kval
kestimated <- do.call(rbind, lapply(tvals, function(t) getestimation(kval, t)))

# Plot
library(ggplot2)
ggplot(kestimated, aes(x = t)) +
  geom_smooth(aes(y = (k - term1) / k, color = "n=1"), linewidth = 0.7, linetype = "dotted", se = FALSE) +
  geom_point(aes(y = (k - term1) / k, color = "n=1"), size = 3) +
  geom_smooth(aes(y = (k - term2) / k, color = "n=2"), linewidth = 0.7, linetype = "dotted", se = FALSE) +
  geom_point(aes(y = (k - term2) / k, color = "n=2"), size = 3) +
  geom_smooth(aes(y = (k - term3) / k, color = "n=3"), linewidth = 0.7, linetype = "dotted", se = FALSE) +
  geom_point(aes(y = (k - term3) / k, color = "n=3"), size = 3) +
  geom_smooth(aes(y = (k - term10) / k, color = "n=10"), linewidth = 0.7, linetype = "dotted", se = FALSE) +
  geom_point(aes(y = (k - term10) / k, color = "n=10"), size = 3) +
  ggtitle(paste("k =", kval)) +
  labs(y = "Relative Error", x = "t", color = "Series Terms") +
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), 
    axis.line = element_line(color = "black")
  ) +
  scale_x_continuous(breaks = tvals)
