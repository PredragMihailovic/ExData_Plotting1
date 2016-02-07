library(sqldf)
#set working directory
setwd("D:\\DataScientist\\projects\\ExData_Plotting1")

# can be done like this, but I found better way 
#mData <- read.csv("household_power_consumption.txt", sep=";", header = T)


# declare a data file
mFile <- "..\\household_power_consumption.txt"

#read just rows we need
mData <- read.csv.sql(mFile, sep=";", header = T, 
					  sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"')
#close file connection
closeAllConnections()

#introduce new column as DateTime
mData$DateTime <- strptime(paste(mData$Date, mData$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
par(mfrow = c(2, 2))
# draw the plot 
with(mData, {
	#1
		plot(DateTime, Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
	#2
		plot(DateTime, Voltage, type="l", ylab = "Voltage", xlab = "")
	#3
	 	plot(DateTime, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
		points(DateTime, Sub_metering_2, type="l", col = "red")
		points(DateTime,  Sub_metering_3,  type="l", col = "blue")
		legend("topright", pch = c(NA, NA, NA),  col = c("black", "red", "blue"),   legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),	   lwd = 2)
	#4		
		plot(DateTime, Global_reactive_power, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
		
})

dev.copy(png, file = "plot4.png")
dev.off()