# set placeholder value for region variable in data frame
used_truck_data$region = "Other"

# set Region 1 on latitude / longitude conditions
used_truck_data$region[used_truck_data$latitude < 37.78076828622018 & used_truck_data$latitude > 37.25035741610745 
                 & used_truck_data$longitude < -121.85307726189703 & used_truck_data$longitude > -122.50488144107447] = "Region 1"

# set Region 2 on latitude / longitude conditions
used_truck_data$region[used_truck_data$latitude < 47.78502706081486 & used_truck_data$latitude > 47.12327044705014 
                 & used_truck_data$longitude < -122.04186361166227 & used_truck_data$longitude > -122.61906067660752] = "Region 2"

# set Region 3 on latitude / longitude conditions
used_truck_data$region[used_truck_data$latitude < 32.988394538505275 & used_truck_data$latitude > 32.66950915381749 
                 & used_truck_data$longitude < -96.55528632692199 & used_truck_data$longitude > -97.48732384279774] = "Region 3"

# set Region 4 on latitude / longitude conditions
used_truck_data$region[used_truck_data$latitude < 30.460499890421573 & used_truck_data$latitude > 29.274940284447997 
                 & used_truck_data$longitude < -97.62876583084027 & used_truck_data$longitude > -98.6657153056594] = "Region 4"

# set Region 5 on latitude / longitude conditions
used_truck_data$region[used_truck_data$latitude < 34.14494984518532 & used_truck_data$latitude > 33.68433856779674 
                 & used_truck_data$longitude < -84.19816278737434 & used_truck_data$longitude > -84.7634847112431] = "Region 5"

# set Region 6 on latitude / longitude conditions
used_truck_data$region[used_truck_data$latitude < 28.737108891837234 & used_truck_data$latitude > 27.82339991184241
                 & used_truck_data$longitude < -81.22261726061794 & used_truck_data$longitude > -82.66780079513585] = "Region 6"

# set Region 7 on latitude / longitude conditions
used_truck_data$region[used_truck_data$latitude < 41.010668887052006 & used_truck_data$latitude > 39.34837978601289 
                 & used_truck_data$longitude < -73.6914252253522 & used_truck_data$longitude > -75.35002087520648] = "Region 7"

# set Region 8 on latitude / longitude conditions
used_truck_data$region[used_truck_data$latitude < 42.58129590905933 & used_truck_data$latitude > 42.22364218404111
                 & used_truck_data$longitude < -70.8183880968727 & used_truck_data$longitude > -71.34541809524895] = "Region 8"

# set Region 9 on latitude / longitude conditions
used_truck_data$region[used_truck_data$latitude < 43.30313864345386 & used_truck_data$latitude > 41.5380434345939 
                 & used_truck_data$longitude < -87.20791391134868 & used_truck_data$longitude > -88.34338447422027] = "Region 9"

# set region variable as factor with 9 levels
used_truck_data$region = as.factor(used_truck_data$region)