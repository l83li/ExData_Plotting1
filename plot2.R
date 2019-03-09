## Download the target data and generage the raw data
if(!file.exists("data.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      destfile="./data.zip")}
unzip("data.zip")
library(dplyr)
rawdata<-tbl_df(read.table("household_power_consumption.txt", 
                           sep=";", header = T, na.strings="?"))
## Change the Date class from a factor to a Date
rawdata <-mutate(rawdata, Date=as.Date(rawdata$Date,"%d/%m/20%y"))
## filter the data from 2007-02-01 and 2007-02-02
data1 <- filter(rawdata,Date=="2007-02-01"|Date=="2007-02-02")

## Paste the data and time together to obtain the time in the day
data1 <- mutate(data1, Time=paste(Date, Time))
date_time<- strptime(data1$Time, "%Y-%m-%d %H:%M:%S")
data2 <- cbind(data1, date_time)
       
## Plot the data
png("plot2.png", width=480, height=480)

plot(data2$date_time, data2$Global_active_power,type="l",
     xlab="", ylab="Global Active Power (kilowatts)")
dev.off()