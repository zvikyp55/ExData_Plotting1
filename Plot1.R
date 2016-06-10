##Plotting Assignment 1 for Exploratory Data Analysis

##Plot1

plot1<-function(){
    
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
    
    ##Subset to the required dates
    data1$Date<-dmy(data1$Date)  ##convert to date format
    data1<-subset(data1,data1$Date>=as.Date("2007-02-01") & data1$Date<=as.Date("2007-02-02") )
    
    ## Draw the plot
    par(mar=c(4,4,4,3)) ##set margins
    hist(data1$Global_active_power,col = "red",xlab = "Global Active Power (kilowatts)", ylab = "Frequency",main = "Global Active Power")
    
    ##copy to png
    dev.copy(png, file = "plot1.png",width = 480, height = 480)
    dev.off() ##close device
    
    
}