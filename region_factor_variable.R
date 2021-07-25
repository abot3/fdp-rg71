cars_data$region = "Other"

cars_data$region[cars_data$latitude < 37.78076828622018 & cars_data$latitude > 37.25035741610745 
                                  & cars_data$longitude < -121.85307726189703 & cars_data$longitude > -122.50488144107447] = "Region 1"

cars_data$region[cars_data$latitude < 47.78502706081486 & cars_data$latitude > 47.12327044705014 
                                  & cars_data$longitude < -122.04186361166227 & cars_data$longitude > -122.61906067660752] = "Region 2"

cars_data$region[cars_data$latitude < 32.988394538505275 & cars_data$latitude > 32.66950915381749 
                                  & cars_data$longitude < -96.55528632692199 & cars_data$longitude > -97.48732384279774] = "Region 3"

cars_data$region[cars_data$latitude < 30.460499890421573 & cars_data$latitude > 29.274940284447997 
                                  & cars_data$longitude < -97.62876583084027 & cars_data$longitude > -98.6657153056594] = "Region 4"

cars_data$region[cars_data$latitude < 34.14494984518532 & cars_data$latitude > 33.68433856779674 
                                  & cars_data$longitude < -84.19816278737434 & cars_data$longitude > -84.7634847112431] = "Region 5"

cars_data$region[cars_data$latitude < 28.737108891837234 & cars_data$latitude > 27.82339991184241
                                  & cars_data$longitude < -81.22261726061794 & cars_data$longitude > -82.66780079513585] = "Region 6"

cars_data$region[cars_data$latitude < 41.010668887052006 & cars_data$latitude > 39.34837978601289 
                                  & cars_data$longitude < -73.6914252253522 & cars_data$longitude > -75.35002087520648] = "Region 7"

cars_data$region[cars_data$latitude < 42.58129590905933 & cars_data$latitude > 42.22364218404111
                                  & cars_data$longitude < -70.8183880968727 & cars_data$longitude > -71.34541809524895] = "Region 8"

cars_data$region[cars_data$latitude < 43.30313864345386 & cars_data$latitude > 41.5380434345939 
                                  & cars_data$longitude < -87.20791391134868 & cars_data$longitude > -88.34338447422027] = "Region 9"

cars_data$region = as.factor(cars_data$region)
