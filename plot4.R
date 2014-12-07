library(data.table)
library(lubridate)
df <- as.data.frame(fread("household_power_consumption.txt", na.strings = '?'))

##convert data to posix
df[,1] <- as.Date(df[,1], "%d/%m/%Y")

##calculate required interval
date1 <- as.POSIXct("2007-01-31 00:00:00")
date2 <- as.POSIXct("2007-02-01 23:59:59")
int <- new_interval(date1, date2)

##subset DF
df <- df[df$Date %within% int,]

#convert time to posix  
date <- df$Date
time <- df$Time
date.time <- paste(date, time)
df$Time <- (strptime(date.time, "%Y-%m-%d %H:%M:%S"))

png("plot4.png")
par(mfrow= c(2,2), mar = c(4,4,2,1), cex = 0.7)
with(df, {
  plot(Time, Global_active_power,ylab = "Global Active Power (kilowatts)", type="l",xlab="")
  plot(Time, Voltage,ylab = "Voltage", type="l",xlab="datetime")
  plot(Time, Sub_metering_1,type="l", ylab= "Energy sub metering", xlab="")
  points(Time, Sub_metering_2,type="l" , col = "red")
  points(Time, Sub_metering_3,type="l", col = "blue" )
  legend("topright", lty=c(1,1,1), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
         col =c("black","red","blue") )
  plot(Time, Global_reactive_power, type="l",xlab="datetime")
})

dev.off()
