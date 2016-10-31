# PLOT 2

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
#plot 2
#--------------
message("Plotting the data...")

        with(Feb2007,plot(datetime,Global_active_power, type = "n", 
                          xlab = "", ylab = "Global Active Power (kilowatts)"))
        with(Feb2007,lines(datetime,Global_active_power))

#-----------
dev.copy(png,file = "plot2.png", width = 480, height = 480)
dev.off()

rm(sourcefile,datafile,tablestr,Feb2007)
message(paste("plot2.png is created in",getwd()))

