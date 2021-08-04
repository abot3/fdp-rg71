# utility functions

# plot fitted vs residuals
plot_fitted_resid = function(model, pointcol = "dodgerblue", linecol = "darkorange") {
  plot(fitted(model), resid(model),
       col = pointcol, pch = 20, cex = 1.5,
       xlab = "Fitted", ylab = "Residuals")
  abline(h = 0, col = linecol, lwd = 2)
}

# Q-Q plot
plot_qq = function(model, pointcol = "dodgerblue", linecol = "darkorange") {
  qqnorm(resid(model), col = pointcol, pch = 20, cex = 1.5)
  qqline(resid(model), col = linecol, lwd = 2)
}

# calculate RMSE
cal_rmse = function(model){
  sqrt(mean(resid(model) ^ 2))
}

# calculate leave one out cross validation
calc_loocv_rmse = function(model) {
  sqrt(mean((resid(model) / (1 - hatvalues(model))) ^ 2))
}

# Delete large object obj, call the garbage collector to trigger garbage
# collector to clean up deleted obj.
free_memory = function(obj = data.frame()) {
  rm(obj)
  gc()
}

# Select a % of random rows in the data frame. Rows are chosen using a uniform
# distribution.
random_rows_from_df = function(df = data.frame(), pct = 0.10) {
  rowidx = as.integer(runif(round(nrow(df) * 0.10), min = 0, max = nrow(df)))
  df[rowidx, ]
}