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
				 Global_active_power, 
				 type="l",
				 ylab = "Global Active Power (kilowatts)",
				 xlab = ""
				 ))
dev.copy(png, file = "plot2.png")
dev.off()