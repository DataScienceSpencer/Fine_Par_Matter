## Data load
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Baltimore portion of the above data
NEIbalt <- subset(NEI,fips == "24510")

## Create table of sum of emissions by type and year
library(plyr)
x3 <- ddply(NEIbalt, .(type, year), summarize, freq=length(type), tot=sum(Emissions))
x3$year <- as.character(x3$year)

## Plot
library(ggplot2)

png("baltimore_bytype.png")
ggplot(x3, aes(year, tot)) +
 geom_bar(aes(fill = type), position = "dodge", stat="identity") + 
 ylab("PH25 Emissions") +
 xlab("Year") +
 ggtitle("PH25 Emissions Over Time by Type")
dev.off() 
