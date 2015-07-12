# plot4.R creates a histogram of household energy usage varies over a 2-day period 
# in February, 2007
# plot4.png is the outcome of this script

# Set working directory
setwd("C:/Raghu/Rscipts")

# Reading the data into dataframe
ds1 <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE, sep = ";" )

# concatenating Date and time, converting them into Timestamp 
# and adding a new column with outocme 
ds1$TimeStamp <- strptime(paste(ds1$Date,ds1$Time), "%d/%m/%Y %H:%M:%S")

# converting Data type to Date factor
ds1$Date <- as.Date(ds1$Date, "%d/%m/%Y")

# Adding a new column for timestamp posix count
ds1$Datetime <- as.POSIXct(ds1$TimeStamp)


# Converting factor to numeric 
ds1$Sub_metering_1 <- as.numeric(levels(ds1$Sub_metering_1))[ds1$Sub_metering_1]
ds1$Sub_metering_2 <- as.numeric(levels(ds1$Sub_metering_2))[ds1$Sub_metering_2]
ds1$Global_active_power <- as.numeric(levels(ds1$Global_active_power))[ds1$Global_active_power]
ds1$Global_reactive_power <- as.numeric(levels(ds1$Global_reactive_power))[ds1$Global_reactive_power]
ds1$Voltage <- as.numeric(levels(ds1$Voltage))[ds1$Voltage]

# Gathering 2 days data in Feb 2007
Feb2days <- ds1[(ds1$Date =="2007-02-01" | ds1$Date =="2007-02-02"),]

#opening graphic device
png("plot4.png", width=480, height=480, type="windows")

# Creating line plot for Feb2daysSMS
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(Feb2days, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power",xlab="")
})

#turning off Graphic device
dev.off()
