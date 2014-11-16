NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

keep <- SCC$SCC[grepl("Vehicle", SCC$Short.Name)]
Mot_Vehicle <- NEI[NEI$SCC %in% keep, ]     #keep only the rows that relates to Vehicles
                                            #Combustion
library(dplyr)
library(ggplot2)

part5 <- Mot_Vehicle %>%                    #using the "dplyr" package to get a data frame
  select(Emissions, year) %>%               #of the sum of Emissions over all SCC per year
  group_by(year) %>% 
  summarise(tot_Em = sum(Emissions))

g <- ggplot(part5, aes(year, tot_Em))
p <- g + 
  geom_line(size = 1) + 
  labs(x = "Year", y = "Emissions from motor vehicle sources")

ggsave(filename = "plot5.png", plot = p)