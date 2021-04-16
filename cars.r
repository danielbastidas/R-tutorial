setwd("/home/danielbastidas/git-repo/R-tutorial")

# read table allows you to read text files indicating the separator character
cars <- read.table(
  file = "cars.txt",
  header = TRUE,
  sep = "\t",
  quote = "\""
)

# peek of data
head(cars)

library(dplyr)

temp <- select(
  .data = cars,
  Transmission,
  Cylinders,
  Fuel.Economy
)

head(temp)

temp <- filter(
  .data = temp,
  Transmission == "Automatic"
)

head(temp)

# compute a new column in the data

temp <- mutate(
  .data = temp,
  Comsumption = Fuel.Economy * 0.425
)

head(temp)

# group data by column
temp <- group_by(
  .data = temp,
  Cylinders
)

head(temp)

# aggregate data based on groups
temp <- summarize(
  .data = temp,
  Avg.Comsumption = mean(Comsumption)
)

head(temp)

# sort the data
temp <- arrange(
  .data = temp,
  desc(Avg.Comsumption)
)

head(temp)

# convert temporary data to data frame
efficiency <- as.data.frame(temp)

print(efficiency)

# notice you can do all the same operations in kind of lambda expression way
efficiency2 <- cars %>%
  select(Transmission, Cylinders, Fuel.Economy) %>%
  filter(Transmission == "Automatic") %>%
  mutate(Comsumption = Fuel.Economy * 0.425) %>%
  group_by(Cylinders) %>%
  summarize(Avg.Comsumption = mean(Comsumption)) %>%
  arrange(desc(Avg.Comsumption)) %>%
  as.data.frame()

print(efficiency2)  

identical(efficiency, efficiency2)

# export the results to a file
write.csv(
  x = efficiency2,
  file = "fuel-efficiency.csv",
  row.names = FALSE
)

#################### applying descriptive statistics ####################

# create a frequency table
table(cars$Transmission)

# get the minimum value fro the data
min(cars$Fuel.Economy)

# get the maximum value fro the data
max(cars$Fuel.Economy)

# get the average value from some column in the data
mean(cars$Fuel.Economy)

# get the median value
median(cars$Fuel.Economy)

# get the quartiles
quantile(cars$Fuel.Economy)

# get the standard deviation
sd(cars$Fuel.Economy)

# sum all the values of a column
sum(cars$Fuel.Economy)

# get the correlation (how the values relate with each other). The result of the correlation can be read
# in the following way: correlation = -0.8494824 which means that there is a strong (near to -1) negative
# correlation. The fuel economy decreases while the number of cylinders increases. More cylinders, more 
# power, more fuel consumption
# look at the scatter plot that visualize the correlation between the number of cylinders and the fuel economy
cor(
  x = cars$Cylinders,
  y = cars$Fuel.Economy
)

summary(cars)

#################### visualizing data ####################

# install on of the visualization packages
install.packages("ggplot2")

# load the graphics library
library(ggplot2)

# create bar chart
ggplot(
  data = cars,
  aes(x = Transmission)) +
  geom_bar() +
  ggtitle("Count of cars by transmission type") +
  xlab("transmission type") +
  ylab("count of cars")
  
# create a histogram chart
ggplot(
  data = cars,
  aes(x = Fuel.Economy)) +
  geom_histogram( bins = 10) +
  ggtitle("Distribution of fuel economy") + 
  xlab("Fuel economy (mpg)") + 
  ylab("Count of cars")

# create a density plot
ggplot(
  data = cars,
  aes(x = Fuel.Economy)) +
  geom_density() +
  ggtitle("Distribution of fuel economy") + 
  xlab("Fuel economy (mpg)") + 
  ylab("Density")

# create a scatter plot to visualize correlation between variables. Note in the chart that we put the 
# predictor variable (the variable that we believe influence another variable) in the x axis
# We call outcome variable the variable in the y axis
# the correlation uses the straight line equation: y = m*x + b
# where m indicates how much y increases with each value of x
# and b is the value of y when x is zero
ggplot(
  data = cars,
  aes(x = Cylinders,
      y = Fuel.Economy)) +
  geom_point() + 
  ggtitle("Fuel economy by cilinders") +
  xlab("Number of cylinders") +
  ylab("Fuel economy (mpg)")
