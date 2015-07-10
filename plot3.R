library(dplyr)
library(ggplot2)
library(lattice)
x=read.table("household_power_consumption.txt",header=T,sep=";")
x1=subset(x,x$Date=="1/2/2007")
x2=subset(x,x$Date=="2/2/2007")
a=rbind(x1,x2)
#make it var numeric
a$Sub_metering_1=as.numeric(as.character(a$Sub_metering_1))
a$Sub_metering_2=as.numeric(as.character(a$Sub_metering_2))
a$Sub_metering_3=as.numeric(as.character(a$Sub_metering_3))
a$Date=as.Date(a$Date,format="%d/%m/%Y")
a=mutate(a,waktu=(paste(a$Date,a$Time)))
png("plot3.png")
with(a,
     plot(strptime(waktu,format="%Y-%m-%d %H:%M:%S",tz="GMT")
          ,y=a$Sub_metering_1,type="n",
          main="",
          xlab="",
          ylab="Energy sub metering",
          )
     )
#submeter1
with(a,
     lines(x=strptime(waktu,format="%Y-%m-%d %H:%M:%S",tz="GMT")
            ,y=a$Sub_metering_1,lwd=1,col="black")
     )
#submeter2
with(a,
     lines(x=strptime(waktu,format="%Y-%m-%d %H:%M:%S",tz="GMT")
           ,y=a$Sub_metering_2,lwd=1,col="red")
     )
#submeter3
with(a,
     lines(x=strptime(waktu,format="%Y-%m-%d %H:%M:%S",tz="GMT")
           ,y=a$Sub_metering_3,lwd=1,col="blue")
     )
#add legend
legend(x="topright",
       legend=colnames(a[7:9]),
       col=c("black","red","blue"),
       lty=1,
       lwd=1
       )
dev.off()