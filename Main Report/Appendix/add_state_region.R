# extract US data from 'usa' library and merge with used truck dataset
library(usa)
zcs = usa::zipcodes
zcs = zcs[c("zip", "state")]
used_truck_data = merge(used_truck_data, zcs, by.x = "dealer_zip", by.y = "zip")

# define regions
pacific = c("WA", "OR", "CA", "AK", "HI")  
mountain = c("MT", "ID", "WY", "NV", "UT", "CO", "AZ", "NM")
west_north_central = c("ND", "MN", "SD", "NE", "IA", "KS", "MO")
west_south_central = c("OK", "AR", "TX", "LA")
east_north_central = c("WI", "MI", "IL", "IN", "OH")
east_south_central = c("KY", "TN", "MS", "AL") 
new_england = c("ME", "VT", "NH", "MA","RI","CT")
mid_atlantic = c("NY", "PA", "NJ")
south_atlantic = c("MD","DE", "WV", "VA", "NC", "SC", "GA", "FL", "DC") 

## add regions to dataset
used_truck_data$region = "Other"
used_truck_data[used_truck_data$state %in% pacific,]$region = "Pacific"
used_truck_data[used_truck_data$state %in% mountain,]$region = "Moutain"
used_truck_data[used_truck_data$state %in% west_north_central,]$region = "West North Central"
used_truck_data[used_truck_data$state %in% west_south_central,]$region = "West South Central"
used_truck_data[used_truck_data$state %in% east_north_central,]$region = "East North Central"
used_truck_data[used_truck_data$state %in% east_south_central,]$region = "East South Central"
used_truck_data[used_truck_data$state %in% new_england,]$region = "New England"
used_truck_data[used_truck_data$state %in% mid_atlantic,]$region = "Mid Atlantic"
used_truck_data[used_truck_data$state %in% south_atlantic,]$region = "South Atlantic"
table(used_truck_data$power_rpm)
str(used_truck_data)

# remove unnecessary columns
drops = c("dealer_zip", "city", "listed_date", "model_name", "listed_color")
used_truck_data = used_truck_data[ , !(names(used_truck_data) %in% drops)]

# convert data structure
used_truck_data$power_rpm = as.numeric(gsub(",","",used_truck_data$power_rpm))
used_truck_data$torque_rpm = as.numeric(gsub(",","",used_truck_data$torque_rpm))
library(dplyr)
used_truck_data = used_truck_data %>% mutate_if(is.character,as.factor)
str(used_truck_data)

