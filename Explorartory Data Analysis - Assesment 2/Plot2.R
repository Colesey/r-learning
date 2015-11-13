# This is the R Script for creating the Plot2 graph for the Exploratory Data Analysis
# Peer Assesment 2.
# The data is contained in two files summarySCC_PM25.rds and Source_Classification_Code.rds.

# The requirement for this plot is:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

setwd("~/r-learning/Explorartory Data Analysis - Assesment 2")
library(dplyr)
#Read in the data file from the current working directory into the data frame NEI
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#Subset the data using dplyr filter() function
baltimoreData <- filter(NEI, fips =="24510")
#Create the summary data for Baltimore using 
baltimoreSum <- summarize(group_by(baltimoreData, year), sum(Emissions))

# Open the png graphics device to create the file
#png(file = "Plot2.png")
#Set the margins on the left hand side for the two line label
par(mar = c(5,6,4,2))
# Build the plot
plot(baltimoreSum, main = "Total PM2.5 Emisions per Year \n for Baltimore", 
        type ="l",
        col= "blue",
        ylim=c(0,1.1*max(baltimoreSum)),
        ylab = "PM2.5 Emissions \n (tons)",
        xlab = "Year"
     )

#dev.off()