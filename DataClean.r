# March 15, 2018

# SCript to examine and clean large datasets: GPS, Depth data for Pm localization

####################
# FOR PACES  ###
####################

#Load gps & depth data
gps <- read.csv('C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All GPS Data/GPS_1108.csv')
depth <- read.csv('C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All Depth Data/Depth_1108.csv')

### Need to verify dates: Will use POSIXlt functions (Week3, Anna's class)
#Takes the format of the original Date-Time column and extracts the year, then creates a new column containing the separate objects, Year, Month, Day, etc.
gps$Month <- as.numeric(format(strptime(gps$UTC, format= "%m/%d/%Y %H:%M:%S"), "%m"))
gps$Day <- as.numeric(format(strptime(gps$UTC, format= "%m/%d/%Y %H:%M:%S"), "%d"))
gps$Year <- as.numeric(format(strptime(gps$UTC, format= "%m/%d/%Y %H:%M:%S"), "%Y"))

gps$hour <- as.numeric(format(strptime(gps$UTC, format= "%m/%d/%Y %H:%M:%S"), "%H"))
gps$min <- as.numeric(format(strptime(gps$UTC, format= "%m/%d/%Y %H:%M:%S"), "%M"))
gps$sec <- as.numeric(format(strptime(gps$UTC, format= "%m/%d/%Y %H:%M:%S"), "%S"))

# Look for dates that are inconsistent with the expected survey dates and replace them with the correct value(s)
gps$Month[which(gps$Month != 05 & gps$Day >= 08 & gps$Day <= 31)] = '5' 

wrongMonth<-gps[which(gps$Month != 05 & gps$Day >= 08 & gps$Day <= 31), ] 
# range(wrongMonth$Day)


#Combine corrected date-time into single column
library(lubridate)
gps$UTC = mdy_hms(paste(gps$Month, gps$Day, gps$Year, gps$hour, gps$min, gps$sec))
gps <- gps[, c(1:14, 16, 17, 15, 18:20)]

#Plot UTC to visually check
plot(gps$UTC, gps$Latitude)

#Write new file
write.csv(gps, 'C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All GPS Data/GPS_1303.csv', row.names = F )


## Same Steps with Depth File
depth$Month <- as.numeric(format(strptime(depth$UTC, format= "%m/%d/%Y %H:%M:%S"), "%m"))
depth$Day <- as.numeric(format(strptime(depth$UTC, format= "%m/%d/%Y %H:%M:%S"), "%d"))
depth$Year <- as.numeric(format(strptime(depth$UTC, format= "%m/%d/%Y %H:%M:%S"), "%Y"))

depth$hour <- as.numeric(format(strptime(depth$UTC, format= "%m/%d/%Y %H:%M:%S"), "%H"))
depth$min <- as.numeric(format(strptime(depth$UTC, format= "%m/%d/%Y %H:%M:%S"), "%M"))
depth$sec <- as.numeric(format(strptime(depth$UTC, format= "%m/%d/%Y %H:%M:%S"), "%S"))

#Paste back into column for POSIXlt format
depth$UTC = mdy_hms(paste(depth$Month, depth$Day, depth$Year, depth$hour, depth$min, depth$sec))

#Visualize with a plot
library(ggplot2)
ggplot(depth, aes(UTC, Sensor_0_Depth)) + 
  geom_line() + geom_point()+
  scale_x_datetime(date_breaks=waiver(), minor_breaks=waiver())


#Correct dates
depth$Month[which(depth$Month != 05 & depth$Day >= 08 & depth$Day <= 31)] = '5' 
wrongMonDepth<-depth[which(depth$Month != 05 & depth$Day >= 08 & depth$Day <= 31),]
#Paste corrected dates back into UTC column
depth$UTC = mdy_hms(paste(depth$Month, depth$Day, depth$Year, depth$hour, depth$min, depth$sec))

write.csv(depth, 'C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All Depth Data/Depth_1303.csv', row.names = F )


ggplot(depth, aes(DatePOSIX, Depth_m)) + 
  theme_bw()+ 
  theme(axis.text.x = element_text(angle=45, hjust=1), plot.margin = margin(10,20,10,10))+
  geom_line() + geom_point()+
  scale_y_discrete(breaks = seq(-0.05, 10, by = .05))+
   scale_x_datetime(
    date_breaks="5 days", 
    date_labels = ("%m-%d-%Y")) +
  xlab("Date-Time") +
  ylab("Depth (m)")+
  labs(title = "Depth_1108")
