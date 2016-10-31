# PLOT 3

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
#plot 3
#--------------
message("Plotting the data...")

        with(Feb2007,plot(datetime,Sub_metering_1, type = "n", 
                          xlab = "", ylab = "Energy sub metering"))
        with(Feb2007,lines(datetime,Sub_metering_1, col = "black"))
        with(Feb2007,lines(datetime,Sub_metering_2, col = "red"))
        with(Feb2007,lines(datetime,Sub_metering_3, col = "blue"))
        
        legend("topright",col=c("black","red","blue"),lty = c(1,1,1), lwd= c(1,1,1), 
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               text.width = strwidth("Sub_metering_1"),
               xjust = 1, yjust = 0, adj=0,y.intersp = 0.3)

#-------------
dev.copy(png,file = "plot3.png", width = 480, height = 480)
dev.off()

rm(sourcefile,datafile,tablestr,Feb2007)
message(paste("plot3.png is created in",getwd()))
        