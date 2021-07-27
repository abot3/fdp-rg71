

# Delete large object obj, call the garbage collector to trigger garbage
# collector to clean up deleted obj.
free_memory = function(obj = data.frame()) {
  rm(obj)
  gc()
}

random_rows_from_df = function(df = data.frame(), pct = 0.10) {
  rowidx = as.integer(runif(round(nrow(df) * 0.10), min = 0, max = nrow(df)))
  df[rowidx, ]
}

do_fitted_vs_residual = function(model = NULL, main = "Fitted vs. Residuals",
                                 remove_outliers = FALSE) {
  std = sd(resid(model))
  if (remove_outliers) {
    keep = resid(model) > -900000 & resid(model) < 900000
  } else {
    keep = rep(TRUE, length(resid(model)))
  }
  plot(fitted(model)[keep],
       resid(model)[keep], col = "dodgerblue", pch = 20,
       xlab = "Fitted", ylab = "Residuals", main = main)
  abline(h = 0, col = "darkorange", lwd = 2)
  keep
}