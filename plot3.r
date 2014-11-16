NEI <- readRDS("summarySCC_PM25.rds")       #read file from your working directory

Bal_City <- NEI[NEI$fips == 24510, ]        #keep only the rows that corresponds to
                                            #Baltimore City
library(dplyr)
library(ggplot2)

part3 <- Bal_City %>%                       #using the "dplyr" package to get a data frame
  select(Emissions, type, year) %>%         #of the sum of Emissions over all SCC per year
  group_by(type, year) %>% 
  summarise(tot_Em = sum(Emissions))

g <- ggplot(part3, aes(year, tot_Em))
p <- g + 
  geom_line(aes(color = type), size = 1) + 
  labs(x = "Year", y = "Emissions in Baltimore City")

ggsave(filename = "plot3.png", plot = p)