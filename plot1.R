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

## Create 'myplot1.png' in working directory
png(filename="myplot1.png", width=480, height=480)

## Create the histogram and send to the PNG file
hist(rawdata$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

## Close the PNG file device
dev.off()