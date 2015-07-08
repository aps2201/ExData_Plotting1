#Read in the data
x=read.table("household_power_consumption.txt",header=T,sep=";")
#subset february 1 and 2
x1=subset(x,x$Date=="1/2/2007")
x2=subset(x,x$Date=="2/2/2007")
#reconstruct
a=rbind(x1,x2)
#make it var numeric
a$Global_active_power=as.numeric(as.character(a$Global_active_power))
#make png
png("plot1.png")
gbr=hist(a$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red")
dev.off()

