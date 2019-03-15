## Read data and convert date column to dateTime
power_consump <- read.csv('household_power_consumption.txt', sep = ';', na.strings = "?")
power_consump$Date <- as.Date(power_consump$Date, format = '%d/%m/%Y')

## Select dates from 2007-02-01 to 2007-02-02
data <- subset(power_consump, Date >= '2007-02-01' & Date <= '2007-02-02')

## Select only complete cases
data <- data[complete.cases(data),]

## Combine date and time into one column
datetime <- paste(data$Date, data$Time)
datetime <- setNames(datetime, "DateTime")
drops <- c("Date", "Time")
data <- data[ , !(names(data) %in% drops)] 
data <- cbind(datetime, data)

## Convert datetime to days of week
data$datetime <- as.POSIXct(datetime)


## Create Plot 4
par(mfrow = c(2, 2))

with(data, plot(datetime, Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = ''))

with(data, plot(datetime, Voltage, type = 'l', ylab = 'Voltage (volt)', xlab = ''))

plot(data$datetime, data$Sub_metering_1, type = 'l', ylab = 'Energy sub metering', xlab = '')
with(data, lines(datetime, Sub_metering_2, col = 'red'))
with(data, lines(datetime, Sub_metering_3, col = 'blue'))
legend("topright", col = c("black", "red", "blue"), lwd = c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(data, plot(datetime, Global_reactive_power, type = 'l'))

dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()
