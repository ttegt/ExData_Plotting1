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
                       nrows=1,stringsAsFactors = FALSE)

#This puts the hpc$Date variable in POSIXct format.

hpc$Date <- dmy(hpc$Date)

#This subsets the desired time interval.

hpc <- hpc[hpc$Date>=ymd("2007/02/01") & hpc$Date<=ymd("2007/02/02"),]



#make the Global_active_power variable numeric

hpc$Global_active_power <- as.numeric(hpc$Global_active_power)

#combine date and time

hpc$dateandtime <- ymd_hms(paste(hpc$Date, hpc$Time))

#create the plot

png(file="plot2.png", width = 480, height = 480)
plot(hpc$dateandtime, hpc$Global_active_power, type="l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()