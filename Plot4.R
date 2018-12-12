## Load required packages
library(data.table)
library(lubridate)
library(ggplot2)

## Set working Directory and load the data
setwd("D:/SVN - BIDs/branches/sandpit/flintan/Data Science Coursera/Course Project 1 - DataViz")
EPC_data <- read.table("household_power_consumption.txt",
                          header = TRUE,
                          sep = ";",
                          colClasses = c("character", "character", rep("numeric", 7)),
                          na.strings = "?")
# Subset data to use observations from 2007-02-01 and 2007-02-02
EPC_data$Date = as.Date(EPC_data$Date, format = "%d/%m/%Y")
EPC_data_subset <- EPC_data[EPC_data$Date >= "2007-02-01" & EPC_data$Date <= "2007-02-02",]
EPC_data_subset$Date.Time <- ymd_hms(paste0(EPC_data_subset$Date, " ", EPC_data_subset$Time))
EPC_data_subset$Day <- wday(EPC_data_subset$Date.Time)
EPC_data_subset$Global_active_power <- as.numeric(as.character(EPC_data_subset$Global_active_power))
rm(EPC_data)


# Plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))

#1 
plot(EPC_data_subset$Date.Time, EPC_data_subset$Global_active_power,
     type = "line",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

#2
plot(EPC_data_subset$Date.Time, EPC_data_subset$Sub_metering_1,
     "n",
     xlab = "",
     ylab = "Energy Sub Metering")
lines(EPC_data_subset$Date.Time, EPC_data_subset$Sub_metering_1, col = "black")
lines(EPC_data_subset$Date.Time, EPC_data_subset$Sub_metering_2, col = "red")
lines(EPC_data_subset$Date.Time, EPC_data_subset$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            col = c("black", "red", "blue"), lty = c(1, 1, 1))

#3
plot(EPC_data_subset$Date.Time, EPC_data_subset$Voltage,
     type = "line",
     xlab = "",
     ylab = "Voltage")

#4
plot(EPC_data_subset$Date.Time, EPC_data_subset$Global_reactive_power,
     type = "line",
     xlab = "",
     ylab = "Global Reactive Power")
dev.off()