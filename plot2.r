NEI <- readRDS("summarySCC_PM25.rds")       #read file from your working directory

Bal_City <- NEI[NEI$fips == 24510, ]        #keep only the rows that corresponds to
                                            #Baltimore City
library(dplyr)

part2 <- Bal_City %>%                       #using the "dplyr" package to get a data frame
  select(SCC, Emissions, year) %>%          #of the sum of Emissions over all SCC per year
  group_by(year) %>% 
  summarise(tot_Em = sum(Emissions))

par(mfrow = c(1,1))

plot(part2$year, part2$tot_Em,
     type="l",                              #type = line
     xlab="Year",                           #x-axis label
     ylab="Emissions in Baltimore City")    #y-axis label

dev.copy(png, file = "plot2.png")
dev.off()