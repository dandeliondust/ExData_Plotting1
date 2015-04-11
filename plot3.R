## Load sqldf package as read.csv.sql function will be used
library("sqldf")

## Read in household_power_consumption.txt file
rawdata <- read.csv.sql("household_power_consumption.txt", sql="SELECT * FROM 
                        file WHERE Date IN ('1/2/2007', '2/2/2007')", 
                        header=TRUE, sep=";", colClasses=c(rep("character",2), 
                                                           rep("numeric",7)))

## Convert Date and Time variables to Date/Time classes
rawdata$DateTime <- strptime(paste(rawdata$Date, rawdata$Time), 
                             "%d/%m/%Y %H:%M:%S")

## Create 'plot3.png' in working directory
png(filename="plot3.png", width=480, height=480, bg="transparent")

## Create the plot and send to the PNG file
plot(rawdata$DateTime, rawdata$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(rawdata$DateTime, rawdata$Sub_metering_2, col="red")
lines(rawdata$DateTime, rawdata$Sub_metering_3, col="blue")

## Add legend to topright corner of plot
legend("topright", col=c("black","red","blue"), lwd=1, 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_2"))

## Close the PNG file device
dev.off()