NEI <- readRDS("summarySCC_PM25.rds")       #read file from your working directory

library(dplyr)

part1 <- NEI %>%                            #using the "dplyr" package to get a data frame
  select(SCC, Emissions, year) %>%          #of the sum of Emissions over all SCC per year
  group_by(year) %>% 
  summarise(tot_Em = sum(Emissions))

par(mfrow = c(1,1))

plot(part1$year, part1$tot_Em,
     type="l",                              #type = line
     xlab="Year",                           #x-axis label
     ylab="Total Emissions")                #y-axis label

dev.copy(png, file = "plot1.png")
dev.off()