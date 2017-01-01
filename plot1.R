# Exploratory Data Analysis Project
# plot1.R file
# Plot 1 Script

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

# Plot to png
print("Plotting to file...")
# Start graphics device
png("plot1.png")

# Histogram Plot
hist(power$Global_active_power, col = "red", xlab = "Global Active Power (kilowats)", main = "Global Active Power")

# Close graphics device
dev.off()