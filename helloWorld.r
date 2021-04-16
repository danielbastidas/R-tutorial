x <- "Hello World!"
print(x)
x
boolean <- TRUE
intValue <- 400L
decimalValue <- 10.50
strValue <- "a string value"
dateValue <- as.Date("02-04-2021")
dateValue
boolean
decimalValue
intValue
strValue
f <- function(x) {x+2}
f(1)

myVector <- c(1,2,3,4)
myVector 

# creating also a vector as a sequence
mySequence <- 1:10
mySequence

# matrix as well as vectors only allow contains on type of data. data frames is the 2 dimension data 
# structure that allows different types of data. It is the counterpart of list in one dimension structures
myMatrix <- matrix(
  data = 1:10,
  nrow = 2,
  ncol = 5
)
myMatrix

# arrays support more than two dimensions. For instance the following variable contains a three dimension variable
# which translates to an array of 3 positions where on each position there is a 2 X 2 matrix

multiDimensionArray <- array(
  data = 1:9,
  dim = c(2,2,3)
)
multiDimensionArray

# list can contain heterogeneous values, vector only allows homogeneous values. lists supports different data types
myList <- list(FALSE, 100L, 3.1645, "abc")
myList

categories <- c("Male", "Female", "Male", "Male", "Female")
factor <- factor(categories)
factor
levels(factor)
unclass(factor)

myDataFrame <- data.frame(
  Name = c("Cat", "Dog", "Cow", "Pig"),
  HowMany = c(5,10,15,20),
  IsPet = c (TRUE, TRUE, FALSE, FALSE)
)
myDataFrame

# get the value by row (1) and column (2) from the data frame
myDataFrame[1, 2]

# get the value of an entire row
myDataFrame[2, ]

# get the value of an entire column
myDataFrame[, 3]

# get the value by column name
myDataFrame[["Name"]]

# get the value by column name shorter syntax. This method is preferred
myDataFrame$Name

# get values from a subset of the data frame. Indicating which rows. Sub setting subsetting
myDataFrame[c(1,4), ]

# get values from a subset indicating a sequence 
myDataFrame[1:3, ]

# get values indicating which rows we want to return, in the following example only the last to rows
myDataFrame[c(FALSE,FALSE,TRUE,TRUE), ]

# get values specifying a condition with the data
myDataFrame[myDataFrame$IsPet == TRUE, ]

# get values specifying a condition with the data
myDataFrame[myDataFrame$HowMany > 10,  ]

# get values specifying a condition with the data. Using an in condition
myDataFrame[myDataFrame$Name %in% c("Cat","Cow"),  ]

# R is a vectorized language, so all variables are treated as vectors
1+2

# adding vectors. c is the concatenation method in R
c(10, 20, 30) + c(1,2,3)

# named vs ordered arguments
# named matrix
matrix1 <- matrix(data = 1:6, nrow = 2, ncol = 3)
# argument ordered matrix
matrix2 <- matrix(1:6,2,3)
# even comparisons are vectorized. R is a vectorized language
matrix1 == matrix2
# checking if two vectors are exactly identical
identical(matrix1, matrix2)

# installing packages
install.packages("dplyr")

# loading packages in memory
library("dplyr")

# viewing help. Put closing question mark before the command you want help
?data.frame
?c
?array

typeof('1')
typeof(1)
typeof(1L)
typeof(1i)
typeof(TRUE)
typeof(charToRaw('1'))

# notice how all the values become the same type of the first element in the vector
allChar <- c('1', 1, 1L, 1i, TRUE, charToRaw('1'))
allChar
typeof(allChar)

allDifferent <- list('1', 1, 1L, 1i, TRUE, charToRaw('1'))
allDifferent
typeof(allDifferent)

# convert a vector into a string
paste(allChar, collapse = '-')

# casting variables example
x <- 1
boolValue <- as.logical(x)
boolValue
x <- 0
boolValue <- as.logical(x)
boolValue

# ternary operator
print(paste('it is', ifelse(F, 'false','true')))

# for statement
for (i in 1:5) print(i)

# while statement
i <- 0
while (i<5) {
  i <- i+1
  print(i)
}

# skip an iteration using next
i <- 0
while (i<5) {
  i <- i+1
  if (i == 3)
    next
  print(i)
}

# stop iterating using break
i <- 1
repeat {
  print(i)
  if (i>4) break
  i <- i+1
}

# creating functions
scaleGrades <- function(grades) {
  
  return (sum(grades)/length(grades))
}

scaleGrades

# invoking a function
scaleGrades(c(7,7,6,8,5,6))

# use the evaluate function to execute code written as a string
eval(parse(text = "c(1,5)+c(2,6)"))

# create a matrix from two vectors
v1 <- c(1,2,3)
v2 <- c(4,5,6)
# create a matrix using rows. Using the number of vectors as rows
m1 <- rbind(v1,v2)
m1
# create a matrix using columns. Using the number of vectors as columns
m2 <- cbind(v1,v2)
m2

# write matrix to file
write.table(m2, 
            'out.csv',
            sep = ',',
            quote = TRUE,
            col.names = FALSE,
            row.names = FALSE)

# read the file
m3 <- read.csv('out.csv', header = FALSE)
# with the following command we know the data was loaded as a data frame but we know that all values
# are the same type so we cast the result as a matrix
m3 <- as.matrix(m3)
class(m3)

# get the names of the columns
names(m3)

# changing column names
names(m3)[2] <- "V3"

# transpose the matrix. Change rows by columns
m4 <- t(m3)
m4

# removing names from the rows
row.names(m4)<-NULL
m4

# downloading files from internet using R
install.packages('RCurl')
library(RCurl)
url<-'https://data.cityofnewyork.us/api/views/bg38-veix/rows.csv?accessType=DOWNLOAD'
# fileText contains the text of the file so thats the reason that I'm writing the text to a file and then
# loading it
fileText <- getURL(url, .opts=curlOptions(followlocation=TRUE))
write(fileText, 'downloaded.csv')
loadFile <- read.csv('downloaded.csv', header = TRUE)
View(loadFile)

# do it all in one line
data <- read.csv(text = getURL(url, .opts=curlOptions(followlocation=TRUE)), header = TRUE)
head(data)

# create a data frame from vectors
df <- as.data.frame(
  rbind(
    c('A1','B1','C1'),
    c('A2','B2','C2'),
    c('A3','B3','C3'),
    c('A4','B4','C4')
  ), stringsAsFactors = FALSE
)

# assing names to rows and columns
rownames(df)<-c(1,2,3,4)
colnames(df)<-c('A','B','C')

df

# how to get more than one column in a data frame
df[,c(1,3)]

# get columns by name
df$B

# get also by column name
df["A"]
# notice the information is returned as a data frame
class(df["A"])

df[["A"]]
# notice the information is returned as a character
class(df[["A"]])

# return all the data except an specific column, in this case the first column
df[,-1]

# add a column dynamically to the data frame
df$D <- c('D1','D2','D3','D4')
df

# and also remove a column dynamically
df$D <- NULL
df

# you can also bind data frames
df1 <- as.data.frame(
  rbind(
    c('A1','B1','C1'),
    c('A2','B2','C2'),
    c('A3','B3','C3') 
  )
)
df2 <- as.data.frame(
  rbind(
    c('X1','Y1','Z1'),
    c('X2','Y2','Z2'),
    c('X3','Y3','Z3') 
  )
)

print(rbind(df1, df2))

# we can also merge data frames by columns instead of rows
df1$ID <- df1[,1]
df2$ID <- df1[,1]
df1
mergedDataFrame <- merge(df1, df2, by = "ID")
print(mergedDataFrame)

# fucking cool! You can also treat your data frames as if they were tables, because internally they are 
# tables, R is using sql lite to store the data frames
install.packages('sqldf')
library(sqldf)

sqldf("select * from mergedDataFrame where ID='A2'")

# of course! you can also use joins
sqldf("select * from df1 join df2 on df2.id=df1.id")

# how to see the default graphics implemented by default on R
demo()

# generate random values using the normal distribution
x <- stats::rnorm(50)
x

opar <- par(bg="white")

# how to test a plot layer by layer. ann indicates no title and no label for the axis. Type n indicates
# do not display points in the graphic yet
plot(x, ann = FALSE, type = "n")

# draw an horizontal line
abline(h=0, col= gray(0.90))

# draw lines connecting the dots in the graphic
lines(x, col ="green4", lty= "dotted")

# create a circle at each data point in the graphic
points(x, bg="limegreen", pch=21)

title(main="graphic layer by layer",
      xlab = "X label title",
      col.main = "blue",
      col.lab = gray(0.8),
      cex.main = 1.2,
      cex.lab=1.0,
      font.main=4,
      font.lab=3)

install.packages('lattice')
library(lattice)

# the lattice graphics package is useful when you have to show multi-varied (which means a graphic for 
# every category in the data) data or something like that
# that what I know until now. Notice the use of the 'Y ~ X' character, is the same as saying y,x
xyplot(Sepal.Width ~ Sepal.Length | Species, iris)

# how to show multi-varied graphics with ggplot. ggplot only works with data frames, other libraries work
# with different data structures
# Although I should use ggvis instead of ggplot because the former is the evolution of ggplot
# ggvis allows you to create interactive graphics, for instance using sliders to adjust the values of the 
# graphics
library(ggplot2)
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point() + facet_wrap(~ Species, nrow = 2)

install.packages('ggvis')
library(ggvis)

# adjust the values of the graphics using ggvis
ggvis(diamonds, ~x, ~y) %>% layer_points(size:= input_slider(10,300, value=15))

# example of a shiny app
library(shiny)
runExample("01_hello", port = 8080)

# more examples of how use SQL from R
install.packages('RSQLite')
library(RSQLite)

con <- dbConnect(dbDriver("SQLite"), dbname=":memory:")

rs <- dbSendQuery(con, "create table crew_members (id number, user_name string, first_name string, 
                  last_name string, birth_data Date)")
dbClearResult(rs)

dbSendQuery(con, "insert into crew_members values (1, 'notbadMal', 'Malcom', 'Reynolds', '2468-09-20')")
dbSendQuery(con, "insert into crew_members values (2, 'warriorwoman2511', 'Zoe', 'Washburne', '2484-02-15')")
dbSendQuery(con, "insert into crew_members values (3, 'veras-man', 'Jayne', 'Cobb', NULL)")

rs <- dbSendQuery(con, "select * from crew_members")
fetch(rs)
dbClearResult(rs)

# count missing values in a data frame
sum(is.na(theDataFrame))

# exclude observations with missing values from the data frame
theDataFrame <- na.omit(theDataFrame)

# substitute a string on a column. In the following example replace the desire text with empty string
theDataFrame$theColumn <- sub(" the text we want to replace", "", theDataFrame$theColumn)

# replace several values in a string with other string
currencyString <- "$100.5k"
currencyString2 <- "$1000.89M"

currencyWithoutSymbols <- as.numeric(gsub("[$|k|M]","", currencyString))
print(currencyWithoutSymbols)
currencyWithoutSymbols2 <- gsub("[$|k|M]","", currencyString2)
print(currencyWithoutSymbols2)

# scale values to millions
currencyScaled <- ifelse(grepl("k", currencyString), (as.numeric(currencyWithoutSymbols)*0.001), as.numeric(currencyWithoutSymbols))
currencyScaled

currencyScaled2 <- ifelse(grepl("M", currencyString2), as.numeric(currencyWithoutSymbols2), as.numeric(currencyWithoutSymbols2)*1000)
currencyScaled2

# the sapply function allows you to execute a function to all elements in a collection. For example:
# df$valueToAssing <- sapply(df$functionArgumentValue, functionToExecute)
# the function sapply returns a vector

# descriptive statistics refer for instance to summarize information of column
# the first quartile is the value that cuts off 25% of the values
# the median is the value that separates the lower half from the upper half or second quantile
# the mean is the average of all the values
# the third quartile is the value that cuts off 75% of the values

# qualitative variables are considered categorical variables. Also called nominal variables
# quantitative variables contains numeric values
# the mode refers to the most frequently value in the data
# the variance is a measure of how far the values are spread out
# the standard deviation is the square root of the variance
# the shape of the data means:
# skewness is a measure of the asymmetry of the distribution of values
# kurtosis is a measure of how sharply peaked or relatively flat the distribution of values are

# quantitative bi-variate analysis 
# can be performed with covariance and correlation 
# calculate frequency of a value in data set use the function table
library(ggmap)
data("crime")
table(crime$location)

# getting the mode of the data. The most repeated value in the data. The output indicate that apartment is the
# most frequent value and that it appears in the fifth position/index of the frequency table
which.max(table(crime$location))

# getting the quantiles
quantile(crime$hour)

# get a specific quantile value
quantile(crime$hour, 0.25)
quantile(crime$hour, 0.85)

# difference between third and first quantile values
IQR(crime$hour)

# find the spread of the data. The smaller the number the smaller the spread and the other way around
var(crime$hour)
sd(crime$hour)

# find the skewness and kurtosis
library(moments)

# if the skewness is zero then the distribution of data is perfectly symmetric. If the value is negative then
# the distribution of data is negatively skewed that is the tail is skewed to the left
# If the skewness is positive then the distribution of data is positive skewed that is the tail is skewed to the right
# In addition the larger the value the greater the skewness is
skewness(crime$hour)

# the kurtosis returns a value that is either greater than, less than or equal to 3
# A value of 3 means the shape of the peak of the distribution is the normal distribution
# A value less than 3 means the peak is flatter than the normal distribution
# A value greater than 3 means the peak is steeper than the normal distribution
kurtosis(crime$hour)

# to display both values graphically lets create a plot. Plot gaussian bell visualize gaussian bell
plot(density(crime$hour))

# bi-variate qualitative analysis. Create a contingency table or frequencies between two variables and its intersection
table(crime$offense, crime$location)

# bi-variate analysis of two quantitative values
# covariance that is the degree to which two variables vary with one another
# If the covariance is positive it means that larger values of the first value correspond to larger values of the second
# variable in general
# If the value is negative then the two variables would inversely vary with one another that is larger values of the first
# variable would correspond to smaller values of the second variable in general
cov(diamonds$depth, diamonds$price)
cov(diamonds$table, diamonds$price)

# if you need to compare two covariance values to determine which value correlates more strongly with the variable 
# been evaluated (in the previous example the diamond price) in order to compare the correlation in an apples apples way
# we need to use the correlation coefficient
# Correlation coefficient is covariance on a standardized scale
# For example -1 is a total negative correlation 
# 0 is no correlation 
# +1 is a total positive correlation
# in the following example we can say that diamonds price correlates more with diamond table than with diamond depth
# but the value 0.1271339 is small so it is not suitable to predict the diamond price
cor(diamonds$depth, diamonds$price)
cor(diamonds$table, diamonds$price)

# bi-variate analysis for both qualitative and quantitative variable
# tapply function allows to execute a function on each value of our data set but also allows to group those values by a
# factor
# Notice the first argument is the quantitative value, the second argument is the value we want to group and third 
# argument is the function
tapply(diamonds$price, diamonds$cut, mean)

# the summary method provides statistics for both qualitative and quantitatives variables
summary(diamonds)
summary(crime)
