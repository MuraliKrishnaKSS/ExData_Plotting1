# PLOT 4

sourcefile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datafile <- "household_power_consumption.txt"

## Download source file to current working directory and unzip the file if it does not exist locally 

        if (!file.exists("dataset.zip")) {
                message("Downloading source files...")
                download.file(sourcefile,"dataset.zip", method="libcurl")
        }
        if (!file.exists(datafile)) {
                message("Unzipping the files...")
                unzip("dataset.zip")
        }
# Load the data file
        tablestr <- c("character", "character", "numeric", "numeric",
                      "numeric", "numeric", "numeric", "numeric", "numeric")

        message("Loading data file...")

        df <- read.table(datafile, header = TRUE, sep = ";", colClasses = tablestr,
                         stringsAsFactors = FALSE, na.strings = "?")

# Filter data and add a variable "datetime"
        Feb2007 <- subset(df,df$Date %in% c("1/2/2007","2/2/2007"))
        rm(df)

        Feb2007 <- subset(Feb2007,complete.cases(Feb2007))
        Feb2007$datetime <- as.POSIXct(paste(Feb2007$Date,Feb2007$Time,sep= " "),
                               "%d/%m/%Y %H:%M:%S", tz = "US/Eastern") #OlsonNames() gives timezones
#plot 4
#--------------
message("Plotting the data...")

par(mfrow = c(2,2), mar= c(4,4,2,1), oma = c(0,0,2,0), cex = 0.6)
        with(Feb2007,plot(datetime,Global_active_power, type = "n", 
                  xlab = "", ylab = "Global Active Power (kilowatts)", cex.lab=1.5))
        with(Feb2007,lines(datetime,Global_active_power))

#--------------------
        with(Feb2007,plot(datetime,Voltage, type = "n", 
                  xlab = "datetime", ylab = "Voltage", cex.lab=1.5))
        with(Feb2007,lines(datetime,Voltage))

#--------------------
        with(Feb2007,plot(datetime,Sub_metering_1, type = "n", 
                          xlab = "", ylab = "Energy sub metering", cex.lab=1.5))
        with(Feb2007,lines(datetime,Sub_metering_1, col = "black"))
        with(Feb2007,lines(datetime,Sub_metering_2, col = "red"))
        with(Feb2007,lines(datetime,Sub_metering_3, col = "blue"))
        
        legend("topright",col=c("black","red","blue"),lty = c(1,1,1), lwd= c(1,1,1), 
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               text.width = strwidth("Sub_metering_1"), bty = "n",
               xjust = 1, yjust = 0, adj=0,y.intersp = 0.3, x.intersp = 0)

#--------------------
        with(Feb2007,plot(datetime,Global_reactive_power, type = "n", 
                          xlab = "datetime", ylab = "Global_reactive_power", cex.lab=1.5))
        with(Feb2007,lines(datetime,Global_reactive_power))
#-------------------
dev.copy(png,file = "plot4.png", width = 480, height = 480)
dev.off()

rm(sourcefile,datafile,tablestr,Feb2007)
message(paste("plot4.png is created in",getwd()))
