library(dplyr)
#download file
urlberkas="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
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
a$Global_reactive_power=as.numeric(as.character(a$Global_reactive_power))
a$Voltage=as.numeric(as.character(a$Voltage))
a$Sub_metering_1=as.numeric(as.character(a$Sub_metering_1))
a$Sub_metering_2=as.numeric(as.character(a$Sub_metering_2))
a$Sub_metering_3=as.numeric(as.character(a$Sub_metering_3))
a$Date=as.Date(a$Date,format="%d/%m/%Y")
a=mutate(a,waktu=(paste(a$Date,a$Time)))

png("plot4.png")
par(mfcol=c(2,2))
#SUBPLOT1
with(a,
     plot(
            strptime(waktu,format="%Y-%m-%d %H:%M:%S",tz="GMT"),
            a$Global_active_power,
            type="l",
            main="",
            xlab="",
            ylab="Global Active Power (kilowatts)",
     ))

#SUBPLOT2
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
       lwd=1,
       bty="n"
       )

#SUBPLOT3
with(a,
     plot(
            strptime(waktu,format="%Y-%m-%d %H:%M:%S",tz="GMT"),
            a$Voltage,
            type="l",
            main="",
            xlab="datetime",
            ylab="Voltage",
     ))

#SUBPLOT4
with(a,
     plot(
            strptime(waktu,format="%Y-%m-%d %H:%M:%S",tz="GMT"),
            a$Global_reactive_power,
            type="l",
            main="",
            xlab="datetime",
            ylab="Global_reactive_power",
     ))

dev.off()
