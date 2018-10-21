#Reorder columns in GPS file, or any file where columns and headings need to be changed


gps1641 <- read.csv('C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All GPS Data/GPS_1641.csv')
# edit <- gps1641[ , c(-1)]
edit <- gps1641[ , c(1,2,5,3,4,8,9,6,7,12,13,10,11)]
gps1641 <- edit
write.csv(gps1641, 'C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All GPS Data\\GPS_1641.csv', row.names = F)

gps1642 <-read.csv('C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All GPS Data/GPS_1642.csv', row.names = F)

edit <- gps1642[ , c(-1)]
edit <- edit[ , c(1,2,5,3,4,8,9,6,7,12,13,10,11)]
gps1642 <- edit
write.csv(gps1642, 'C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All GPS Data\\GPS_1642.csv', row.names = F)


gps1108 <-read.csv('C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All GPS Data/GPS_1108.csv')

edit <- gps1108[ , c(-1)]
edit <- edit[ , c(1,2,5,3,4,8,9,6,7,12,13,10,11)]
gps1108<-edit

write.csv(gps1108, 'C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All GPS Data\\GPS_1108.csv')



#Rename columns in the depth spreadsheets


depth <- read.csv('C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All Depth Data\\Depth_1108.csv')
depth<-depth[, -2]
colnames(depth) <- c("Id",	"UTC",	"Sensor_0_Raw",	"Sensor_0_Depth")
depth$Sensor_1_Raw <- NA
depth$Sensor_1_Depth <- NA
write.csv(depth, 'C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All Depth Data\\Depth_1108.csv', row.names = F)
