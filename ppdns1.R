# 4/30/18
# studying population density
# starting with data from the world bank (https://data.worldbank.org/indicator/EN.POP.DNST?end=2016&locations=NL-GB-BD-ES-RU-AU&start=1961&view=map)

library(ggplot2)
library(reshape)

base <- read.csv("country_densities.csv", skip = 3)
base2 <- melt(base, id = c("Country.Name", "Country.Code", "Indicator.Name", "Indicator.Code"))
base2$variable <- as.numeric(substr(base2$variable, 2, 5))
colnames(base2)[5] <- "year"

rdr <- merge(data.frame(base2[base2$year %in% 1961, c(2, 6)]),
             data.frame(base2[base2$year %in% 2016, c(2, 6)]),
                        by = "Country.Code")
rdr$dff <- (rdr[,3]-rdr[,2])/rdr[,2]
rdr <- rdr[order(-rdr$dff),]

base2$Country.Code <- factor(base2$Country.Code, ordered = T, levels = rdr$Country.Code)

a <- ggplot(base2, aes(x = year, y = value)) + 
  geom_line() + 
  theme(strip.background = element_blank(),
        strip.text.x = element_blank()) +
  facet_wrap(~Country.Code,
             ncol = 8,
             scales = "free_y")
# a

png("/var/www/html/FileShare/ppdns/pops1.png", width = 1000, height = 1000)
plot(a)
dev.off()

# testing testing















































