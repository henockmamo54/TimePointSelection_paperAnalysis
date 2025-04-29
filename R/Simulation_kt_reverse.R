library(plotly)

# Compute the data (same as before)
getestimation <- function(kt) {
  logval_computed <- -log(1 - kt)
  
  x = kt
  term1 <- x
  term2 <- sum(sapply(1:2, function(i) (x^i) / i))
  term3 <- sum(sapply(1:3, function(i) (x^i) / i))
  term10 <- sum(sapply(1:10, function(i) (x^i) / i))
  term100 <- sum(sapply(1:100, function(i) (x^i) / i))
  
  return(data.frame(
    log_val = logval_computed,
    kt = kt,
    term1 = term1,
    term2 = term2,
    term3 = term3,
    term10 = term10,
    term100 = term100
  ))
}

ktvals <- seq(0.01, 0.69, by = 0.01)
kestimated <- do.call(rbind, lapply(ktvals, getestimation))

# Prepare data
df_plot <- data.frame(
  kt = kestimated$kt,
  n1 = (kestimated$log_val - kestimated$term1) / kestimated$kt,
  n2 = (kestimated$log_val - kestimated$term2) / kestimated$term2,
  n3 = (kestimated$log_val - kestimated$term3) / kestimated$term3
)

# Plotly plot with grid removed
plot_ly(df_plot, x = ~kt) %>%
  add_trace(y = ~n1, name = "n=1", type = 'scatter', mode = 'lines+markers',
            line = list(color = 'purple', dash = 'dot', width = 1),
            marker = list(size = 4, color = 'purple')) %>%
  add_trace(y = ~n2, name = "n=2", type = 'scatter', mode = 'lines+markers',
            line = list(color = 'blue', dash = 'dot', width = 1),
            marker = list(size = 4, color = 'blue')) %>%
  add_trace(y = ~n3, name = "n=3", type = 'scatter', mode = 'lines+markers',
            line = list(color = 'green', dash = 'dot', width = 1),
            marker = list(size = 4, color = 'green')) %>%
  layout(
    xaxis = list(title = "kt", showgrid = FALSE),
    yaxis = list(title = "Relative Error", showgrid = FALSE),
    legend = list(x = 0.7, y = 1),
    plot_bgcolor = 'white',
    paper_bgcolor = 'white',
    font = list(size = 14)
  )
