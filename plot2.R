#Loading the data
filename<-"exdata_data_household_power_consumption.zip"
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, filename, method="curl")
unzip(filename)
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#Only use date from 2007-02-01 and 2007-02-02
data$Date<-as.Date(data$Date, format = "%d/%m/%Y")
data1<-data %>% filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))
#plot2
png("plot2.png")
par(mfrow=c(1,1))
data1$Global_active_power_1<-as.numeric(levels(data1$Global_active_power))[data1$Global_active_power]
data1$datetime <- strptime(paste(data1$Date, data1$Time), "%Y-%m-%d %H:%M:%S")
data1$datetime <- as.POSIXct(data1$datetime)
with(data1,plot(Global_active_power_1~datetime,type="l",ylab="Global Active Power (kilowatts)"))
dev.off()