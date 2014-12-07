library(data.table)
library(lubridate)
df <- as.data.frame(fread("household_power_consumption.txt", na.strings = '?'))

##convert data to posix
df[,1] <- as.Date(df[,1], "%d/%m/%Y")

##calculate required interval
date1 <- as.POSIXct("2007-01-31 00:00:00")
date2 <- as.POSIXct("2007-02-01 23:59:59")
int <- new_interval(date1, date2)

##subset DF for the required period
df <- df[df$Date %within% int,]

## time/date manipulation
date <- df$Date
time <- df$Time
date.time <- paste(date, time)
df$Time <- (strptime(date.time, "%Y-%m-%d %H:%M:%S"))

##plot graph2
plot(df$Time, df$Global_active_power,ylab = "Global Active Power (kilowatts)", type="l",xlab="")


##create a png file
dev.copy(png, file= "plot2.png")
dev.off()