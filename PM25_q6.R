setwd("C:/Users/Spencer/Desktop/datasciencecoursera/Fine_Par_Matter")

## Data load
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Select data in Baltimore and LA
NEI_balt_la <- subset(NEI,fips == "24510" | fips == "06037")

## Create table of sum of emissions by type and year
library(plyr)
x <- ddply(NEI_balt_la, .(fips, year), summarize, freq=length(fips), tot=sum(Emissions))
x$year <- as.character(x$year)
x$city <- x$fips
x$city[x$city == "24510"] <- "Baltimore"
x$city[x$city == "06037"] <- "Los Angeles"


## Plot
library(ggplot2)

png("Baltimore_LA.png")
ggplot(x, aes(city, tot)) +
        geom_bar(aes(fill = year), position = "dodge", stat="identity") + 
        ylab("PH25 Emissions") +
        xlab("Location") +
        ggtitle("PH25 Emissions Over Time by Location")
dev.off() 