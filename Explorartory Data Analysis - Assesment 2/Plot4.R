# This is the R Script for creating the Plot4 graph for the Exploratory Data Analysis
# Peer Assesment 2.
# The data is contained in two files summarySCC_PM25.rds and Source_Classification_Code.rds.

# The requirement for this plot is:
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

setwd("~/r-learning/Explorartory Data Analysis - Assesment 2")
library(dplyr)
library(ggplot2)

#Read in the data file from the current working directory into the data frame NEI
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#Subset the data from SCC to only those that contain the word coal or Coal in the EI.Sector variable
coalSCC <- subset(SCC, grepl("[Cc]oal", EI.Sector), select = SCC)
#Find all the rows that have the SCC codes in relating to coal
coalNEI <- subset(NEI, SCC %in% coalSCC$SCC)
#Summarise the data by year and sum the emissions
coalSum <- summarize(group_by(coalNEI, year), sum(Emissions))
coalSum$`sum(Emissions)` <- coalSum$`sum(Emissions)` / 1000

# Open the png graphics device to create the file
png(file = "Plot4.png")

#Build the plot
myPlot <- ggplot(coalSum, aes(x=year, y=`sum(Emissions)`)) 
myPlot <- myPlot + geom_line(linetype = 2) + geom_smooth(method = "lm", se = FALSE)
myPlot <- myPlot + scale_y_continuous(limit = c(0, 700))
myPlot <- myPlot + labs(y = "PM25 Emissions \n (1000 tons)", 
                        x = "Year", 
                        title = " PM2.5 Emissons related to the use of Coal \n (1999 - 2008)")

print(myPlot)

dev.off()



