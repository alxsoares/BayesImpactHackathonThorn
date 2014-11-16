library(ggplot2)
library(plyr)
library(scales)

plots_dir <- "/Users/benhamner/Git/BayesImpactHackathonThorn/Plots"
data <- read.csv("/Users/benhamner/Data/BayesImpact/HackathonEscort/Working/NoTextBackpageOnly.csv")
data$Date <- as.Date(data$Date)
data$Age <- as.integer(as.character(data$Age))

city_counts  <- ddply(data, .(City), function(d) nrow(d))

top_10_city_counts <- city_counts[with(city_counts, order(-V1))[1:10],]
top_10_cities <- top_10_city_counts$City

data <- data[data$City %in% top_10_cities,]

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

age_counts <- ddply(data[data$Age>=18 & data$Age<=35 & !is.na(data$Age),], .(Age, City), summarize, Count=length(Age))

ggplot(age_counts, aes(x=Age, y=Count, colour=City)) + geom_line()
ggsave(file.path(plots_dir, "AgeCity.png"))

phone_counts <- ddply(data, .Phone)