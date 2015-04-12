
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
data$Datetime <- as.POSIXct(datetime)

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
        plot(Global_active_power~Datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~Datetime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~Datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()