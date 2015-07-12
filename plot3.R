# plot3.R creates a line graph for sub meterings (SMS) over a 2-day period 
# in February, 2007
# plot3.png is the outcome of this script

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


# Gathering 2 days Submeterings(SMS) and weekday in Feb 2007
Feb2daysSMS <- ds1[(ds1$Date =="2007-02-01" | ds1$Date =="2007-02-02"),c(7,8,9,11)]

#opening graphic device
png("plot3.png", width=480, height=480, type="windows")

# Creating line plot for Feb2daysSMS
with(Feb2daysSMS, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})

# Creating Legend on the graph
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#turning off Graphic device
dev.off()
