library(lubridate)

#Read the data
power.consumption <- read.table("household_power_consumption.txt",header=TRUE, sep = ";")

#Convert Date & Filter data by Date
power.consumption$Date <- dmy(power.consumption$Date)
pc <- power.consumption[power.consumption$Date %in% ymd(c("2007/02/01", "2007/02/02")),]

#Convert/Reformat Data
pc$Global_active_power <- as.numeric(as.character(pc$Global_active_power, na.strings ="?"))
pc$Sub_metering_1 <- as.numeric(as.character(pc$Sub_metering_1, na.strings ="?"))
pc$Sub_metering_2 <- as.numeric(as.character(pc$Sub_metering_2, na.strings ="?"))
pc$Sub_metering_3 <- as.numeric(as.character(pc$Sub_metering_3, na.strings ="?"))
pc$Voltage <- as.numeric(as.character(pc$Voltage, na.strings ="?"))
pc$Global_reactive_power <- as.numeric(as.character(pc$Global_reactive_power, na.strings ="?"))

#Create DateTime variable
temp <- paste(as.character(pc$Date),as.character(pc$Time,na.string="?"))
pc$DateTime <- strptime(temp,format="%Y-%m-%d %H:%M:%S")

#Plot
png(file="plot3.png")
plot(pc$DateTime,pc$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(pc$DateTime,pc$Sub_metering_1, col="Black")
lines(pc$DateTime,pc$Sub_metering_2, col="Red")
lines(pc$DateTime,pc$Sub_metering_3, col="Blue")
legend(x="topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lwd =2, bty= "o",col = c("Black","Red","Blue"))
dev.off()