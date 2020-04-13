#Loading the data
filename<-"exdata_data_household_power_consumption.zip"
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, filename, method="curl")
unzip(filename)
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#Only use date from 2007-02-01 and 2007-02-02
data$Date<-as.Date(data$Date, format = "%d/%m/%Y")
data1<-data %>% filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))
#plot3
png("plot3.png")
par(mfrow=c(1,1))
data1$Sub_metering_1<-as.numeric(levels(data1$Sub_metering_1))[data1$Sub_metering_1]
data1$Sub_metering_2<-as.numeric(levels(data1$Sub_metering_2))[data1$Sub_metering_2]
data1$Sub_metering_3<-as.numeric(levels(data1$Sub_metering_3))[data1$Sub_metering_3]
data1$datetime <- strptime(paste(data1$Date, data1$Time), "%Y-%m-%d %H:%M:%S")
data1$datetime <- as.POSIXct(data1$datetime)
with(data1,plot(Sub_metering_1~datetime,type="l",ylab="Energy sub metering",xlab=''))
lines(data1$Sub_metering_2~data1$datetime,type="l",col="red")
lines(data1$Sub_metering_3~data1$datetime,type="l",col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black", "red","blue"),lty=1)



dev.off()