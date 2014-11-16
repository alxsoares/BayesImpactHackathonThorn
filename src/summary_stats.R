library(ggplot2)
library(lubridate)
library(plyr)
library(scales)

plots_dir <- "/Users/benhamner/Git/BayesImpactHackathonThorn/Plots"
data <- read.csv("/Users/benhamner/Data/BayesImpact/HackathonEscort/Working/NoTextBackpageOnly.csv")
data$Date <- as.Date(data$Date)
data$Age <- as.integer(as.character(data$Age))
data$Price <- as.numeric(as.character(data$Price))
data$DayOfWeek <- weekdays(data$Date)
data$Hour <- hour(data$Date)

city_counts  <- ddply(data, .(City), function(d) nrow(d))

top_10_city_counts <- city_counts[with(city_counts, order(-V1))[1:10],]
top_10_cities <- top_10_city_counts$City

data <- data[data$City %in% top_10_cities,]
data$City <- as.factor(as.character(data$City))

min_date <- as.Date("2012-08-01")
max_date <- as.Date("2014-08-01")

ggplot(data, aes(x=Date)) + geom_histogram(binwidth=30, colour="white") +
  scale_x_date(labels = date_format("%Y-%b"),
               breaks = seq(min_date, max_date, 30)) +
  xlim(min_date, max_date) +
  ylab("Frequency") + xlab("Year and Month") +
  theme_bw()
ggsave(file.path(plots_dir, "Time.png"))

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

prices <- data[!is.na(data$Price) & data$Price>0 & data$Price<1000,]
ggplot(prices, aes(x=City, y=Price)) +
  geom_boxplot()
ggsave(file.path(plots_dir, "CityPrice.png"))

ggplot(prices, aes(x=Race, y=Price)) +
  geom_boxplot()
ggsave(file.path(plots_dir, "RacePrice.png"))

ggplot(data, aes(x=DayOfWeek)) + geom_bar()
ggsave(file.path(plots_dir, "DayOfWeek.png"))
