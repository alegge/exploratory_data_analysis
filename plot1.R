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


## Create Plot 1 Histogram
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()
