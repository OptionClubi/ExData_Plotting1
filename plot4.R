## Introduction
# This file uses data from UC Irvine Machine Learning Repository in particular it uses
# "Individual household electric power consumption Data Set".
# Overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007.


# First download the dataset from UC Irvine ML Repo url.
# The dataset is quite big, it may take some time to download the entire dataset.

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# downloading the dataset, if not already downloaded
if ( !file.exists("exdata_data_household_power_consumption.zip") ) {
	download.file(url, "exdata_data_household_power_consumption.zip")
}

# uncompress the downloaded dataset
if ( !file.exists("household_power_consumption.txt") ) {
	unzip("exdata_data_household_power_consumption.zip")
}

# read few rows to get classes
fewrows <- read.table("household_power_consumption.txt", header = T, sep = ";", nrows = 5)
classes <- sapply(fewrows, class)


# read entire data with know classes
# reading may few mins
data <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?", colClasses = classes)
data$Date <- as.Date(data$Date, "%d/%m/%Y")


# obtain the subset of entire dataset for specific dates
fromdate <- as.Date("2007-02-01")
todate <- as.Date("2007-02-02")
subdata <- subset(data, Date >= fromdate & Date <= todate)
dateTime <- strptime(paste(subdata$Date, subdata$Time), format = "%Y-%m-%d %H:%M:%S")


# create the plots to study how household energy usage varies
par(mfrow = c(2,2))
plot(dateTime, subdata$Global_active_power, type = 'l', ylab = "Global Active Power", xlab = "")
plot(dateTime, subdata$Voltage, type = 'l', ylab = "Voltage", xlab = "datetime")
{plot (dateTime,subdata$Sub_metering_1,type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
lines (dateTime,subdata$Sub_metering_2,type = "l", col = "red")
points (dateTime,subdata$Sub_metering_3,type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
}
plot(dateTime, subdata$Global_reactive_power, ylab = "Global_reactive_power", type = 'l', xlab = "datetime")


# re-running the same above code for automatically creating png file of the plot
png(file = "plot4.png")
par(mfrow = c(2,2))
plot(dateTime, subdata$Global_active_power, type = 'l', ylab = "Global Active Power", xlab = "")
plot(dateTime, subdata$Voltage, type = 'l', ylab = "Voltage", xlab = "datetime")
{plot (dateTime,subdata$Sub_metering_1,type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
lines (dateTime,subdata$Sub_metering_2,type = "l", col = "red")
points (dateTime,subdata$Sub_metering_3,type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
}
plot(dateTime, subdata$Global_reactive_power, ylab = "Global_reactive_power", type = 'l', xlab = "datetime")
dev.off()





