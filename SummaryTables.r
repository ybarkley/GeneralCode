#August 5, 2018

# Make table from acoustic detection datasheet

#MACS2015 for Marie
library(plyr)
library(data.table)

macsdf <- read.csv('C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All Acoustic Detections\\PACES_HICEAS2017_HITEC_AcousticDetections.csv')

#which columns do you want?
macsdf <- macsdf[, c(1,8,9,29)] 
#count number of species based on code
tab <- count(macsdf, "species1_class1")

write.csv(tab, 'E:\\MACS2015\\MACS_1502_SETTE_SummaryTables.csv', row.names = FALSE)


###Count dem' spermies for 1303, HICEAS2017, 1604

df_sperm <- subset(macsdf, macsdf$species1_class1==46)
dt <- data.table(df_sperm)

#sighted sperm whales
sighted<-as.data.frame(with( df_sperm[df_sperm$ac_id <999 & df_sperm$vis_id < 999,], table(cruiseID) ))

#unsighted sperm whales
unsighted <- as.data.frame(with( df_sperm[df_sperm$ac_id >= 1 & df_sperm$vis_id == 999,], table(cruiseID) ))

spermie <- cbind(sighted, unsighted)
spermie <- spermie[,-3]
#change column names and spruce things up
colnames(spermie) <- c("cruise", "sighted", "unsighted")
spermie$cruise <- as.character(spermie$cruise)
spermie$sighted <- as.character(spermie$sighted)
spermie$unsighted <- as.character(spermie$unsighted)


#add 1502 sperm whale data
add <- c(1502, 3, 4)
spermie <- data.frame(rbind(spermie[1,], add, spermie[2:4,]))
spermie$cruise <- as.factor(spermie$cruise)
spermie$sighted <- as.numeric(spermie$sighted)
spermie$unsighted <- as.numeric(spermie$unsighted)

write.csv(spermie, 'C:\\Users\\Yvonne\\Documents\\PHD\\CHP2&3-Sperm\\data\\All Acoustic Detections\\Sperm whale summary_HIEEZ.csv', row.names = F)
