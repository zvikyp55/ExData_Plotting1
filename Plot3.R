##Plotting Assignment 3 for Exploratory Data Analysis

##Plot3

plot3<-function(){
    
    ##install.packages("lubridate")
    if (!require("lubridate",character.only = TRUE))
    {
        install.packages("lubridate",dep=TRUE)
        if(!require("lubridate",character.only = TRUE)) stop("Package not found")
    }
    
    ##Download the data file
    
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","exdata-data-household_power_consumption.zip")
    
    ## Verify that data file exists in the working directory
    strZipFile <- "exdata-data-household_power_consumption.zip"
    if (!file.exists(as.character(strZipFile))) {
        return(paste(c("Sorry that file " , as.character(strZipFile), " could not be found."),sep= " ",collapse="" ))
    }
    
    ##read in the text file, replace ? with NA
    data1<-read.table(unz(strZipFile,"household_power_consumption.txt"),sep=";",header = T,na.strings = c("?"))
    
    ##Clean the data, remove missing values
    data1<-data1[complete.cases(data1),]
    
    ##Subset to the required dates and time
    data1$DateTime<-dmy(data1$Date) + hms(data1$Time) ##convert to date time format
    data1<-subset(data1,data1$DateTime>=ymd_hms("2007-02-01 0:00:00") & data1$DateTime<ymd_hms("2007-02-03 0:00:00") )
    
    ## Draw the plot
    par(mar=c(4,4,4,3)) ##set margins
    plot(data1$DateTime , data1$Sub_metering_1,col = "black",xlab="",ylab = "Energy sub metering",type = "l",xaxt="n") ##set the plot space
        ##Add the second and third meters
        lines(data1$DateTime,data1$Sub_metering_2, col ="red")
        lines(data1$DateTime,data1$Sub_metering_3, col ="blue")
        legend("topright",colnames(data1[7:9]),col=(c("black","red","blue")),lty = 1)
    axis.POSIXct(1, at=seq(min(data1$DateTime),max(data1$DateTime)+days(1), by="day"), format="%a")  ##label the axis with days
    
    ##copy to png
    dev.copy(png, file = "plot3.png",width = 480, height = 480)
    dev.off() ##close device
    
    
}