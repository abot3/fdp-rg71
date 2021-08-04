library(readr)
library(tidyverse)
library(stringr)
# used_truck_data = read_csv({{ CSV_FILE_PATH }})

# fix colors function
fix_colors = function(dataset) {
  colors = c('gray', 'black', 'white', 'green', 'blue', 'red', 'silver', 'yellow', 'brown')
  
  for (i in 1:length(colors)) {
    dataset[grep(colors[i], dataset, fixed = TRUE)] = colors[i]
  }
  
  dataset = ifelse(dataset %in% colors, dataset, 'other')
  toupper(dataset)
}

clean_dataset = function() {
  # fix empty and NA entries
  dataset$back_legroom = ifelse(is.na(dataset$back_legroom), 0, dataset$back_legroom)
  dataset$bed = ifelse(is.na(dataset$bed), 'Not Listed', dataset$bed)
  dataset$bed_length = ifelse(is.na(dataset$bed_length), 0, dataset$bed_length)
  dataset$cabin = ifelse(is.na(dataset$cabin), 'Not Listed', dataset$cabin)
  dataset$fleet = ifelse(is.na(dataset$fleet), FALSE, dataset$fleet)
  dataset$frame_damaged = ifelse(is.na(dataset$frame_damaged), FALSE, dataset$frame_damaged)
  dataset$front_legroom = ifelse(is.na(dataset$front_legroom), 0, dataset$front_legroom)
  dataset$fuel_tank_volume = ifelse(is.na(dataset$fuel_tank_volume), 0, dataset$fuel_tank_volume)
  dataset$isCab = ifelse(is.na(dataset$isCab), FALSE, dataset$isCab)
  dataset$has_accidents = ifelse(is.na(dataset$has_accidents), FALSE, dataset$has_accidents)
  dataset$height = ifelse(is.na(dataset$height), 0, dataset$height)
  dataset$highway_fuel_economy = ifelse(is.na(dataset$highway_fuel_economy), 0, dataset$highway_fuel_economy)
  dataset$horsepower = ifelse(is.na(dataset$horsepower), 0, dataset$horsepower)
  dataset$isCab = ifelse(is.na(dataset$isCab), FALSE, dataset$isCab)
  dataset$is_new = ifelse(is.na(dataset$is_new), FALSE, dataset$is_new)
  dataset$length = ifelse(is.na(dataset$length), 0, dataset$length)
  dataset$maximum_seating = ifelse(is.na(dataset$maximum_seating), 0, dataset$maximum_seating)
  dataset$mileage = ifelse(is.na(dataset$mileage), 0, dataset$mileage)
  dataset$owner_count = ifelse(is.na(dataset$owner_count), 0, dataset$owner_count)
  dataset$salvage = ifelse(is.na(dataset$salvage), FALSE, dataset$salvage)
  dataset$seller_rating = ifelse(is.na(dataset$seller_rating), 0, dataset$seller_rating)
  dataset$theft_title = ifelse(is.na(dataset$theft_title), FALSE, dataset$theft_title)
  dataset$transmission = ifelse(dataset$transmission == 'CVT' | dataset$transmission == 'Dual Clutch', 'A', dataset$transmission)
  dataset$wheelbase = ifelse(is.na(dataset$wheelbase), 0, dataset$wheelbase)
  dataset$width = ifelse(is.na(dataset$width), 0, dataset$width)
  
  # normalize colors
  dataset$exterior_color = tolower(dataset$exterior_color)
  dataset$exterior_color = fix_colors(dataset$exterior_color)
  dataset$interior_color = tolower(dataset$interior_color)
  dataset$interior_color = fix_colors(dataset$interior_color)
  dataset$listing_color = tolower(dataset$listing_color)
  dataset$listing_color = fix_colors(dataset$listing_color)
  
  # remove any remaining NA entries
  dataset = subset(dataset, !is.na(back_legroom))
  dataset = subset(dataset, back_legroom != '--')
  dataset = subset(dataset, !is.na(bed))
  dataset = subset(dataset, bed_length != '--')
  dataset = subset(dataset, !is.na(cabin))
  dataset = subset(dataset, !is.na(city_fuel_economy))
  dataset = subset(dataset, !is.na(engine_cylinders))
  dataset = subset(dataset, !is.na(engine_type))
  dataset = subset(dataset, !is.na(fuel_type))
  dataset = subset(dataset, !is.na(power))
  dataset = subset(dataset, !is.na(torque))
  dataset = subset(dataset, !is.na(transmission))
  
  # clean up character data (optimized)
  reg_num = "[:digit:]+.?[:digit:]?"
  reg_rpm = "[:digit:],[:digit:]+"
  
  dataset$back_legroom = str_extract(dataset$back_legroom, reg_num)
  dataset$bed_length = str_extract(dataset$bed_length, reg_num)
  dataset$front_legroom = str_extract(dataset$front_legroom, reg_num)
  dataset$fuel_tank_volume = str_extract(dataset$fuel_tank_volume, reg_num)
  dataset$engine_cylinders = str_extract(dataset$engine_cylinders, reg_num)
  dataset$engine_type = str_extract(dataset$engine_type, reg_num)
  dataset$height = str_extract(dataset$height, reg_num)
  dataset$length = str_extract(dataset$length, reg_num)
  dataset$maximum_seating = str_extract(dataset$maximum_seating, reg_num)
  dataset$wheelbase = str_extract(dataset$wheelbase, reg_num)
  dataset$width = str_extract(dataset$width, reg_num)
  dataset$power_hp = str_extract(dataset$power, reg_num)
  dataset$power_rpm = str_extract(dataset$power, reg_rpm)
  dataset$torque_lb_ft = str_extract(dataset$torque, reg_num)
  dataset$torque_rpm = str_extract(dataset$torque, reg_rpm)

  # remove unnecessary variables
    dataset = subset(dataset,
                            select = -c(vin,
                                        bed_height,
                                        body_type,
                                        combine_fuel_economy,
                                        description,
                                        franchise_make,
                                        is_certified,
                                        is_cpo,
                                        is_oemcpo,
                                        listing_id,
                                        main_picture_url,
                                        major_options,
                                        vehicle_damage_category,
                                        power,
                                        torque,
                                        sp_id,
                                        sp_name,
                                        trimId,
                                        trim_name))

  dataset = set_data_structure(dataset)
  dataset
}

set_data_structure = function(dataset) {
  # update variable structure
  dataset$back_legroom = as.numeric(dataset$back_legroom)
  dataset$bed = as.factor(dataset$bed)
  dataset$bed_length = as.numeric(dataset$bed_length)
  dataset$cabin = as.factor(dataset$cabin)
  dataset$city = as.factor(dataset$city)
  dataset$dealer_zip = as.factor(dataset$dealer_zip)
  dataset$engine_cylinders = as.factor(as.numeric(dataset$engine_cylinders))
  dataset$engine_type = as.factor(as.numeric(dataset$engine_type))
  dataset$exterior_color = as.factor(dataset$exterior_color)
  dataset$front_legroom = as.numeric(dataset$front_legroom)
  dataset$fuel_tank_volume = as.numeric(dataset$fuel_tank_volume)
  dataset$fuel_type = as.factor(dataset$fuel_type)
  dataset$height = as.numeric(dataset$height)
  dataset$interior_color = as.factor(dataset$interior_color)
  dataset$length = as.numeric(dataset$length)
  dataset$listing_color = as.factor(dataset$listing_color)
  dataset$make_name = as.factor(dataset$make_name)
  dataset$maximum_seating = as.factor(dataset$maximum_seating)
  dataset$region = as.factor(dataset$region)
  dataset$state = as.factor(dataset$state)
  dataset$transmission = as.factor(dataset$transmission)
  dataset$wheel_system = as.factor(dataset$wheel_system)
  dataset$wheelbase = as.numeric(dataset$wheelbase)
  dataset$width = as.numeric(dataset$width)
  dataset$power_hp = as.numeric(dataset$power_hp)
  # dataset$power_rpm = as.factor(dataset$power_rpm)
  dataset$power_rpm = as.numeric(dataset$power_rpm)
  dataset$torque_lb_ft = as.numeric(dataset$torque_lb_ft)
  # dataset$torque_rpm = as.factor(dataset$torque_rpm)
  dataset$torque_rpm = as.numeric(dataset$torque_rpm)
  # dataset$year = as.factor(dataset$year)
  dataset$year = as.numeric(dataset$year)
  dataset
}

# clean up data
#used_truck_data = clean_dataset({{ IMPORTED_CSV_FILE  }})

# verify data set
#nrow(used_truck_data)
#str(used_truck_data)
#View(used_truck_data)
