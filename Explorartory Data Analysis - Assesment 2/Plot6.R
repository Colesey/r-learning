# This is the R Script for creating the Plot6 graph for the Exploratory Data Analysis
# Peer Assesment 2.
# The data is contained in two files summarySCC_PM25.rds and Source_Classification_Code.rds.

# The requirement for this plot is:
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == 06037). 
# Which city has seen greater changes over time in motor vehicle emissions?

setwd("~/r-learning/Explorartory Data Analysis - Assesment 2")
library(dplyr)
library(ggplot2)

#Read in the data file from the current working directory into the data frame NEI
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")


#Subset the data from SCC to only those that are classified as "ONROAD" in the Data.Category variable
onroadSCC <- subset(SCC, Data.Category == "Onroad", select = SCC)
#Find all the rows that have the SCC codes in relating to coal
onroadNEI <- subset(NEI, SCC %in% onroadSCC$SCC)
onroadBaLa <- subset(onroadNEI, fips == "24510" | fips == "06037")

#Summarise the data by year and sum the emissions
onroadBaLaSum <- summarize(group_by(onroadBaLa, year, fips), sum(Emissions))
#Replace the fips code with the city name so the legend on the chart is descriptive
for (i in 1:nrow(onroadBaLaSum)) {
  if (onroadBaLaSum$fips[i] == "24510"){
    onroadBaLaSum$fips[i] <- "Baltimore"
  } else {
    onroadBaLaSum$fips[i] <- "Los Angeles"
  }
}

# Open the png graphics device to create the file
png(file = "Plot6.png")

#Build the plot
myPlot <- ggplot(onroadBaLaSum, aes(x=year, y=`sum(Emissions)`, group=fips, color = fips)) 
myPlot <- myPlot + geom_line() 
#myPlot <- myPlot + scale_y_continuous(limit = c(0, 400))
myPlot <- myPlot + labs(y = "PM25 Emissions \n (tons)", 
                        x = "Year", 
                       title = "PM2.5 Emissons related to the \n On-Road sources in Baltimore and Los Angeles \n (1999 - 2008)")

print(myPlot)

dev.off()