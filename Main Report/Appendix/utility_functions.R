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