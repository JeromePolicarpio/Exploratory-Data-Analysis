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

# Plot the histogram
hist(powercons$Global_active_power,  col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Save the  plot into "plot1.png" image file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()