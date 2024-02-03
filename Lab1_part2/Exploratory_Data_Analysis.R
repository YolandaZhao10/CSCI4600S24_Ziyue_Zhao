library(ggplot2)
library(magrittr)
library(dplyr) 
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat),
                 binwidth = 0.5)

smaller <- diamonds %>% filter(carat < 3)
ggplot(data = smaller, mapping = aes(x = carat)) + 
geom_histogram(binwidth = 0.1)

ggplot(data = smaller, mapping = aes(x = carat)) + 
  geom_freqpoly(binwidth = 0.1)#displaying the counts with bars, uses lines instead.

ggplot(data = smaller, mapping = aes(x = carat, color = cut)) + 
  geom_freqpoly(binwidth = 0.1)

ggplot(data = smaller, mapping = aes(x = carat)) + 
  geom_histogram(binwidth = 0.01)

ggplot(data = faithful, mapping = aes(x = eruptions)) + 
  geom_histogram(binwidth = 0.25)

ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y),binwidth = 0.5)

ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y),binwidth = 0.5) + 
  coord_cartesian(ylim = c(0,50))

unusual <- diamonds %>%
  filter(y < 3 | y > 20) %>%
  arrange(y)
unusual



##Explore the distribution of each of the x, y, and z variables in diamonds. 

summary(diamonds)
data <- data.frame(c(1:length(diamonds$x)),diamonds$x)
colnames(data) <- c("index","x")
ggplot(data = data, mapping = aes(x = x)) + 
  geom_histogram(binwidth = 0.1)
ggplot(data = data, mapping = aes(x = x)) + 
  geom_histogram(binwidth = 0.01)


data <- data.frame(c(1:length(diamonds$y)),diamonds$y)
colnames(data) <- c("index","y")
ggplot(data = data, mapping = aes(x = y)) + 
  geom_histogram(binwidth = 0.1)
ggplot(data = data, mapping = aes(x = y)) + 
  geom_histogram(binwidth = 0.01)



data <- data.frame(c(1:length(diamonds$z)),diamonds$z)
colnames(data) <- c("index","z")
ggplot(data = data, mapping = aes(x = z)) + 
  geom_histogram(binwidth = 0.1)
ggplot(data = data, mapping = aes(x = z)) + 
  geom_histogram(binwidth = 0.01)

# x ==> length in mm
# y ==> width in mm
# z ==> depth in mm


## Explore the distribution of price.
summary(diamonds$price)
frequency_table <- table(as.vector(diamonds$price))
most_common <- as.numeric(names(frequency_table[which.max(frequency_table)]))
most_common
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_histogram(binwidth = 100) 
# unusual: we have a gap during 250
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_histogram(binwidth = 50) 
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_histogram(binwidth = 10) 
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_histogram(binwidth = 1) 
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_histogram(binwidth = 0.1) 


dim(diamonds)
tolerance <- 0.0001
num <- filter(diamonds, abs(carat - 0.99) < tolerance)
dim(num)
# 23 diamonds are 0.99 carat
num <- diamonds %>% filter(carat == 1)
dim(num)
# 1558 diamonds are 1 carat
#1. Perceived Value: Diamonds at exact carat weights (like 1 carat) are highly prized for their perceived prestige and milestone value.
#2. Psychological Pricing: Retailers prefer whole numbers for pricing, making 1 carat more desirable than 0.99 due to consumer perception.
#3. Market Demand: There's stronger demand for 1-carat diamonds, driven by consumer preferences and marketing.
#4. Cutting Practices: Diamond cutters aim for full carats to maximize weight retention and value, making 1-carat diamonds more common.
#5. Pricing Structure: Prices jump significantly at full carat points, making it economically favorable to produce 1-carat diamonds over 0.99 carat.
#6. Inventory Strategy: Retailers stock more of what sells best, leading to a higher availability of 1-carat diamonds compared to 0.99 carat.


ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y),binwidth = 0.5) + 
  coord_cartesian(ylim = c(0,50),xlim = c(0,1000))
# What happens if you leave binwidth unset? graph will too large, we could not see the detail
# We can get more detail from it.

y <- 10
diamonds2 <- diamonds %>% filter(between(y, 3, 20))
diamonds2 <- diamonds %>% mutate(y = ifelse(y < 3 | y > 20, NA, y))
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + geom_point()
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + geom_point(na.rm = TRUE)

#nycflights13::flights %>% mutate( cancelled =
#                                    is.na(dep_time), sched_hour =
#                                    sched_dep_time %/% 100, sched_min =
#                                    sched_dep_time %% 100, sched_dep_time =
#                                    sched_hour + sched_min / 60 ) %>%
#  ggplot(mapping = aes(sched_dep_time)) +
#  geom_freqpoly( mapping = aes(color =
#                                 cancelled), binwidth = 1/4 )
