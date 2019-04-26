# Download the dataset and extract the .txt file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "dataset.zip")
unzip("dataset.zip")

#Read the power consumption data
powercons <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# convert the class of date variable from factor to Date class 
powercons$Date <- as.Date(powercons$Date, format = "%d/%m/%Y")

# Subset the needed data from 2007-02-01 to 2007-02-02 dates only
powercons <- subset(powercons, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# Convert dates and times
powercons$datetime <- strptime(paste(powercons$Date, powercons$Time), "%Y-%m-%d %H:%M:%S")

# Plot
powercons$datetime <- as.POSIXct(powercons$datetime)
par(mfrow = c(2, 2))
plot(powercons$Global_active_power ~ powercons$datetime, type = "l", ylab = "Global Active Power", xlab = "")
plot(powercons$Voltage ~ powercons$datetime, type = "l", ylab = "Voltage", xlab = "datetime")
plot(powercons$Sub_metering_1 ~ powercons$datetime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(powercons$Sub_metering_2 ~ powercons$datetime, col = "Red")
lines(powercons$Sub_metering_3 ~ powercons$datetime, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.75, bty = "n")
plot(powercons$Global_reactive_power ~ powercons$datetime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

# Save the  plot into "plot4.png" image file
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()