# This is the R Script for creating the Plot1 graph for the Exploratory Data Analysis
# Peer Assesment 2.
# The data is contained in two files summarySCC_PM25.rds and Source_Classification_Code.rds.
# The requirement for this plot is:Have total emissions from PM2.5 decreased in the 
# United States from 1999 to 2008? Using the base plotting system, make a plot 
# showing the total PM2.5 emission from all sources for each of the years 1999, 
# 2002, 2005, and 2008.


setwd("~/r-learning/Explorartory Data Analysis - Assesment 2")

#Read in the data file from the current working directory into the data frame NEI
#NEI <- readRDS("summarySCC_PM25.rds")

annualEmisions <- tapply(NEI$Emissions, NEI$year, sum)
annualEmisions <- annualEmisions / 1000000


# Open the png graphics device to create the file
png(file = "Plot1.png")
#Set the margins on the left hand side for the two line label
par(mar = c(5,6,4,2))
# Build the plot
barplot(annualEmisions, main = "Total PM2.5 Emisions per Year", 
        col=c("blue","lightblue", "lavender", "lavenderblush"),
        ylim=c(0,1.1*max(annualEmisions)), 
        ylab = "PM2.5 Emissions \n (million tons)",
        xlab = "Year")
dev.off()
