
## Download the dataset
#  setwd("./Project1")
#  dataurl <- "https://github.com/rdpeng/ExData_Plotting1"
#  datafile <- file.path(getwd(), "household_power_consumption.zip")
#  download.file(dataurl, datafile, method = "curl")
##--unzip(datafile, exdir = "./Data")

## This file is for loading the large dataset.
## Getting full dataset

allData <- read.table("./Data/household_power_consumption.txt",
                   header = TRUE,
                   sep = ";",
                   colClasses = c("character", "character", rep("numeric",7)),
                   na = "?")

allData$Date <- as.Date(allData$Date, format="%d/%m/%Y")

## Subsetting the data for the two days 02/01/2007 - 02/02/2007
data <- subset(allData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# free up memory
rm(allData)

## Convert the dates
datetime <- paste(as.Date(data$Date), data$Time)
##data$Datetime <- as.POSIXct(datetime)
data$Datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")

## Plot 1
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
