# this example shows how to see which data sets are contained in a package

# it is recommended to use require in functions. So the rule of thumb is to use the library method
require('ggplot2')
data(package='ggplot2')
help(diamonds)
diamonds
# the view function allows you to see the whole data set
View(diamonds)

# the summary command allows you to see statistics about your data set like min, max, mean, median, quartiles
# for every column in the data set
summary(diamonds)

# select/filter/query only a subset of your data using several columns. Using logical operators
subset(diamonds, cut %in% 'Fair' & color %in% 'J' & price < 1000)

# select/filter/query only a subset of your data using several columns. Using logical operators. But also
# allows you to indicate which data needs to be returned
subset(diamonds, cut %in% 'Fair' & color %in% 'J' & price < 1000)$price

# calculate the average using the result of a subset
mean(subset(diamonds, cut %in% 'Fair' & color %in% 'J' & price < 1000)$price)

# to know the size of the data set. The first value is the rows number and the second value is the columns 
# number
dim(diamonds)

g <- ggplot(diamonds, aes(x = table, y = price))

g <- g + geom_point(aes(color=depth))

g

# indicates that in the graph are numbers with a lot of zeroes, so we want to work with up to 20 zeroes
options (scipen = 20)

library(scales)

g <- g + scale_y_continuous(labels = comma)
g

require(mgcv)

g + geom_smooth(color='yellow')

g + geom_smooth(method = 'lm',color='yellow')

g <- g + labs(title = "test graphic",
              x="X axis label",
              y="Y axis label"
              )
g
