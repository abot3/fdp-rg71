### region analysis steps and model fitting

region_data = used_truck_data[used_truck_data$region == "{{ REGION }}",] # select data for region

# fit naive base model (using predetermined predictors)
base_region_model = lm(price ~ engine_displacement + engine_cylinders + highway_fuel_economy + horsepower+ maximum_seating + transmission + mileage + year + wheel_system + power_hp + bed_length + cabin + salvage + franchise_dealer, data = region_data)
summary(base_region_model) # view naive model summary
calc_loocv_rmse(base_region_model) # calculate leave one out cross validation
cal_rmse(base_region_model) # calculate RMSE
# select naive base model variables
base_data = base_region_model[c("engine_displacement", "engine_cylinders", "highway_fuel_economy", "horsepower", "maximum_seating", "transmission", "mileage", "year", "wheel_system", "power_hp", "bed_length", "cabin", "salvage", "franchise_dealer")]
pairs(base_region_model) # view scatterplot matrix


### explore naive base model with state variable, (state is significant)
drops = c("region") # set field to drop
base_region_model = base_region_model[ , !(names(base_region_model) %in% drops)] # remove drop field(s)
# fit model
base_region_model_state = lm(price ~ engine_displacement + engine_cylinders + highway_fuel_economy + horsepower+ maximum_seating + transmission + mileage + year + wheel_system + power_hp + bed_length + cabin + salvage + franchise_dealer + state, data = region_data)
summary(base_region_model_state) # view naive model summary
calc_loocv_rmse(base_region_model_state) # calculate leave one out cross validation
cal_rmse(base_region_model_state) # calculate RMSE
anova(base_region_model, base_region_model_state) # compare two models for significance


full_region_model = lm(price ~ ., data = region_data) # fit full naive model (using all possible predictors)
calc_loocv_rmse(full_region_model) # calculate leave one out cross validation
cal_rmse(full_region_model) # calculate RMSE


### apply forward BIC search for improved model
n = length(resid(full_region_model)) # set number of observations
full_model_bic_forward = step(base_region_model_state, scope = price ~., direction = "forward", k = log(n)) # select model via forward BIC
summary(full_model_bic_forward) # view selected model summary
calc_loocv_rmse(full_model_bic_forward) # calculate leave one out cross validation
cal_rmse(full_model_bic_forward) # calculate RMSE


### apply backward BIC search for improved model
n = length(resid(full_region_model)) # set number of observations
region_model_bic = step(full_region_model, direction = "backward", k = log(n),trace = 0) # select model via backward BIC
summary(region_model_bic) # view selected model summary
calc_loocv_rmse(region_model_bic) # calculate leave one out cross validation
cal_rmse(region_model_bic) # calculate RMSE
car::vif(region_model_bic) # view variance inflation factors


### fit improved region model
improved_region_model = lm(formula = price ~ back_legroom  + 
                              engine_cylinders + franchise_dealer + front_legroom + fuel_tank_volume + 
                              fuel_type + height + horsepower + isCab + 
                              is_new  + make_name + maximum_seating + mileage + 
                              seller_rating  + wheel_system + wheelbase + 
                              width + year + power_rpm + torque_lb_ft + torque_rpm + state, data = region_data) # fit model
summary(improved_region_model) # view improved model summary
calc_loocv_rmse(improved_region_model) # calculate leave one out cross validation
cal_rmse(improved_region_model) # calculate RMSE
