# This is the R Script for creating the Plot3 graph for the Exploratory Data Analysis
# Peer Assesment 2.
# The data is contained in two files summarySCC_PM25.rds and Source_Classification_Code.rds.

# The requirement for this plot is:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

setwd("~/r-learning/Explorartory Data Analysis - Assesment 2")
library(dplyr)
library(ggplot2)

#Read in the data file from the current working directory into the data frame NEI
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#Subset the data using dplyr filter() function
baltimoreData <- filter(NEI, fips =="24510")
#Create the summary data for Baltimore using 
baltimoreType <- as.data.frame(tapply(baltimoreData$Emissions, 
                                      list(baltimoreData$type, baltimoreData$year), sum))

baltimoreType <- cbind(type = as.factor(rownames(baltimoreType)), baltimoreType)
baltimoreTypeMelt <- melt(baltimoreType, id = "type")


# Open the png graphics device to create the file
png(file = "Plot3.png")
# Build the plot using ggplot.
# The trend is shown using smoothing and the data is shown with dotted lines. I think it shows the trends better
# and that the baddy is point emissions.
myPlot <- ggplot(baltimoreTypeMelt, aes(x=variable, y=value, group=type, color = type)) 
myPlot <- myPlot + geom_line(linetype = 2) + geom_smooth(method = "lm", se = FALSE) 
myPlot <- myPlot + labs(y = "PM25 Emissions \n (tons)", 
                        x = "Year", 
                        title = " PM2.5 Emissons in Blatimore by Type \n (1999 - 2008)")

print(myPlot)

dev.off()