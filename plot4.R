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

## Create 'myplot4.png' in working directory
png(filename="myplot4.png", width=480, height=480)

## Create the plot and send to the PNG file
par(mfrow=c(2,2))

## Plot topleft (Global Active Power)
plot(rawdata$DateTime, rawdata$Global_active_power, type="l", xlab="",
     ylab="Global Active Power")

## Plot topright (Voltage)
plot(rawdata$DateTime, rawdata$Voltage, type="l", xlab="datetime",
     ylab="Voltage")

## Plot bottomleft (Energy sub metering)
plot(rawdata$DateTime, rawdata$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(rawdata$DateTime, rawdata$Sub_metering_2, col="red")
lines(rawdata$DateTime, rawdata$Sub_metering_3, col="blue")

## Add legend to topright corner of Energy sub metering plot
legend("topright", col=c("black","red","blue"), lwd=1, bty="n", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_2"))

## Plot bottomright (Global_reactive_power)
plot(rawdata$DateTime, rawdata$Global_reactive_power, type="l", xlab="datetime",
     ylab="Global_reactive_power")

## Close the PNG file device
dev.off()