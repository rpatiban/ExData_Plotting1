# plot2.R creates a line graph of household energy usage varies over a 2-day period 
# in February, 2007
# plot2.png is the outcome of this script

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


# Converting factor to numeric for Global Active Power (GAP)
ds1$Global_active_power <- as.numeric(levels(ds1$Global_active_power))[ds1$Global_active_power]

# Gathering 2 days GAP and weekday in Feb 2007
Feb2daysGAP <- ds1[(ds1$Date =="2007-02-01" | ds1$Date =="2007-02-02"),c(3,11)]

# Creating line plot for FEB2daysGAP
plot(Feb2daysGAP$Global_active_power~Feb2daysGAP$Datetime , type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

# Exporting Graphic
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
