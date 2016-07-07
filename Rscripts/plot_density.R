
### Clear the workspace
rm(list=ls())

library(ggmap)#Load libraries
library(ggplot2)
library(dplyr)

### Read in the position data, this data requires considerable cleaning to be useful.
position.data <- read.csv("Data/Sample_locations.csv", header = TRUE, stringsAsFactors = FALSE)
position.data.subs<-filter(position.data, Dec.Longitude != "unknown" & Island == "La_Reunion")
positions <- data.frame(lon=as.numeric(position.data.subs$Dec.Longitude),
                        lat=as.numeric(position.data.subs$Dec.Latitude))

map <- get_map(location=c(lon=55.533340,
                          lat=-21.123586), zoom=10, maptype='roadmap', color='color', scale=2)#Get the map from Google Maps
ggmap(map, extent = "device") +
  geom_density2d(data = positions, aes(x = lon, y = lat), size = 0.3) +
  stat_density2d(data = positions,
                 aes(x = lon, y = lat, fill = ..level.., alpha = ..level..), size = 0.01,
                 bins = 25, geom = "polygon") + scale_fill_gradient(low = "green", high = "red") +
  scale_alpha(range = c(0.1, 0.3), guide = FALSE) +
  geom_point(data = positions, aes(x = lon, y = lat))
