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

# draw the plot 
with(mData, plot(DateTime, 
				 Sub_metering_1, 
				 type="l",
				 xlab = "",
				 ylab = "Energy sub metering"))

with(mData, points(DateTime, 
				 Sub_metering_2, 
				 type="l",
				 col = "red"))

with(mData, points(DateTime, 
				 Sub_metering_3, 
				 type="l",
				 col = "blue"))

legend("topright", 
	   pch = c(NA, NA, NA), 
	   col = c("black", "red", "blue"), 
	   legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
	   lwd = 2)

dev.copy(png, file = "plot3.png")
dev.off()