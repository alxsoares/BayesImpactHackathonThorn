library(ggmap)
library(plyr)

cities <- read.csv("/Users/benhamner/Data/BayesImpact/HackathonEscort/Working/Cities.csv")
cities <- cities[with(cities, order(-Count))[1:40],]
cities <- ddply(cities, "City", function(d) { g <- geocode(as.character(d$City[1])); d$Lat <- c(g$lat); d$Lon <- c(g$lon); return(d)})

qmap("US", zoom=4, source = "stamen", maptype = "watercolor")+
  geom_point(aes(x=Lon, y=Lat, size=Count, colour=Count), data=cities)