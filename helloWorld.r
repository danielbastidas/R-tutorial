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

myMatrix <- matrix(
  data = 1:10,
  nrow = 2,
  ncol = 5
)
myMatrix

multiDimensionArray <- array(
  data = 1:9,
  dim = c(2,2,3)
)
multiDimensionArray

# list can contain heterogeneous values, vector only allows homogeneous values
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

# get values from a subset of the data frame. Indicating which rows
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
