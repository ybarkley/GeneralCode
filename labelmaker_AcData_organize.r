#saved in C:\Users\yvonne.barkley\Documents\R Code\Acoustic Data Organization
library(dplyr)

#mydata<-read.csv('C:\\Users\\yvonne.barkley\\BACKUP_PROJECTS\\MACS 2015 - SE1502\\Data Edits/MACS_1502_SETTE_AcousticDetections.csv')

mydata<-read.csv('C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All Acoustic Detections\\HICEAS_1641_MAC_AcousticDetections_WLABEL.csv')
mydata2<-read.csv('C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All Acoustic Detections\\HICEAS_1642_SETTE_AcousticDetections_WLABEL.csv')

#mydata <- read.csv('MACS_1502_SETTE_AcousticDetections.csv', header=TRUE)

#Make empty vector of 0's called 'Label'
Label<-rep(0,length(mydata[,1]))
#Make empty vectors of 0's called 'Vis' and 'Ac'
Vis<-rep(0,length(mydata[,1]))
Ac<-rep(0,length(mydata[,1]))
Cr<-rep(1604,length(mydata[,1]))

#Input correct column numbers for vis and ac id's
for (i in 1:length(mydata[,1])){
	Vis[i]<-ifelse(mydata[i,9]==999,999,(mydata[i,9])) ##Reads the Visual sighting number
	Ac[i]<-ifelse(mydata[i,8]==999,999,(mydata[i,8])) ##Reads the Acoustic detection number
	Label[i]<-paste('1604',".A",Ac[i],".S",Vis[i],sep="")  ##Combines the cruise number with the A and S#s or mydata[i, col# with cruise number]
	}


NewTable<-cbind('cruiseID'=Cr, Label, mydata)
NewTable<-NewTable[, -c(5)] 

colnames(NewTable)[3] <- "Id" 

#NewTable<-select(NewTable, Label, everything()) NOT SURE WHAT THIS USED TO DO
write.csv(NewTable,'E:\\HICEAS_2017\\HICEAS_1705_Lasker_AcousticDetections.csv', row.names = F)


mydata1<-read.csv('E:\\HICEAS_2017\\HICEAS_1705_Lasker_AcousticDetections.csv')
mydata2<-read.csv('E:\\HICEAS_2017\\HICEAS_1706_Sette_AcousticDetections.csv')
combined <- rbind.data.frame(mydata1, mydata2)

mydata <- mydata[, -31]
combined <- smartbind(mydata, mydata2)


write.csv(combined,'C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All Acoustic Detections\\HICEAS2010.csv', row.names = F)

#1303 edits
mydata<- mydata[, c(6, 1:5, 7:11, 13, 15:31, 34)]

#add columns to match 1705
loc_type<-rep(NA,length(mydata[,1]))
loc_method<-rep(NA,length(mydata[,1]))
call2<-rep(NA,length(mydata[,1]))
call3<-rep(NA,length(mydata[,1]))
call4<-rep(NA,length(mydata[,1]))
x1 <- rep(NA,length(mydata[,1]))
x2 <- rep(NA,length(mydata[,1]))
x3 <- rep(NA,length(mydata[,1]))

mydata <- cbind(mydata, loc_type, loc_method, call2, call3, call4, x1, x2, x3)
dfnew <-mydata[, c(1:12, 31, 13:20, 32, 21, 33:35, 22:29, 36:38, 30 )]

#change 1303 col names to match 1705
colnames(mydata)[colnames(mydata) == 'X1st_detection'] <- 'first_detection'
colnames(mydata)[colnames(mydata) == 'acoustic_id'] <- 'ac_id'
colnames(mydata)[colnames(mydata) == 'visual_id'] <- 'vis_id'
colnames(combined)[colnames(combined) == 'latlong_LAT'] <- 'latitude'
colnames(combined)[colnames(combined) == 'latlong_LON'] <- 'longitude'
colnames(mydata)[colnames(mydata) == 'vocal_type'] <- 'call1'
colnames(mydata)[colnames(mydata) == 'Cruise.Number'] <- 'cruiseID'
colnames(mydata)[colnames(mydata) == 'comments'] <- 'Comment'

dfnew <-mydata[, c(1:12, 31, 13:20, 32, 21, 33:35, 22:29, 36:38, 30 )]

colnames(dfnew)[colnames(dfnew) == 'species_class1'] <- 'species1_class1'
colnames(dfnew)[colnames(dfnew) == 'species_class2'] <- 'species1_class2'
colnames(dfnew)[colnames(dfnew) == 'species_class3'] <- 'species1_class3'
colnames(dfnew)[colnames(dfnew) == 'x1'] <- 'species2_class2'
colnames(dfnew)[colnames(dfnew) == 'x2'] <- 'species2_class1'
colnames(dfnew)[colnames(dfnew) == 'x3'] <- 'species2_class3'

dfnew<- dfnew[, c(1:30,36,31,32,35,33,34,37,38)]

# Combine dfs
#use smartbind due to class mismatch error with rbind
require(gtools)
bigdf <- smartbind(dfnew, combined) 
write.csv(bigdf, 'C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All Acoustic Detections\\PACES_HICEAS2017_AcousticDetections.csv', row.names = F)

