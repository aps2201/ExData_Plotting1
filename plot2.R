library(dplyr)
#download file
urlberkas="httpshttps://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./powercons.zip")){
       download.file("urlberkas",
                     "powercons.zip",
                     "curl")
}
#unzip files
if (!file.exists("./household_power_consumption.txt")){
       unzip("powercons.zip")
}
#Read in the data
x=read.table("household_power_consumption.txt",header=T,sep=";")
#subset february 1 and 2
x1=subset(x,x$Date=="1/2/2007")
x2=subset(x,x$Date=="2/2/2007")
#reconstruct
a=rbind(x1,x2)
#make it var numeric
a$Global_active_power=as.numeric(as.character(a$Global_active_power))
a$Date=as.Date(a$Date,format="%d/%m/%Y")
a=mutate(a,waktu=(paste(a$Date,a$Time)))
png("plot2.png")
with(a,
     plot(
       strptime(waktu,format="%Y-%m-%d %H:%M:%S",tz="GMT"),
       a$Global_active_power,
       type="l",
       main="",
       xlab="",
       ylab="Global Active Power (kilowatts)",
       ))
dev.off()