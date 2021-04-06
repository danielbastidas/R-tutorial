# Predicting with machine learning

# we will use the decision tree algorithm
install.packages('tree')
install.packages('RColorBrewer')
# the following package is required by the caret package
install.packages('e1071', dependencies=TRUE)
# caret stands for classification and regression training
install.packages('caret')

library(tree)
library(RColorBrewer)
library(caret)
library(e1071)

# load the iris data
data(iris)

# set a seed to make randomness reproducible
set.seed(42)

# randomly sample 100 of 150 row indexes. The data contains 150 records. We are splitting the data for
# training and validation. 2 third parts (100 records) for training and the remaining 50 records for 
# validation
indexes <- sample(
  x=1:150,
  size = 100
)

print(indexes)

# create a training set from indexes
train <- iris[indexes, ]

# create the test set from the remaining indexes. Notice the minus sign indicates that only pick the records
# that are not in indexes
test <- iris[-indexes, ]

# create a decision tree model. Notice the . character tells the formula to use all other variables in the
# data set. We could have got the same result using this line: formula = Species ~ Petal.Length + Petal.Width
# + Sepal.Length + Sepal.Width
model <- tree(
  formula = Species ~ Petal.Length + Petal.Width,
  data = train
)

# inspect the model
summary(model)

# visualize the decision tree model
plot(model)
text(model)

# create a color palette. We are using 3 because we have 3 species
palette <- brewer.pal(3, "Set2")

# create a scatter plot colored by species
plot(
  x=iris$Petal.Length,
  y=iris$Petal.Width,
  pch=19,
  col=palette[as.numeric(iris$Species)],
  main = "Iris petal length vs width",
  xlab = "petal length (cm)",
  ylab = "petal width (cm)"
)

# plot the decision boundaries in the previous plot
partition.tree(
  tree = model,
  label = "Species",
  add = TRUE
)

# predict with the model. Notice that we are using the test set to validate our model. The type argument
# indicates that it is classification
predictions <- predict(
  object = model,
  newdata = test,
  type = "class"
)

# create a confusion matrix (validates the prediction model). Notice x axis contains the predictions and y 
# axis contains the real data
# the results can be read in the following way. All 13 setosa flowers were predicted correctly. 16 
# versicolor flowers were predicted appropriately and 1 was predicted erroneously (it is a versicolor 
# but was predicted as a virginica). 20 virginica flowers
# were predicted correctly.
table(
  x = predictions,
  y = test$Species
)

# another way to evaluate the prediction results. The following function comes from caret package and the 
# e1071 package
confusionMatrix(
  data = predictions,
  reference = test$Species
)

setwd("/home/danielbastidas/git-repo/R-tutorial")

# save the tree model so it can be used later
save(model, file = "Tree.RData")
