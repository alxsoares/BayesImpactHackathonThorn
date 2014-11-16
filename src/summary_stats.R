library(ggmap)
library(ggplot2)
library(lubridate)
library(plyr)
library(scales)
library(stringr)

plots_dir <- "/Users/benhamner/Git/BayesImpactHackathonThorn/Plots"
data <- read.csv("/Users/benhamner/Data/BayesImpact/HackathonEscort/Working/NoTextBackpageOnly.csv")
data$Date <- as.Date(data$Date)
data$Age <- as.integer(as.character(data$Age))
data$Price <- as.numeric(as.character(data$Price))
data$DayOfWeek <- weekdays(data$Date)
data$Hour <- hour(data$Date)

min_date <- as.Date("2013-01-01")
max_date <- as.Date("2014-08-01")

ggplot(data, aes(x=Date)) + geom_histogram(binwidth=30, colour="white", fill="#0b5394") +
  scale_x_date(labels = date_format("%Y-%b"),
               breaks = seq(min_date, max_date, 30)) +
  xlim(min_date, max_date) +
  ylab("Monthly Posts") + xlab("") +
  theme_bw(base_size=16)
ggsave(file.path(plots_dir, "AllCitiesTime.png"))


city_counts  <- ddply(data, .(City), function(d) nrow(d))

top_10_city_counts <- city_counts[with(city_counts, order(-V1))[1:10],]
top_10_cities <- top_10_city_counts$City

top_500_city_counts <- city_counts[with(city_counts, order(-V1))[1:500],]
top_500_cities <- top_500_city_counts$City
median_city_prices <- ddply(data[(data$City %in% top_500_cities) & !is.na(data$Price),], .(City), summarize, MedianPrice=median(Price, na.rm=TRUE), Count=length(Price))
median_city_prices <- median_city_prices[median_city_prices$Count>100,]
median_city_prices <- adply(median_city_prices, 1, transform, FormattedAddress=geocode(as.character(City), output="all")$results[[1]]$formatted_address)
write.csv(median_city_prices, "/Users/benhamner/Data/BayesImpact/HackathonEscort/Working/MedianCityPrices.csv")

data <- data[data$City %in% top_10_cities,]
data$City <- as.factor(as.character(data$City))

ggplot(data, aes(x=Date, fill=City)) + geom_histogram(binwidth=30, colour="white") +
  scale_x_date(labels = date_format("%Y-%b"),
               breaks = seq(min_date, max_date, 30)) +
  xlim(min_date, max_date) +
  ylab("Frequency") + xlab("Year and Month") +
  theme_bw()
ggsave(file.path(plots_dir, "TimeCity.png"))

ggplot(data, aes(x=Date, fill=Race)) + geom_histogram(binwidth=30, colour="white") +
  scale_x_date(labels = date_format("%Y-%b"),
               breaks = seq(min_date, max_date, 30)) +
  xlim(min_date, max_date) +
  ylab("Frequency") + xlab("Year and Month") +
  theme_bw()
ggsave(file.path(plots_dir, "TimeRace.png"))

age_city_counts <- ddply(data[data$Age>=18 & data$Age<=35 & !is.na(data$Age),], .(Age, City), summarize, Count=length(Age))
ggplot(age_city_counts, aes(x=Age, y=Count, colour=City)) + geom_line()
ggsave(file.path(plots_dir, "AgeCity.png"))

age_race_counts <- ddply(data[data$Age>=18 & data$Age<=35 & !is.na(data$Age) & !is.na(data$Race),], .(Age, Race), summarize, Count=length(Age))
ggplot(age_race_counts, aes(x=Age, y=Count, colour=Race)) + geom_line()
ggsave(file.path(plots_dir, "AgeRace.png"))

levels(data$City)[levels(data$City)=="District of Columbia"]="DC"
levels(data$City)[levels(data$City)=="Georgia"]="GA"
levels(data$City)[levels(data$City)=="North Carolina"]="NC"
levels(data$City)[levels(data$City)=="Washington"]="WA"
levels(data$City)[levels(data$City)=="New Jersey"]="NJ"
levels(data$City)[levels(data$City)=="New York"]="NY"
ggplot(data[!is.na(data$City) & data$Race!="",], aes(x=City, fill=Race)) +
  geom_bar(position="fill") + 
  theme_bw()
ggsave(file.path(plots_dir, "CityRace.png"))

# phone_counts <- ddply(data, .(Phone), summarize, Count=nrow(Phone))
# phone_counts <- phone_counts[with(phone_counts, order(-Count)),]

phones <- count(data$Phone[!is.na(data$Phone) & !is.na(data$Price)])
names(phones) <- c("Phone", "Count")
phones <- phones[with(phones, order(-Count)),]

popular <- data[data$Phone==phones$Phone[2] & !is.na(data$Phone),]
ggplot(popular, aes(x=Date, y=Price)) + geom_point()

prices <- data[!is.na(data$Price) & data$Price>0 & data$Price<300,]
ggplot(prices, aes(x=City, y=Price)) +
  geom_boxplot(fill="#0b5394") + 
  theme_bw(base_size=16)
ggsave(file.path(plots_dir, "CityPrice.png"))

ggplot(prices, aes(x=Race, y=Price)) +
  geom_boxplot(fill="#0b5394") + 
  theme_bw(base_size=16)
ggsave(file.path(plots_dir, "RacePrice.png"))

ggplot(data, aes(x=DayOfWeek)) + geom_bar()
ggsave(file.path(plots_dir, "DayOfWeek.png"))

cost_of_living <- read.csv("/Users/benhamner/Data/BayesImpact/HackathonEscort/Raw/CostOfLiving.csv")
cost_of_living$FormattedAddress <- paste0(as.character(cost_of_living$City), ", USA")
median_city_joined <- join(median_city_prices, cost_of_living, by="FormattedAddress")
