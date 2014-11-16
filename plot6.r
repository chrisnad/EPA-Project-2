NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

keep <- SCC$SCC[grepl("Vehicle", SCC$Short.Name)]
Mot_Vehicle <- NEI[NEI$SCC %in% keep, ]     #keep only the rows that relates to Vehicles
                                            #Combustion

data <- Mot_Vehicle[Mot_Vehicle$fips %in% c("24510", "06037"), ]
                                            #from Mot_Vehicle keep the data from Baltimore
                                            #and L.A.
data$fips[data$fips == "06037"] <- "Los Angeles County, California"
data$fips[data$fips == "24510"] <- "Baltimore City"

library(dplyr)
library(ggplot2)

part6 <- data %>%                    #using the "dplyr" package to get a data frame
  select(fips, Emissions, year) %>%               #of the sum of Emissions over all SCC per year
  group_by(fips, year) %>% 
  summarise(tot_Em = sum(Emissions))

g <- ggplot(part6, aes(year, tot_Em))
p <- g + 
  geom_line(aes(color = fips), size = 1) + 
  labs(x = "Year", y = "Emissions from motor vehicle sources")

ggsave(filename = "plot6.png", plot = p)