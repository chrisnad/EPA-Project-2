NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

keep <- SCC$SCC[grepl("Coal", SCC$Short.Name)]
Coal_Comb <- NEI[NEI$SCC %in% keep, ]     #keep only the rows that relates to Coal
                                          #Combustion
library(dplyr)
library(ggplot2)

part4 <- Coal_Comb %>%                    #using the "dplyr" package to get a data frame
  select(Emissions, year) %>%             #of the sum of Emissions over all SCC per year
  group_by(year) %>% 
  summarise(tot_Em = sum(Emissions))

g <- ggplot(part4, aes(year, tot_Em))
p <- g + 
  geom_line(size = 1) + 
  labs(x = "Year", y = "Emissions from Coal Combustion-related sources")

ggsave(filename = "plot4.png", plot = p)