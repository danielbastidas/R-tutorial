# load data that came installed with R
data("iris")

head(iris)

# plot the data
plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width,
  main = "Iris petal length vs width",
  xlab = "Petal length (cm)",
  ylab = "Petal width (cm)"
)

# create a linear regression model
model <- lm(
  data = iris,
  formula = Petal.Width ~ Petal.Length
)

summary(model)

# draw a regression line in our previous plot
# lwd indicates line width
lines(
  x = iris$Petal.Length,
  y = model$fitted,
  col = "red",
  lwd = 3
)

# get correlation coefficient (how the petal length and width are related to each other)
# the result 0.9628654 indicates there is a strong good correlation between both values, which means
# that the iris petal length influence the iris petal width
cor(
  x = iris$Petal.Length,
  y = iris$Petal.Width
)

# predict new values from the model. Predict new iris petal width values based on new (not in the data)
# iris petal length
predict(
  object = model,
  newdata = data.frame(Petal.Length = c(2,5,7)))

write.csv(
  iris,
  file = "iris.csv"
)
