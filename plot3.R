# Exploratory Data Analysis Project
# plot3.R file
# Plot 3 Script

# Load Data
zipName <- "data.zip"
dataFile <- "household_power_consumption.txt"
# Download data and uncompress if it does not exist
if(!file.exists(zipName)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  print("Downloading data...")
  download.file(fileURL, zipName, method = "curl")
}
if(!file.exists(dataFile)){ 
  cat("Uncompressing data...", zipName, "\n")
  unzip(zipName)
}else{
  cat("Data already in Working Directory: ", dataFile, "\n")
}

# Read Dataset
print("Reading household data...")
power <- read.csv(dataFile, sep = ";", na.strings = "?")

# Clean data
print("Parsing dates...")
power$Date <- as.Date(power$Date, "%d/%m/%Y")
startDate <- as.Date("2007-02-01")
endDate <- as.Date("2007-02-02")
power <- subset(power, (Date == startDate | Date == endDate))

# Date Time Column 
power$DateTime <- strptime(paste(power$Date, power$Time),"%Y-%m-%d %H:%M:%S")

# Plot to png
print("Plotting to file...")
Sys.setlocale("LC_ALL", "en_US.UTF-8") # Need to set xaxis labels in english in personal computer
# Start graphics device
png("plot3.png")

# Sub metering 1 line
plot(power$DateTime, power$Sub_metering_1, ylab = "Energy sub mettering", xlab = "", type = "l")
# Sub metering 2 line
lines(power$DateTime, power$Sub_metering_2, col = "red")
# Sub metering 3 line
lines(power$DateTime, power$Sub_metering_3, col = "blue")
# Plot legend
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close graphics device
dev.off()