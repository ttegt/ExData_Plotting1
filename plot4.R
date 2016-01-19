library(lubridate) #needed library

#An initial inspection reveals the general location of desired data in the 
#larger file. This first part reads in that section.
#This assumes the file household_power_consumption.txt is in the working 
#directory.

hpc <- read.table("household_power_consumption.txt", 
                       sep=";", header=FALSE, skip=60000, nrows=10000, 
                       stringsAsFactors = FALSE)

#This reads the variable names from the first line and attaches them to the
#data frame.

names(hpc) <- read.table("household_power_consumption.txt", sep=";", 
                       nrows=1, stringsAsFactors = FALSE)

#This puts the hpc$Date variable in POSIXct format.

hpc$Date <- dmy(hpc$Date)

#This subsets the desired time interval.

hpc <- hpc[hpc$Date>=ymd("2007/02/01") & hpc$Date<=ymd("2007/02/02"),]



#make the variables numeric

hpc$Global_active_power <- as.numeric(hpc$Global_active_power)
hpc$Sub_metering_1 <- as.numeric(hpc$Sub_metering_1)
hpc$Sub_metering_2 <- as.numeric(hpc$Sub_metering_2)
hpc$Sub_metering_3 <- as.numeric(hpc$Sub_metering_3)
hpc$Voltage <- as.numeric(hpc$Voltage)
hpc$Global_reactive_power <- as.numeric(hpc$Global_reactive_power)
#combine date and time

hpc$dateandtime <- ymd_hms(paste(hpc$Date, hpc$Time))

#create the plot
png(file="plot4.png", width = 480, height = 480)

par(mfcol=c(2,2)) #panels

#plot (1,1) (from plot2 with (kilowatts removed))

plot(hpc$dateandtime, hpc$Global_active_power, type="l", xlab = "", 
     ylab = "Global Active Power")

#plot (2,1) (from plot 3 with legend bounding box off)

plot(hpc$dateandtime, hpc$Sub_metering_1, type="l", 
     xlab="", ylab="Energy sub metering")
lines(hpc$dateandtime, hpc$Sub_metering_2, type="l", col="red")
lines(hpc$dateandtime, hpc$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1,col=c("black","red","blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n")

#plot (1,2)

plot(hpc$dateandtime,hpc$Voltage, type="l", xlab="datetime", ylab="Voltage")

#plot (2,2)

plot(hpc$dateandtime,hpc$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")

dev.off()