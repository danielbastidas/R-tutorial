############ handling big data ###############
setwd('/home/danielbastidas/git-repo/R-tutorial')

install.packages("ff")
install.packages("biglm")

library(ff)
library(biglm)

# the file is not loaded into memory, instead a pointer is used to reference the file
irisff <- read.table.ffdf(
  file = "iris.csv",
  FUN = "read.csv"
)

class(irisff)

# inspect the column names
names(irisff)

# inspect the first few rows, though head can't be used with ff data frames
irisff[1:3, ]

model <- biglm(
  data = irisff,
  formula = Petal.Width ~ Petal.Length
)

summary(model)

# create a scatter plot. Notice the square brackets are required because we are handling only a portion of
# the data instead of the whole data as we are working with big data
plot(
  x = irisff$Petal.Length[],
  y = irisff$Petal.Width[],
  main = "Iris petal length vs width",
  xlab = "petal length (cm)",
  ylab = "petal width (cm)"
)

# to plot the line as we are using big data we can't use the function fit that we previously used. So we
# need to get the b from the line equation which is the intercept value displayed using the summary method
b <- summary(model)$mat[1,1]

# get the slope of the line equation. The second value in the coef seen in the summary of the model
m <- summary(model)$mat[2,1]

# now we can draw the regression line in the previous plot
lines(
  x = irisff$Petal.Length[],
  y = m*irisff$Petal.Length[]+b,
  col = "red",
  lwd = 3
)

# predict new values with the model
predict(
  object = model,
  newdata = data.frame(
    Petal.Length = c(2,5,7),
    Petal.Width = c(0,0,0))
  )
)