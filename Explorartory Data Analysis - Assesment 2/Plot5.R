# This is the R Script for creating the Plot5 graph for the Exploratory Data Analysis
# Peer Assesment 2.
# The data is contained in two files summarySCC_PM25.rds and Source_Classification_Code.rds.

# The requirement for this plot is:
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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
onroadBalt <- subset(onroadNEI, fips == "24510")

#Summarise the data by year and sum the emissions
onroadBaltSum <- summarize(group_by(onroadBalt, year), sum(Emissions))
#coalSum$`sum(Emissions)` <- coalSum$`sum(Emissions)` / 1000

# Open the png graphics device to create the file
png(file = "Plot5.png")

#Build the plot
myPlot <- ggplot(onroadBaltSum, aes(x=year, y=`sum(Emissions)`)) 
myPlot <- myPlot + geom_line(linetype = 2) + geom_smooth(method = "lm", se = FALSE)
myPlot <- myPlot + scale_y_continuous(limit = c(0, 400))
myPlot <- myPlot + labs(y = "PM25 Emissions \n (tons)", 
                        x = "Year", 
                        title = " PM2.5 Emissons related to the \n On-Road sources in Baltimore \n (1999 - 2008)")

print(myPlot)

dev.off()
