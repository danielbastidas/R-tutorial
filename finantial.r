library(quantmod)

portfolio <- c('AAPL', 'GOOG', 'ORCL')
loadSymbols(portfolio)
barChart(AAPL)
barChart(GOOG)
barChart(ORCL)

# only get the data for a certain time range
AAPL['2020-01-01::2020-12-31']
barChart(ORCL['2020-01-01::2020-12-31'])
candleChart(ORCL['2020-01-01::2020-12-31'])

library(lubridate)

# find which day is better to buy apple stocks
appleClosingPrice <- as.data.frame(Cl(AAPL))
head(appleClosingPrice)
View(appleClosingPrice)
rownames(appleClosingPrice)
colnames(appleClosingPrice)
appleClosingPrice$Day <- as.character(wday(rownames(appleClosingPrice), label = TRUE))
head(appleClosingPrice)

library(ggplot2)
ggplot(appleClosingPrice, aes(x=Day)) + geom_histogram(stat = 'count')
