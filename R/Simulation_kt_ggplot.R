getestimation <- function(kt) {
  
  x <- 1 - exp(-kt)
  term1 <- x
  term2 <- sum(sapply(1:2, function(i)
    (x^i) / i))
  term3 <- sum(sapply(1:3, function(i)
    (x^i) / i))
  term10 <- sum(sapply(1:10, function(i)
    (x^i) / i))
  term100 <- sum(sapply(1:100, function(i)
    (x^i) / i))
  return(
    data.frame( 
      kt = kt,
      term1 = term1,
      term2 = term2,
      term3 = term3,
      term10 = term10,
      term100 = term100
    )
  )
}

# Define parameter ktvals

ktvals <- seq(0.01, 0.5, by = 0.01)

# Compute estimation for all kvals
kestimated <- do.call(rbind, lapply(ktvals, function(k)
  getestimation(k)))

# Determine y-axis range
ymin <- min((kestimated$kt - kestimated$term10) / kestimated$kt)
ymax <- max((kestimated$kt - kestimated$term1) / kestimated$kt)

#=========================ggplot============
library(ggplot2)
library(tidyr)
library(dplyr)

# Reshape data to long format
kest_long <- kestimated %>%
  select(kt, term1, term2, term3) %>%
  pivot_longer(cols = starts_with("term"),
               names_to = "term",
               values_to = "value") %>%
  mutate(
    rel_error = (kt - value) / kt,
    term = factor(term, levels = c("term1", "term2", "term3"),
                  labels = c("n=1", "n=2", "n=3"))
  )

# Plot with visible axes
ggplot(kest_long, aes(x = kt, y = rel_error, color = term)) +
  geom_line(linetype = "dotted") +
  geom_point(size = 2) +
  scale_color_manual(values = c("red", "blue", "green")) +
  labs(
    x = "kt",
    y = "kt - Relative Error",
    color = "Approximation"
  ) +
  ylim(ymin, 0.5) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid = element_blank(),           # Remove grid lines
    axis.line = element_line(color = "black"),  # Add x and y axis lines
    legend.position = c(0.95, 0.95),        # Legend in top-right
    legend.justification = c("right", "top"),
    legend.background = element_blank(),    # Remove legend background
    legend.key = element_blank(),           # Remove key box
    legend.title = element_text(size = 14),
    legend.text = element_text(size = 12),
    axis.title = element_text(size = 16),
    axis.text = element_text(size = 12)
  )

#==================================================
# # Base R plot
# plot(
#   kestimated$k,
#   (kestimated$kt - kestimated$term1) / kestimated$kt,
#   type = "o",
#   lty = 3,
#   col = "red",
#   pch = 16,
#   xlab = "kt",
#   ylab = "kt - Relative Error",
#   # main = paste("t =", tval),
#   lwd = 0.7,
#   ylim = c(ymin, 0.8)
#   # ylim = c(ymin, ymax)
# )
# lines(
#   kestimated$kt,
#   (kestimated$kt - kestimated$term2) / kestimated$kt,
#   type = "o",
#   lty = 3,
#   col = "blue",
#   pch = 16,
#   lwd = 0.7
# )
# lines(
#   kestimated$kt,
#   (kestimated$kt - kestimated$term3) / kestimated$kt,
#   type = "o",
#   lty = 3,
#   col = "green",
#   pch = 16,
#   lwd = 0.7
# )
# # lines(
# #   kestimated$k,
# #   (kestimated$kt - kestimated$term10) / kestimated$kt,
# #   type = "o",
# #   lty = 3,
# #   col = "purple",
# #   pch = 16,
# #   lwd = 0.7
# # )
# # lines(
# #   kestimated$k,
# #   (kestimated$kt - kestimated$term100) / kestimated$kt,
# #   type = "o",
# #   lty = 3,
# #   col = "black",
# #   pch = 16,
# #   lwd = 0.7
# # )
# 
# # legend(
# #   "topright",
# #   legend = c("n=1", "n=2", "n=3", "n=10", "n=100"),
# #   col = c("red", "blue", "green", "purple", "black"),
# #   lty = 3,
# #   pch = 16
# # )
# 
# legend(
#   "topright",
#   legend = c("n=1", "n=2", "n=3"),
#   col = c("red", "blue", "green"),
#   lty = 3,
#   pch = 16
# )
