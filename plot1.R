library(dplyr)
#read the data in, specifying the seperator, the NAs, 
#only selecting the required days in Feb 2007
powerData <- filter(read.table("household_power_consumption.txt", sep =";", header = TRUE, na.strings = "?"),
                    Date == "1/2/2007" | Date == "2/2/2007")
#open png device
png(filename = "plot1.png", width = 480, height = 480)
#plotting the data using hist
hist(powerData$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
#close the device and safe file to wd
dev.off()