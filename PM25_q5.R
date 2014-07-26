## Data load
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Select data in Baltimore and for motor vehicles
NEIbalt_veh <- subset(NEI,fips == "24510" & type == "ON-ROAD")

## Create a new data-table with the sums of each year
require(plyr)
x3 <- ddply(NEIbalt, .(year), summarize, freq=length(year), tot=sum(Emissions))
x3$year <- as.character(x3$year)

## Plot

png("baltimore_mot_veh.png")
bp <- barplot(x3$tot, main="PH25 Emissions from motor vehicles", xlab="Year",  
              ylab="Total", names.arg=c("1999","2002","2005","2008"), 
              col="lightblue")
text(bp, 0, round(x3$tot, 1),cex=1,pos=3) 
dev.off()