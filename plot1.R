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

##construct histogram
hist(as.numeric(df$Global_active_power), xlab= 'Global Active Power (kilowatts)', col = 'red', main = 'Global Active Power')

##create a png file
dev.copy(png, file= "plot1.png")
dev.off()
