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

# Plot 2
png(filename = "plot2.png", width = 480, height = 480)
plot(EPC_data_subset$Date.Time, EPC_data_subset$Global_active_power,
     type = "line",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()

