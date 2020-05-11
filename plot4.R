library(dplyr)
#read the data in, specifying the seperator, the NAs, 
#only selecting the required days in Feb 2007
powerData <- filter(read.table("household_power_consumption.txt", sep =";", header = TRUE, na.strings = "?"),
                    Date == "1/2/2007" | Date == "2/2/2007")
#create a column with Dates and Times of the day
powerData <- mutate(powerData, dateTime = paste(Date, Time))
#make the dateTime column filter- and graphable
powerData$dateTime <- with(powerData, as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

#open png device
png(filename = "plot4.png", width = 480, height = 480)

#specifying nr of plots in output
par(mfcol = c(2,2))

#plotting the first plot
plot(x = powerData$dateTime, y = powerData$Global_active_power, 
                     xlab = " ", ylab = "Global Active Power (kilowatts)",
                     type = "l")

#plotting the second plot (bottomleft)
plot(x = powerData$dateTime, y = powerData$Sub_metering_1,
     xlab = " ", ylab = "Energy sub metering",
     type = "l")
lines(x = powerData$dateTime, y = powerData$Sub_metering_2, col = "red")
lines(x = powerData$dateTime, y = powerData$Sub_metering_3, col = "blue")
legend("topright",col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), lwd = c(1,1))

#plotting the third plot (topright)
plot(x = powerData$dateTime, y = powerData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#plotting fourth plot (bottomright)
plot(x = powerData$dateTime, y = powerData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

#closing the device and safe file to wd
dev.off()