## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## This will create a plot of the trajectory of PH25 emissions between 1999 and 2008
table(NEI$type, NEI$year)

library(plyr)
x <- ddply(NEI, .(year), summarize, freq=length(year), tot=sum(Emissions))

png("ph25_all.png")
bp <- barplot(x$tot, main="Sum of PH25 Emissions", xlab="Year",  
        ylab="Total", names.arg=c("1999","2002","2005","2008"), 
        col="lightblue")
text(bp, 0, round(x$tot, 1),cex=1,pos=3) 
dev.off()

## This will do the same as above, but only for Baltimore (fips == "24510")
NEIbalt <- subset(NEI,fips == "24510")

require(plyr)
x2 <- ddply(NEIbalt, .(year), summarize, freq=length(year), tot=sum(Emissions))

png("ph25_baltimore.png")
bp <- barplot(x2$tot, main="Sum of PH25 Emissions in Baltimore", xlab="Year",  
        ylab="Total", names.arg=c("1999","2002","2005","2008"), 
        col="lightblue")
text(bp, 0, round(x2$tot, 1),cex=1,pos=3) 
dev.off()


