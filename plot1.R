## Introduction
# This file uses data from UC Irvine Machine Learning Repository in particular it uses
# "Individual household electric power consumption Data Set".
# Overall goal here is analyze how household energy usage varies over a 2-day period in February, 2007.


# First download the dataset from the given download url to our working directory.
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


# plot histogram of Global Active Power
hist(subdata$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")


# re-running the same above code for automatically creating png file of the plot
png(file = "plot1.png")
hist(subdata$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.off()


