# using the base plot system
df <- data.frame(
  Name = c("a","b","c"),
  Value = c(1,2,3)
)
print(df)

# plot the data frame using the default parameters
plot(df)

# plot using default parameter order
plot(df$Name, df$Value)

# plot using named parameters
plot(
  x = df$Name,
  y = df$Value
)

# create a bar chart
barplot(
  names = df$Name,
  height = df$Value,
  col = "skyblue",
  main = "Hello World",
  xlab = "Name",
  ylab = "Value"
)

# view the help files
?plot
?barplot
?par

# plot using the lattice package
library(lattice)

# plot with defaults
dotplot(
  x = Value ~ Name,
  data = df
)

# plot with parameters
dotplot(
  x = Value ~ Name,
  data = df,
  main = "Hello World",
  xlab = "Name",
  ylab = "Value"
)

# create a bar chart using lattice
barchart(
  x = Value ~ Name,
  data = df,
  col = "skyblue",
  main = "Hello World",
  xlab = "Name",
  ylab = "Value"
)

# view the help files
?barchart
?formula

# plot using ggplot2
library(ggplot2)
ggplot(
  data = df,
  # aesthetics describe how variables in the data map to visual representation
  aes(
    x = Name,
    y = Value)) +
  # type of plot we want to create
  geom_point()

ggplot(
  data = df,
  aes(
    x = Name,
    y = Value)) +
  geom_point() +
  # adding title layer on top of the previous layers
  ggtitle("Hello World") +
  xlab("Name") +
  ylab("Value")

# create a bar chart
ggplot(
  data = df,
  aes(
    x = Name,
    y = Value)) +
  geom_bar(
    # indicates set the height to the value of the data itself
    stat = "identity",
    fill = "skyblue") +
  ggtitle("Hello World") +
  xlab("Name") +
  ylab("Value")

# view the help files
?ggplot
?aes
?geom_bar
?ggtitle

# horizontal bar charts are useful when we have a lot of categories to display, when the categories contains long names
# cleveland dot plot is used when you want to increase the data-ink-ratio (or you don't want to spend a lot of ink)
# pie chart are useful when you want to represent your data as a part/portion of the whole. But consider that it shouldn't
# be use for precise comparisson because humans are not good at recognizing angles

movies <- read.csv("Movies.csv")
head(movies)

# univariate visualizations for a qualitative variable using the base plot system
# create a frequency bar chart
plot(
  x = as.factor(movies$Rating),
  main = "Count of movies by rating",
  xlab = "Rating",
  ylab = "Count of movies",
)

# create a horizontal bar chart
plot(
  x = as.factor(movies$Rating),
  horiz = TRUE,
  main = "Count of movies by rating",
  xlab = "Count of movies",
  ylab = "Rating",
)

# create a cleveland dot plot
dotchart(
  # frequency table
  x = table(movies$Rating),
  pch = 16,
  main = "Count of movies by rating",
  xlab = "Count of movies",
  ylab = "Rating",
)

# create a pie chart
pie(
  x = table(movies$Rating),
  main = "Count of movies by rating"
)

# create a pie chart of awards
pie(
  x = table(movies$Awards),
  clockwise = TRUE,
  main = "Proportion of movies that won awards"
)

# univariate visualizations for a qualitative variable using lattice package
library(lattice)

# create frequency table of ratings
table <- table(movies$Rating)
ratings <- as.data.frame(table)
# setting column names in the data frame
names(ratings)[1] <- "Rating"
names(ratings)[2] <- "Count"

# create a frequency bar chart
barchart(
  x = Count ~ Rating,
  data = ratings,
  main = "Count of movies by rating",
  xlab = "Rating"
)

# create a horizontal bar chart
barchart(
  x = Rating ~ Count,
  data = ratings,
  main = "Count of movies by rating",
  ylab = "Rating"
)

# create a cleveland dot plot
dotplot(
  x = Rating ~ Count,
  data = ratings,
  main = "Count of movies by rating",
  ylab = "Rating"
)

# create a part-of-a-whole frequency bar chart. Lattice does not support pie charts
histogram(
  x = ~as.factor(Rating),
  data = movies,
  main = "Percent of movies by rating"
)

# univariate visualizations for a qualitative variable using ggplot2
library(ggplot2)

# create a frequency bar chart for rating
ggplot(
  data = movies,
  aes(x = Rating)) +
  geom_bar() + 
  ggtitle("count of movies by rating")

# create a horizontal frequency bar chart for genre
ggplot(
  data = movies,
  aes(x = Rating)) +
  geom_bar() + 
  # flip the x and y axis
  coord_flip() +
  ggtitle("count of movies by rating")

# create a cleveland dot plot
ggplot(
  data = movies,
  aes(x = Rating)) +
  geom_point(stat = "count") + 
  coord_flip() +
  ggtitle("count of movies by rating")

# create a pie chart
ggplot(
  data = movies,
  aes(x = "", fill = Rating)) +
  geom_bar() + 
  coord_polar(theta = "y") +
  ggtitle("count of movies by rating") +
  ylab("")

# create a pie chart of awards
ggplot(
  data = movies,
  aes(x = "", fill = Awards)) +
  geom_bar() + 
  coord_polar(theta = "y") +
  ggtitle("proportion of movies that won awards") +
  ylab("")

# quantitative univariate variable analysis using the base plot system
# indicates the location, spread and shape of the data
# dot plots are useful to identify the location of the data. Useful for small data
# jitter plot useful for large data. Useful for discrete variables (integers)
# box plot tells the five statistics about a numeric variable (lowest value, first quantile, median, third quantile 
# maximum value) and the outliers (values outside range). Helps to identify the location and spread of the data. Also
# helps to identify outliers
# outliers = Q1 - (1.5 * IQR) | Q3 + (1.5 * IQR) IQR is the inter quantile range
# outliers are values that falls before or after the minimum and maximum probability of the values in the data set.
# outlites may naturally occur or may be data errors
# histogram respond questions about the location and spread of data as well as the distribution of the data. Histogram
# shows the frequency of the data
# density plot tells us the shape of the data and the probability of an observation in a range of values

# create a dot plot of runtime
plot(
  x = movies$Runtime,
  # replicate the value zero as many times as the number of rows in the movies data frame = creates a vector
  y = rep(0, nrow(movies)),
  main = "Distribution of movies runtime",
  xlab = "Runtime (minutes)",
  ylab = "",
  yaxt = "n"
)

# create a dot plot with alpha transparency
plot(
  x = movies$Runtime,
  # replicate the value zero as many times as the number of rows in the movies data frame = creates a vector
  y = rep(0, nrow(movies)),
  main = "Distribution of movies runtime",
  xlab = "Runtime (minutes)",
  ylab = "",
  yaxt = "n",
  pch = 16,
  # 0.1 is the opacity
  col = rgb(0,0,0,0.1)
)

# add jitter to dot plot. The values in the x axis are correct but the values in the y axis are randomly assigned
plot(
  x = movies$Runtime,
  y = jitter(rep(0, nrow(movies))),
  main = "Distribution of movies runtime",
  xlab = "Runtime (minutes)",
  ylab = "",
  yaxt = "n"
)

# create a box plot of runtime
boxplot(
  x = movies$Runtime,
  horizontal = TRUE,
  main = "Distribution of movies runtime",
  xlab = "Runtime (minutes)"
)

# create a histogram of runtime
hist(
  x = movies$Runtime,
  main = "Distribution of movies runtime",
  xlab = "Runtime (minutes)"
)

# create a more course grained histogram
hist(
  x = movies$Runtime,
  breaks = 10,
  main = "Distribution of movies runtime",
  xlab = "Runtime (minutes)"
)

# create a more fine grained histogram
hist(
  x = movies$Runtime,
  breaks = 30,
  main = "Distribution of movies runtime",
  xlab = "Runtime (minutes)"
)

# create a density plot of runtime
plot(
  x = density(movies$Runtime),
  main = "Distribution of movies runtime",
  xlab = "Runtime (minutes)"
)

# create small multiples of all four
par(mfrow = c(4,1))

plot(
  x = movies$Runtime,
  y = jitter(rep(0, nrow(movies))),
  xlim = c(0,250),
  main = "distribution of movies runtime",
  xlab = "",
  ylab = "",
  yaxt = "n",
  pch = 16,
  col = rgb(0,0,0,0.1)
)

boxplot(
  x = movies$Runtime,
  ylim = c(0, 250),
  horizontal = TRUE
)

hist(
  x = movies$Runtime,
  xlim = c(0,250),
  main = "",
  xlab = "",
  ylab = "",
  yaxt = "n"
)

plot(
  x = density(movies$Runtime),
  xlim = c(0,250),
  main = "",
  xlab = "Runtime (minutes)",
  yaxt = "n"
)

# reset graphical parameters
par(mfrow = c(1,1))

# quantitative univariate variable analysis using lattice
# create a dot plot for runtime
stripplot(
  x = ~Runtime,
  data = movies,
  main = "Distribution of movies runtimes",
  xlab = "runtime (minutes)"
)

# create a dot plot with jitter
stripplot(
  x = ~Runtime,
  data = movies,
  jitter = TRUE,
  amount = 0.5,
  main = "Distribution of movies runtimes",
  xlab = "runtime (minutes)"
)

# create a box plot with lattice
bwplot(
  x = ~Runtime,
  data = movies,
  main = "Distribution of movies runtimes",
  xlab = "runtime (minutes)"
)

# create a histogram with lattice
histogram(
  x = ~Runtime,
  data = movies,
  main = "Distribution of movies runtimes",
  xlab = "runtime (minutes)"
)

# create a density plot with lattice
densityplot(
  x = ~Runtime,
  data = movies,
  main = "Distribution of movies runtimes",
  xlab = "runtime (minutes)"
)

# create small multiples of all four
# note: not exactly lined up
dot <- dotplot(
  x = ~Runtime,
  data = movies,
  main = "Distribution of movies runtimes",
  xlab = ""
)

print(
  x = dot,
  position = c(0, 0.75, 1, 1),
  more = TRUE
)

box <- bwplot(
  x = ~Runtime,
  data = movies,
  xlab = ""
)

print(
  x = box,
  position = c(0, 0.50, 1, 0.75),
  more = TRUE
)

hist <- histogram(
  x = ~Runtime,
  data = movies,
  xlab = "",
  ylab = "",
  scales = list(y = list(draw = FALSE))
)

print(
  x = hist,
  position = c(0, 0.25, 1, 0.50),
  more = TRUE
)

density <- densityplot(
  x = ~Runtime,
  data = movies,
  ylab = "",
  scales = list(y = list(draw = FALSE))
)

print(
  x = density,
  position = c(0, 0, 1, 0.25)
)

# quantitative univariate variable analysis using ggplot
# create a dot plot
ggplot(
  data = movies,
  # using statistical transformation to show the count of movies runtime
  aes(x = Runtime, stat = "count")
) +
  geom_dotplot(binwidth = 1) +
  ggtitle("Distribution of movies runtime") +
  xlab("Runtime (minutes)")

# create a violin style dot plot
ggplot(
  data = movies,
  # using statistical transformation to show the count of movies runtime
  aes(x = Runtime, stat = "count")
) +
  geom_dotplot(binwidth = 1,
               stackdir = "center") +
  ggtitle("Distribution of movies runtime") +
  xlab("Runtime (minutes)")

# create a box plot of runtime
ggplot(
  data = movies,
  aes(x = Runtime, y = Runtime)) +
  geom_boxplot() +
  coord_flip() +
  ggtitle("Distribution of movies runtime") +
  xlab("") +
  ylab("Runtime (minutes)") +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  )

# create a histogram with ggplot
ggplot(
  data = movies,
  aes(x = Runtime)) +
  geom_histogram(binwidth = 10) +
  ggtitle("ditribution of movies runtime") +
  xlab("runtime (minutes)")

# create a density plot
ggplot(
  data = movies,
  aes(x = Runtime)) +
  geom_density() +
  ggtitle("ditribution of movies runtime") +
  xlab("runtime (minutes)")

# plot all four
dev.off()

library(grid)

viewport <- viewport(
  layout = grid.layout(4, 1)
)

pushViewport(viewport)

dot <- ggplot(
  data = movies,
  aes(x = Runtime, ..count..)) +
  geom_dotplot(binwidth = 0.25) +
  scale_x_continuous(limits = c(0, 250)) +
  ggtitle("Distribution of movies runtime") +
  xlab("")

print(
  x = dot,
  vp = viewport(
    layout.pos.row = 1,
    layout.pos.col = 1))  

box <- ggplot(
  data = movies,
  aes(x = Runtime, y = Runtime)) +
  geom_boxplot() +
  coord_flip() +
  scale_y_continuous(limits = c(0, 250)) +
  ggtitle("Distribution of movies runtime") +
  xlab("") 

print(
  x = box,
  vp = viewport(
    layout.pos.row = 2,
    layout.pos.col = 1))  

hist <- ggplot(
  data = movies,
  aes(x = Runtime)) +
  geom_histogram(binwidth = 10) +
  scale_x_continuous(limits = c(0, 250)) +
  xlab("")

print(
  x = hist,
  vp = viewport(
    layout.pos.row = 3,
    layout.pos.col = 1))  

density <- ggplot(
  data = movies,
  aes(x = Runtime)) +
  geom_density() +
  scale_x_continuous(limits = c(0, 250)) +
  xlab("runtime (minutes)")

print(
  x = density,
  vp = viewport(
    layout.pos.row = 4,
    layout.pos.col = 1))  

# bivariate visualization of two qualitative variables using the base plot system
# grouped frequency bar chart useful when you need to display the joint frequency as well as compare
# between both categorical variables
# stacked frequency bar chart useful when you need to compare the marginal frequency. It also 
# displays the data as a part of a whole
# 100% stacked frequency bar chart useful when we need to compare relative frequency
# spine plot useful when you need to compare relative frequency
# mosaic plot useful in the same case as spine plot but it is prefered to the former because it is
# more clean 

# create a contingency table
awards <- table(
  movies$Award,
  movies$Rating
)

print(awards)

# create a grouped frequency barchart
barplot(
  height = awards,
  beside = TRUE,
  main = "Count of movies by rating and awards",
  xlab = "rating",
  ylab = "Count of movies",
  legend = c("no", "yes"),
  args.legend = list(
    x = "topleft",
    title = "awards"
  )
)

# create a stacked frequency bar chart
barplot(
  height = awards,
  beside = FALSE,
  main = "Count of movies by rating and awards",
  xlab = "rating",
  ylab = "Count of movies",
  legend = c("no", "yes"),
  args.legend = list(
    x = "topleft",
    title = "awards"
  )
)

# create a proportional frequency table. Notice we want to apply the function on the columns. 1 
# means on the rows
proportions <- apply(awards, 2, function(x){x/sum(x)})
head(awards)
head(proportions)

# create a 100% frequency stacked bar chart
barplot(
  height = proportions,
  beside = FALSE,
  main = "Proportion of movies by rating and awards",
  xlab = "rating",
  ylab = "proportion of movies",
  legend = c("no", "yes"),
  args.legend = list(
    x = "topleft",
    title = "awards"
  )
)

# create a contingency table. Transposing/changing columns with rows. Interchanging columns 
# with rows
# NOTE: x and y are correct
awards <- table(
  movies$Rating,
  movies$Awards
)

colnames(awards) <- c("No","Yes")

# create a spine plot
spineplot(
  x = awards,
  main = "Proportion of movies by rating and awards",
  xlab = "rating",
  ylab = "awards"
)

# create a mosaic plot
mosaicplot(
  x = awards,
  main = "Proportion of movies by rating and awards",
  xlab = "rating",
  ylab = "awards"
)

# bivariate visualization of two qualitative variables using lattice
library(lattice)
# create a grouped frequency bar chart
barchart(
  x = awards,
  stack = FALSE,
  horizontal = FALSE,
  main = "Count of movies by rating and awards",
  xlab = "rating",
  ylab = "count of movies",
  auto.key = list(
    x = 0.05,
    y = 0.95,
    title = "awards",
    text = c("No","Yes")
  )
)

# create a stacked frequency bar chart
barchart(
  x = awards,
  stack = TRUE,
  horizontal = FALSE,
  main = "Count of movies by rating and awards",
  xlab = "rating",
  ylab = "count of movies",
  auto.key = list(
    x = 0.05,
    y = 0.95,
    title = "awards",
    text = c("No","Yes")
  )
)

# create a proportional frequency table. The 1 indicates that we want to apply the function over
# the rows instead of the columns
matrix <- apply(awards, 1, function(x){x / sum(x)})

# transpose matrix
proportions <- t(matrix)

# create a 100% stacked frequency bar chart
barchart(
  x = proportions,
  stack = TRUE,
  horizontal = FALSE,
  main = "Proportion of movies by rating and awards",
  xlab = "rating",
  ylab = "Proportion of movies",
  auto.key = list(
    x = 0.70,
    y = 1.05,
    title = "awards",
    columns = 2,
    text = c("No","Yes"),
    background = "white"
  )
)

# NOTE: no spine plot or mosaic plot in lattice

# bivariate visualization of two qualitative variables using ggplot2
library(ggplot2)
# create a grouped frequency bar chart
ggplot(
  data = movies,
  aes(x = Rating, fill = Awards)) +
  geom_bar(position = "dodge") + 
  ggtitle("count of movies by rating and awards") +
  scale_fill_discrete(labels = c("No","Yes"))

# create a stacked frequency bar chart
ggplot(
  data = movies,
  aes(x = Rating, fill = Awards)) +
  geom_bar() + 
  ggtitle("count of movies by rating and awards") +
  scale_fill_discrete(labels = c("No","Yes"))

# create a 100% stacked frequency bar chart
ggplot(
  data = movies,
  aes(x = Rating, fill = Awards)) +
  geom_bar(position = "fill") + 
  ggtitle("proportion of movies by rating and awards") +
  ylab("Proportion of movies") +
  scale_fill_discrete(labels = c("No","Yes"))

# NOTE: no spine plot or mosaic plot in ggplot. If you need to create these plots use the base plot
# system

# bivariate visualization of two quantitative variables using the base plot system
# scatter plot useful when we want to find the correlation between two variables (weak, strong or
# no correlation at all) and is the correlation positive or negative. Is also useful to find the 
# spread, shape and location of the data
# binned frequency heat map useful to find the joint frequency of two variables and also useful
# for large data sets
# hexagonal binned frequency heat map useful in the same scenario as binned frequency heat map
# but the figure is preferred because it represents the data better. So this should be used or 
# preferred to use
# contour plot useful to get joint density and to find where most of the data is located
# level plot provides the same information as contour plot but may be easier to read
# mesh plot useful to easily see the elevation of the density distribution of the two variables
# but is more complex to understand the plot
# surface plot provides the same information as contour and mesh plots use color to depict the peaks
# in the plot so make them easier to recognize
# step chart useful to display change of value over time
# line chart shows the rate of change over time from one period to the next. Line charts are 
# preferred over the step chart because display the changes over time easily
# area chart useful to show change of value over time but also shows volume or summation of the data
# still line charts are more used than area charts

# create a scatter plot
plot(
  x = movies$Runtime,
  y = movies$Box.Office,
  main = "Runtime vs box office revenue",
  xlab = "runtime (minutes)",
  ylab = "box office ($M)"
)

# create a linear regression model
model <- lm(movies$Box.Office ~ movies$Runtime)

# draw the linear regression line on the plot
lines(
  x = movies$Runtime,
  y = model$fitted,
  col = "red",
  lwd = 3
)

library(hexbin)

# create a hexagonal binned frequency heat map
hexbin <- hexbin(
  x = movies$Runtime,
  y = movies$Box.Office,
  xbins = 30,
  xlab = "Runtime (minutes)",
  ylab = "box office ($M)"
)

plot(
  x = hexbin,
  main = "runtime vs box office revenue"
)

# create a 2D kernel density estimate using. Stands for modern applied statistics with S
library(MASS)

# create a 2D kernel density estimation
density2d <- kde2d(
  x = movies$Runtime,
  y = movies$Box.Office,
  n = 50
)

# create a contour plot of density
contour(
  x = density2d$x,
  y = density2d$y,
  z = density2d$z,
  main = "runtime vs box office revenue",
  xlab = "runtime (minutes)",
  ylab = "box office ($M)"
)

# create a level plot of density
image(
  x = density2d$x,
  y = density2d$y,
  z = density2d$z,
  col = topo.colors(100),
  main = "runtime vs box office revenue",
  xlab = "runtime (minutes)",
  ylab = "box office ($M)"
)

# create a mesh plot of density
persp(
  x = density2d$x,
  y = density2d$y,
  z = density2d$z,
  col = topo.colors(100),
  main = "runtime vs box office revenue",
  xlab = "runtime (minutes)",
  ylab = "box office ($M)",
  zlab = "density"
)

palette(topo.colors(100))
persp(
  x = density2d$x,
  y = density2d$y,
  z = density2d$z,
  col = cut(density2d$z, 100),
  main = "runtime vs box office revenue",
  xlab = "runtime (minutes)",
  ylab = "box office ($M)",
  zlab = "density"
)

palette("default")

timeseries <- read.csv("Timeseries.csv")
head(timeseries)

# create a step chart
plot(
  x = timeseries,
  type = "s",
  ylim = c(0, max(timeseries$Box.Office)),
  main = "Average box office revenue by year",
  xlab = "year",
  ylab = "box office ($M)"
)

# create a line chart
plot(
  x = timeseries,
  type = "l",
  ylim = c(0, max(timeseries$Box.Office)),
  main = "Average box office revenue by year",
  xlab = "year",
  ylab = "box office ($M)"
)

# NOTE: area charts are not easy to create in the base plot system but they are easy to create in
# lattice and ggplot2

# bivariate visualization of two quantitative variables using lattice
library(lattice)
# create a scatter plot
xyplot(
  x = Box.Office ~ Runtime,
  data = movies,
  main = "Runtime vs box office revenue",
  xlab = "runtime (minutes)",
  ylab = "box office ($M)"
)

# add a linear regression line
xyplot(
  x = Box.Office ~ Runtime,
  data = movies,
  # p stands for plot and r stands for regression line
  type = c("p","r"),
  main = "Runtime vs box office revenue",
  xlab = "runtime (minutes)",
  ylab = "box office ($M)"
)

library(hexbin)

# create a hexagonal binned frequency heat map
hexbinplot(
  x = Box.Office ~ Runtime,
  data = movies,
  xbins = 30,
  main = "Runtime vs box office revenue",
  xlab = "runtime (minutes)",
  ylab = "box office ($M)"
)

# create a grid from our 2D kernel density estimate
grid <- expand.grid(
  x = density2d$x,
  y = density2d$y
)

grid$z <- as.vector(density2d$z)
# display the data frame
head(grid)

# create a contour plot of density
contourplot(
  x = z ~ x * y,
  data = grid,
  main = "Runtime vs box office revenue",
  xlab = "runtime (minutes)",
  ylab = "box office ($M)"
)

# create a level plot
levelplot(
  x = z ~ x * y,
  data = grid,
  main = "Runtime vs box office revenue",
  xlab = "runtime (minutes)",
  ylab = "box office ($M)"
)

# create a mesh plot of density
wireframe(
  x = z ~ x * y,
  data = grid,
  main = "Runtime vs box office revenue",
  xlab = "runtime (minutes)",
  ylab = "box office ($M)",
  zlab = "Density"
)

# create a surface plot of density
wireframe(
  x = z ~ x * y,
  data = grid,
  drape = TRUE,
  main = "Runtime vs box office revenue",
  xlab = "runtime (minutes)",
  ylab = "box office ($M)",
  zlab = "Density"
)

# create a step chart
xyplot(
  x = Box.Office ~ Year,
  data = timeseries,
  type = "s",
  ylim = c(0, max(timeseries$Box.Office)),
  main = "Average box office revenue by year",
  xlab = "Year",
  ylab = "Box office ($M)"
)

# create a line chart
xyplot(
  x = Box.Office ~ Year,
  data = timeseries,
  type = "l",
  ylim = c(0, max(timeseries$Box.Office)),
  main = "Average box office revenue by year",
  xlab = "Year",
  ylab = "Box office ($M)"
)

library(latticeExtra)

# create an area chart
xyplot(
  x = Box.Office ~ Year,
  data = timeseries,
  panel = panel.xyarea,
  ylim = c(0, max(timeseries$Box.Office)),
  main = "Average box office revenue by year",
  xlab = "Year",
  ylab = "Box office ($M)"
)

# bivariate visualization of two quantitative variables using ggplot2
library(ggplot2)

# create a scatter plot
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  geom_point() + 
  ggtitle("Runtime vs Box office revenue") + 
  xlab("Runtime (minutes)") +
  ylab("Box office ($M)")

# add a linear regression line  
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  geom_point() + 
  geom_smooth(method = "lm") +
  ggtitle("Runtime vs Box office revenue") + 
  xlab("Runtime (minutes)") +
  ylab("Box office ($M)")

# create a frequency heat map
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  stat_bin2d() +
  ggtitle("Runtime vs Box office revenue") + 
  xlab("Runtime (minutes)") +
  ylab("Box office ($M)")
  
# create a hexagonal binned frequency heat map
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  stat_binhex() +
  ggtitle("Runtime vs Box office revenue") + 
  xlab("Runtime (minutes)") +
  ylab("Box office ($M)")

# create a contour plot of density
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  geom_density2d() +
  ggtitle("Runtime vs Box office revenue") + 
  xlab("Runtime (minutes)") +
  ylab("Box office ($M)")

# create a level plot of density
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  # the .. dot before and after the variable indicates that the value is not present in the 
  # data frame movies but it is calculated by the stat_density2d function
  stat_density2d(aes(fill = ..level..), geom = "polygon") +
  ggtitle("Runtime vs Box office revenue") + 
  xlab("Runtime (minutes)") +
  ylab("Box office ($M)")

# NOTE: 3D visualizations do not exist in ggplot 2 so that's why we cannot visualize mesh or suface
# plots in ggplot2. If you need this plots use lattice or the base plot system as in the examples 
# above

# create a step chart
ggplot(
  data = timeseries,
  aes(x = Year, y = Box.Office)) +
  geom_step() +
  expand_limits(y = 0) +
  ggtitle("Box office revenue by year") +
  xlab("Year") +
  ylab("Box office ($M)")

# create a line chart
ggplot(
  data = timeseries,
  aes(x = Year, y = Box.Office)) +
  geom_line() +
  expand_limits(y = 0) +
  ggtitle("Box office revenue by year") +
  xlab("Year") +
  ylab("Box office ($M)")

# create an area chart
ggplot(
  data = timeseries,
  aes(x = Year, y = Box.Office)) +
  geom_area() +
  expand_limits(y = 0) +
  ggtitle("Box office revenue by year") +
  xlab("Year") +
  ylab("Box office ($M)")

# bivariate visualization of qualitative and quantitative variables using the base plot system
# basically we group the values by the categorical variable and display its values
# bivariate bar chart useful to compare a single aggregate variable (like apples to apples)
# bivariate box plot useful to compare data based on the location (1 or 3 quantile, median), spread
# and comparison of the outliers on each category
# notched box plot show the confidence over the median value
# bivariate violin plot allows to answer questions about the comparisson of the shape of the data

# create a bivariate bar chart
average <- tapply(
  movies$Box.Office,
  movies$Rating,
  mean
)
print(average)

barplot(
  height = average,
  main = "Average box office revenue by rating",
  xlab = "rating",
  ylab = "box office ($M)"
)

# create a bivariate box plot
plot(
  x = as.factor(movies$Rating),
  y = movies$Box.Office,
  main = "box office revenue by rating",
  xlab = "rating",
  ylab = "box office ($M)"
)

# create a notched box plot. To see if the median depends on some random chance
plot(
  x = as.factor(movies$Rating),
  y = movies$Box.Office,
  notch = TRUE,
  main = "box office revenue by rating",
  xlab = "rating",
  ylab = "box office ($M)"
)

# NOTE: violin plots cannot be created with the base plot system but they can be created with 
# lattice and ggplot

# bivariate visualization of qualitative and quantitative variables using lattice
# dplyr allows us to manipulate the data frames in a lambda expression style or functional 
# programming approach

# create a table of average box office by rating
library(dplyr)

average <- movies %>%
  select(Rating, Box.Office) %>%
  group_by(Rating) %>%
  summarize(Box.Office = mean(Box.Office)) %>%
  as.data.frame()
print(average)

# create a bivariate bar chart
barchart(
  x = Box.Office ~ Rating,
  data = average,
  main = "Average box office revenue by rating",
  xlab = "rating",
  ylab = "box office ($M)"
)

# create a bivariate box plot
bwplot(
  x = Box.Office ~ Rating,
  data = movies,
  main = "Average box office revenue by rating",
  xlab = "rating",
  ylab = "box office ($M)"
)

# create a notched box plot
bwplot(
  x = Box.Office ~ Rating,
  data = movies,
  notch = TRUE,
  main = "Average box office revenue by rating",
  xlab = "rating",
  ylab = "box office ($M)"
)

# create a violin plot
bwplot(
  x = Box.Office ~ Rating,
  data = movies,
  panel = panel.violin,
  main = "Average box office revenue by rating",
  xlab = "rating",
  ylab = "box office ($M)"
)

# bivariate visualization of qualitative and quantitative variables using ggplot
# create a bivariate bar chart
ggplot(
  data = average,
  aes(x = Rating, y = Box.Office)) +
  # indicates the value of our y transformation is the result of the statistical transformation
  geom_bar(stat = "identity") +
  ggtitle("Average box office revenue by rating") +
  xlab("rating") +
  ylab("Box Office ($M)")

# create a bivariate box plot
ggplot(
  data = movies,
  aes(x = Rating, y = Box.Office)) +
  geom_boxplot() +
  ggtitle("Average box office revenue by rating") +
  xlab("rating") +
  ylab("Box Office ($M)")

# create a notched box plot
ggplot(
  data = movies,
  aes(x = Rating, y = Box.Office)) +
  geom_boxplot(notch = TRUE) +
  ggtitle("Average box office revenue by rating") +
  xlab("rating") +
  ylab("Box Office ($M)")

# create a violin plot
ggplot(
  data = movies,
  aes(x = Rating, y = Box.Office)) +
  geom_violin() +
  ggtitle("Average box office revenue by rating") +
  xlab("rating") +
  ylab("Box Office ($M)")
