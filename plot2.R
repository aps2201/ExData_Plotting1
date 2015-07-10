library(dplyr)
library(ggplot2)
library(lattice)
x=read.table("household_power_consumption.txt",header=T,sep=";")
x1=subset(x,x$Date=="1/2/2007")
x2=subset(x,x$Date=="2/2/2007")
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