# facets allows you to display 3 variables at the same time
# horizontal facets: use when we want to give more importance to the variable displayed in the Y axis
# vertical facets: use when we want to give emphasis to the variable in the X axis
# wrapped facets: use when there is equal importance in the x and y axis variable
# two dimensional grid facets: use when you need to display four variables

setwd('/home/danielbastidas/git-repo/R-tutorial')

timeSeries <- read.csv('TimeSeries.csv')
head(timeSeries)

# create parameterized function to plot line chart
plotFacet <- function(index, name) {
  values <- timeSeries[, c(1, index)]
  yMax <- max(timeSeries$G)
  
  plot(
    x = values,
    type = "l",
    ylim = c(0, yMax),
    main = name,
    xlab = "Year",
    ylab = "Box Office ($M)"
  )
}

# create horizontal facets indicating that we want 1 row and 4 columns
par(mfrow = c(1,4))

# set the column index to 2
plotFacet(2, "G")
plotFacet(3, "PG")
plotFacet(4, "PG-13")
plotFacet(5, "R")

# create vertical facets indicating that we want 4 rows and 1 column
par(mfrow = c(4, 1))
plotFacet(2, "G")
plotFacet(3, "PG")
plotFacet(4, "PG-13")
plotFacet(5, "R")

# create wrapped facets
par(mfrow = c(2, 2))
plotFacet(2, "G")
plotFacet(3, "PG")
plotFacet(4, "PG-13")
plotFacet(5, "R")

# Reset to indicate that any subsequent graph will be displayed using only 1 row and 1 column
par(mfrow = c(1,1))

# using lattice package to create the visualizations
library(lattice)

timeSeries2 <- read.csv("TimeSeries2.csv")
head(timeSeries2)

# create a horizontal facets. Notice that Box.Office is the variable in the Y axis, Year is the variable in the X axis and
# Rating is the third variable or the facet
xyplot(
  x = Box.Office ~ Year | Rating,
  data = timeSeries2,
  type = "l",
  layout = c(4,1), # 4 columns and 1 row
  main = "Box office revenue by year and rating",
  xlab = "Year",
  ylab = "Box office revenue ($M)"
)

# create a vertical facet. Notice that is the same previous command but indicating that we want only 1 column and 4 rows
xyplot(
  x = Box.Office ~ Year | Rating,
  data = timeSeries2,
  type = "l",
  layout = c(1,4), # 1 column and 4 row2
  main = "Box office revenue by year and rating",
  xlab = "Year",
  ylab = "Box office revenue ($M)"
)

# create a wrapped facets. Notice that is the same previous command but indicating that we want 2 columns and 2 rows
xyplot(
  x = Box.Office ~ Year | Rating,
  data = timeSeries2,
  type = "l",
  layout = c(2,2), # 1 column and 4 row2
  main = "Box office revenue by year and rating",
  xlab = "Year",
  ylab = "Box office revenue ($M)"
)

# load row-based time series
timeSeries3 <- read.csv("TimeSeries3.csv")
head(timeSeries3)

# create a 2-dimensional faceted grid horizontal. Notice that Ratings are on the columns and Awards on the rows
# Notice the formula parameter (x) the Box.Office based on the Year conditioned on the Rating and Awards columns
xyplot(
  x = Box.Office ~ Year | Rating * Awards,
  data = timeSeries3,
  type = "l",
  #layout = c(2,2), # 1 column and 4 row2
  main = "Box office revenue by year and rating",
  xlab = "Year",
  ylab = "Box office revenue ($M)"
)

# create 2-dimensional faceted grid (vertical). Notice that Awards is on the columns and Ratings on the rows
xyplot(
  x = Box.Office ~ Year | Awards * Rating,
  data = timeSeries3,
  type = "l",
  #layout = c(2,2), # 1 column and 4 row2
  main = "Box office revenue by year and rating",
  xlab = "Year",
  ylab = "Box office revenue ($M)"
)

# create the visualizations using ggplot2
library(ggplot2)

# create horizontal facets
ggplot(
  data = timeSeries2,
  aes(
    x = Year,
    y = Box.Office
  )) + geom_line() + 
  facet_grid(
    # indicates rows (.) and columns (Rating)
    facets = .~Rating) + 
  ggtitle("Box Office Revenue by Year and Rating") + 
  xlab("Year") +
  ylab("Box Office Revenue ($M)")

# create vertical facets
ggplot(
  data = timeSeries2,
  aes(
    x = Year,
    y = Box.Office
  )) + geom_line() + 
  facet_grid(
    # indicates rows (.) and columns (Rating)
    facets = Rating ~.) + 
  ggtitle("Box Office Revenue by Year and Rating") + 
  xlab("Year") +
  ylab("Box Office Revenue ($M)")

# create wrapped facets
ggplot(
  data = timeSeries2,
  aes(
    x = Year,
    y = Box.Office
  )) + geom_line() + 
  facet_wrap(
    facets = ~Rating) + 
  ggtitle("Box Office Revenue by Year and Rating") + 
  xlab("Year") +
  ylab("Box Office Revenue ($M)")

# create 2-dimensional facets (vertical)
ggplot(
  data = timeSeries3,
  aes(
    x = Year,
    y = Box.Office
  )) + geom_line() + 
  facet_grid(
    facets = Awards~Rating) + 
  ggtitle("Box Office Revenue by Year and Rating") + 
  xlab("Year") +
  ylab("Box Office Revenue ($M)")

# create two-dimensional facets vertical
ggplot(
  data = timeSeries3,
  aes(
    x = Year,
    y = Box.Office
  )) + geom_line() + 
  facet_grid(
    facets = Rating~Awards) + 
  ggtitle("Box Office Revenue by Year and Rating") + 
  xlab("Year") +
  ylab("Box Office Revenue ($M)")

# three categorical (qualitative) variables visualization using the base plot system
movies <- read.csv("Movies2.csv")
head(movies)

# create a function to create contingency table
getTable <- function(distribution) {
  filter <- movies$Distribution == distribution
  subset <- movies[filter, ]
  table(
    x = subset$Awards,
    y = subset$Rating
  )
}

# display contingency type
getTable("Domestic")
getTable("International")

# set facets to two side-by-side panes
par(mfrow = c(1,2))

# create faceted grouped frequency bar chart
barplot(
  height = getTable("Domestic"),
  beside = TRUE,
  # lowest value in the y axis is 0 and the maximum is 600
  ylim = c(0,600),
  main = "Domestic",
  xlab = "Rating",
  ylab = "Count of Movies"
)

barplot(
  height = getTable("International"),
  beside = TRUE,
  # lowest value in the y axis is 0 and the maximum is 600
  ylim = c(0,600),
  main = "International",
  xlab = "Rating",
  legend = rownames(getTable("International"))
)

# create a faceted stacked frequency bar chart
barplot(
  height = getTable("Domestic"),
  ylim = c(0, 1000),
  main = "Domestic",
  xlab = "Rating",
  ylab = "Count of movies"
)

barplot(
  height = getTable("International"),
  ylim = c(0, 1000),
  main = "International",
  xlab = "Rating",
  ylab = rownames(getTable("International"))
)

# create a two dimensional faceted grouped frequency bar chart
getTable2 <- function(awards, distribution) {
  filter <- movies$Awards == awards & movies$Distribution == distribution
  subset <- movies[filter, ]
  table(subset$Rating)
}

# print frequency tables
getTable2("No Awards", "Domestic")
getTable2("Won Awards", "Domestic")
getTable2("No Awards", "International")
getTable2("Won Awards", "International")

# set facets 2X2 grid
par(mfrow = c(2,2))

# create 2D faceted bar chart
barplot(
  height = getTable2("No Awards", "Domestic"),
  ylim = c(0, 600),
  main = "No Awards / Domestic",
  ylab = "Count of movies"
)

barplot(
  height = getTable2("Won Awards", "Domestic"),
  ylim = c(0, 600),
  main = "Won Awards / Domestic"
 
)

barplot(
  height = getTable2("No Awards", "International"),
  ylim = c(0, 600),
  main = "No Awards / International",
  ylab = "Count of movies"
)

barplot(
  height = getTable2("Won Awards", "International"),
  ylim = c(0, 600),
  main = "Won Awards / International",
  xlab = "Rating"
)

# reset facets to single pane
par(mfrow = c(1,1))

# three categorical variables visualization using lattice plot system
# this table contains the information in a rows wise way (each row contains the whole information)
library(dplyr)
library(lattice)

# the following operations are supported by the dplyr package
table <- movies %>%
        select(Rating, Awards, Distribution) %>%
        group_by(Rating, Awards, Distribution) %>%
        summarize(Count = n()) # counts the number of rows at the intersection of the three variables

head(table)

# create a faceted group frequency bar chart
barchart(
  x = Count ~ Rating | Distribution,
  data = table,
  groups = Awards,
  main = "Count of movies by Rating, Awards and Distribution",
  xlab = "Rating",
  ylab = "Count of movies",
  auto.key = TRUE # automatically lattice generate the legend for the chart
)

# create a faceted group frequency bar chart 
barchart(
  x = Count ~ Rating | Distribution,
  data = table,
  groups = Awards,
  stack = TRUE,
  main = "Count of movies by Rating, Awards and Distribution",
  xlab = "Rating",
  ylab = "Count of movies",
  auto.key = TRUE # automatically lattice generate the legend for the chart
)

# create a 2D faceted frequency bar charts
barchart(
  x = Count ~ Rating | Awards * Distribution,
  data = table,
  main = "Count of movies by Rating, Awards and Distribution",
  xlab = "Rating",
  ylab = "Count of movies"
)

# three categorical variables visualization using ggplot system
library(ggplot2)

ggplot(
  data = movies,
  aes(
    x = Rating,
    fill = Awards)) +
  geom_bar(
    position = "dodge") +
  facet_wrap(
    facets = ~Distribution) +
  ggtitle("Count of movies by Rating, Awards and Distribution") + 
  xlab("Rating") +
  ylab("Count of movies")

# create a faceted stacked frequency bar chart
ggplot(
  data = movies,
  aes(
    x = Rating,
    fill = Awards)) +
  geom_bar() +
  facet_wrap(
    facets = ~Distribution) +
  ggtitle("Count of movies by Rating, Awards and Distribution") + 
  xlab("Rating") +
  ylab("Count of movies")

# create a 2D faceted frequency bar chart
ggplot(
  data = movies,
  aes(
    x = Rating)) +
  geom_bar() +
  facet_grid(
    facets = Awards ~ Distribution) +
  ggtitle("Count of movies by Rating, Awards and Distribution") + 
  xlab("Rating") +
  ylab("Count of movies")

# visualization of two categorical and one numeric variable using the base plot system
# create a function to create table rows
getRow <- function(awards) {
  subset <- movies[movies$Awards == awards, ]
  tapply(
    subset$Box.Office,
    subset$Rating,
    mean
  )
}

# display result
getRow("No Awards")

# combine the two rows to form a table
table <- rbind(
  getRow("No Awards"),
  getRow("Won Awards")
)

# Rename the rows
rownames(table) = c("No Awards", "Won Awards")

# display the table
print(table)

# create a grouped bar chart
barplot(
  height = table,
  beside = TRUE,
  main = "Average Box Office Revenue by Rating and Award Status",
  xlab = "Rating",
  ylab = "Box Office Revenue ($M)",
  legend = rownames(table)
)

# create a stacked bar chart
barplot(
  height = table,
  beside = FALSE,
  main = "Average Box Office Revenue by Rating and Award Status",
  xlab = "Rating",
  ylab = "Box Office Revenue ($M)",
  legend = rownames(table)
)

# create a faceted bar chart
par(mfrow = c(1,2))

barplot(
  height = getRow("No Awards"),
  ylim = c(0,100),
  main = "No Awards",
  xlab = "Rating",
  ylab = "Box Office revenue ($M)"
)

barplot(
  height = getRow("Won Awards"),
  ylim = c(0,100),
  main = "Won Awards",
  xlab = "Rating"
)

# reset plot window
par(mfrow = c(1,1))

# create a heat map
heatmap(
  x = table,
  col = heat.colors(100),
  scale = "none",
  Colv = NA,
  Rowv = NA,
  margins = c(6,10),
  main = "Average Box Office Revenue",
  cexRow = 2
)

# visualization of two categorical and one numeric variable using lattice plot system
# create a row-wise table. Example of group by operation
table2 <- movies %>%
          select(Rating, Awards, Box.Office) %>%
          group_by(Rating, Awards) %>%
          summarize(Box.Office = mean(Box.Office))

# display table2
head(table2)

# create a grouped bar chart
barchart(
  # we are saying that box office is a function of rating
  x = Box.Office ~ Rating,
  data = table2,
  groups = Awards,
  main = "Average box office Revenue by Rating and Award Status",
  xlab = "Rating",
  ylab = "Box Office Revenue ($M)",
  auto.key = TRUE
)

# create a stacked bar chart
barchart(
  # we are saying that box office is a function of rating
  x = Box.Office ~ Rating,
  data = table2,
  groups = Awards,
  stack = TRUE,
  main = "Average box office Revenue by Rating and Award Status",
  xlab = "Rating",
  ylab = "Box Office Revenue ($M)",
  auto.key = TRUE
)

# create a faceted bar chart
barchart(
  # we are saying that box office is a function of rating
  x = Box.Office ~ Rating | Awards,
  data = table2,
  layout = c(2,1),
  main = "Average box office Revenue by Rating and Award Status",
  xlab = "Rating",
  ylab = "Box Office Revenue ($M)"
)

# create a heat map. Gotta check why doesn't works
#levelplot(
#  x = Box.Office ~ Rating * Awards,
#  data = table2,
#  main = "Average Box Office Revenue by Rating and Award Status",
#  xlab = "Rating",
#  ylab = "Award Status"
#)

# visualization of two categorical and one numeric variable using ggplot2 system
# create a grouped bar chart
ggplot(
  data = movies,
  aes(
    x = Rating,
    y = Box.Office,
    fill = Awards)) + 
  geom_bar(
    stat = "summary",
    fun = "mean",
    position = "dodge") + 
  ggtitle("Average Box Office Revenue by Rating and Award Status") + 
  xlab("Rating") +
  ylab("Box Office Revenue ($M)")

# create a stacked bar chart
ggplot(
  data = movies,
  aes(
    x = Rating,
    y = Box.Office,
    fill = Awards)) + 
  geom_bar(
    stat = "summary",
    fun = "mean",
    position = "stack") + 
  ggtitle("Average Box Office Revenue by Rating and Award Status") + 
  xlab("Rating") +
  ylab("Box Office Revenue ($M)")

# create a faceted bar char
ggplot(
  data = movies,
  aes(
    x = Rating,
    y = Box.Office)) + 
  geom_bar(
    stat = "summary",
    fun = "mean") + 
  facet_wrap(
    facets = ~Awards) +
  ggtitle("Average Box Office Revenue by Rating and Award Status") + 
  xlab("Rating") +
  ylab("Box Office Revenue ($M)")

# create a heat map
ggplot(
  data = table2,
  aes(
    x = Rating,
    y = Awards,
    fill = Box.Office)) + 
  geom_tile(
    stat = "identity") +
  ggtitle("Average Box Office Revenue by Rating and Award Status") + 
  xlab("Rating") +
  ylab("Awards") +
  labs(fill = "Box Office\n Revenue ($M)")

# visualize one categorical and two numeric variables one qualitative and two quantitative using the base plot system
# create a subset of movies
movies2014 <- movies[movies$Year == 2014, ]

# load color brewer
library(RColorBrewer)

# display all color palettes
display.brewer.all()

# create a color palette
colors <- brewer.pal(4, "Set1")

# create a color-coded scatter plot
plot(
  x = movies2014$Critic.Score,
  y = movies2014$Box.Office,
  col = colors[as.factor(movies2014$Rating)],
  pch = 19,
  main = "Critic score vs Box office Revenue by Rating",
  xlab = "Critic score (%)",
  ylab = "Box Office Revenue ($M)",
  type = "p"
)

# add a legend
legend(
  # the position of the legend
  x = "topleft",
  legend = levels(as.factor(movies2014$Rating)),
  col = colors[1:4],
  pch = 19
)

# create a shape palette for the pch parameter print character
shapes <- c(1, 4, 2, 0)

# create a shape-coded scatter plot
plot(
  x = movies2014$Critic.Score,
  y = movies2014$Box.Office,
  pch = shapes[as.factor(movies2014$Rating)],
  main = "Critic score vs Box office Revenue by Rating"
)

# add a legend
legend(
  # the position of the legend
  x = "topleft",
  as.character(levels(as.factor(movies2014$Rating))),
  pch = shapes[1:4],
  cex = 1
)

# create tables filtered by rating to display the faceted visualization
gMovies <- movies2014[movies2014$Rating == "G", ]
pgMovies <- movies2014[movies2014$Rating == "PG", ]
pg13Movies <- movies2014[movies2014$Rating == "PG-13", ]
rMovies <- movies2014[movies2014$Rating == "R", ]

# create a faceted scatter plot
par(mfrow = c(2,2))

plot(
  x = gMovies$Critic.Score,
  y = gMovies$Box.Office,
  main = "G",
  xlab = "",
  ylab = "Box Office Revenue ($M)"
)

plot(
  x = pgMovies$Critic.Score,
  y = pgMovies$Box.Office,
  main = "PG",
  xlab = "",
  ylab = ""
)

plot(
  x = pg13Movies$Critic.Score,
  y = pg13Movies$Box.Office,
  main = "PG-13",
  xlab = "Critic score (%)",
  ylab = "Box office revenue"
)

plot(
  x = rMovies$Critic.Score,
  y = rMovies$Box.Office,
  main = "R",
  xlab = "Critic score (%)",
  ylab = ""
)

# reset the plot window
par(mfrow = c(1,1))

# load time series (column-based)
timeSeries <- read.csv("TimeSeries.csv")
head(timeSeries)

# create a multi-series line chart
plot(
  # notice we set the x and y values to zero because we are not displaying anything yet
  x = 0,
  y = 0,
  xlim = c(2000, 2015),
  ylim = c(0, max(timeSeries$G)),
  type = "l",
  main = "Box office revenue over time by rating category",
  xlab = "year",
  ylab = "box office revenue ($M)"
)

lines(
  x = timeSeries$Year,
  y = timeSeries$G,
  col = colors[1]
)

lines(
  x = timeSeries$Year,
  y = timeSeries$PG,
  col = colors[2]
)

lines(
  x = timeSeries$Year,
  y = timeSeries$PG-13,
  col = colors[3]
)

lines(
  x = timeSeries$Year,
  y = timeSeries$R,
  col = colors[4]
)

legend(
  x = "topleft",
  legend = c("G","PG", "PG-13", "R"),
  col = colors,
  pch = 15
)

# stacked area charts are a bit difficult
# create a faceted line chart
par(mfrow = c(2, 2))

plot(
  x = timeSeries[, c(1,2)],
  type = "l",
  ylim = c(0, max(timeSeries$G)),
  main = "G",
  xlab = "",
  ylab = "Box Office Revenue ($M)"
)

plot(
  x = timeSeries[, c(1,3)],
  type = "l",
  ylim = c(0, max(timeSeries$G)),
  main = "PG",
  xlab = "",
  ylab = ""
)

plot(
  x = timeSeries[, c(1,4)],
  type = "l",
  ylim = c(0, max(timeSeries$G)),
  main = "PG-13",
  xlab = "Year",
  ylab = "Box office revenue ($M)"
)

plot(
  x = timeSeries[, c(1,5)],
  type = "l",
  ylim = c(0, max(timeSeries$G)),
  main = "G",
  xlab = "Year",
  ylab = ""
)

# reset plot window
par(mfrow = c(1,1))

# visualize one categorical and two numerical values using lattice plot system
# create a color-coded scatter plot
xyplot(
  x = Box.Office ~ Critic.Score,
  data = movies2014,
  group = Rating,
  par.settings = list(
    superpose.symbol = list (
      col = colors
      )
  ),
  auto.key = list(columns = 4),
  main = "Critic score vs Box office revenue by Rating",
  xlab = "Critic score (%)",
  ylab = "Box office revenue ($M)"
)

# create a shape-coded scatter plot
xyplot(
  x = Box.Office ~ Critic.Score,
  data = movies2014,
  key = list(
    text = list (
      levels(as.factor(movies2014$Rating))
    ),
  points = list(
    pch = shapes),
  columns = 4
  ),
  pch = shapes[as.factor(movies2014$Rating)],
  main = "Critic score vs Box office revenue by Rating",
  xlab = "Critic score (%)",
  ylab = "Box office revenue ($M)"
)

# create a faceted scatter plot
xyplot(
  x = Box.Office ~ Critic.Score | Rating,
  data = movies2014,
  main = "Critic score vs Box office revenue by Rating",
  xlab = "Critic score (%)",
  ylab = "Box office revenue ($M)"
)

# create a time series (row-based) using lattice
timeSeries2 <- movies %>%
  select(Year, Rating, Box.Office) %>%
  group_by(Year, Rating) %>%
  summarize(Box.Office = mean(Box.Office)) %>%
  as.data.frame()

head(timeSeries2)

# create a multi-series line chart using lattice
xyplot(
  x = Box.Office ~ Year,
  data = timeSeries2,
  group = Rating,
  type = "l",
  auto.key = list(columns = 4),
  main = "Box Office Revenue over time by Rating category",
  xlab = "Year",
  ylab = "Box Office Revenue ($M)"
)

# stacked area charts are difficult to create using lattice so check for the example using ggplot

# create faceted line chart
xyplot(
  x = Box.Office ~ Year | Rating,
  data = timeSeries2,
  type = "l",
  layout = c(2,2),
  main = "Box Office Revenue over time by Rating category",
  xlab = "Year",
  ylab = "Box Office Revenue ($M)"
)

# one categorical and two numeric variables using ggplot2
# create a color-coded scatter plot
ggplot(
  data = movies2014,
  aes(
    x = Critic.Score,
    y = Box.Office,
    color = Rating
  )
) + scale_color_manual(
  name = "Rating",
  labels = levels(movies2014$Rating),
  values = colors
) + geom_point() + 
  ggtitle("Critic score vs Box Office Revenue by rating") + 
  xlab("Critic Score (%)") +
  ylab("Box Office Revenue ($M)")

# create a shape-coded scatter plot
ggplot(
  data = movies2014,
  aes(
    x = Critic.Score,
    y = Box.Office,
    shape = Rating
  )
) + scale_shape_manual(
  name = "Rating",
  labels = levels(movies2014$Rating),
  values = shapes
) + geom_point() + 
  ggtitle("Critic score vs Box Office Revenue by rating") + 
  xlab("Critic Score (%)") +
  ylab("Box Office Revenue ($M)")

# create a faceted scatter plot
ggplot(
  data = movies2014,
  aes(
    x = Critic.Score,
    y = Box.Office
  )
) + geom_point() + 
  facet_wrap(
    facets = ~Rating
  ) +
  ggtitle("Critic score vs Box Office Revenue by rating") + 
  xlab("Critic Score (%)") +
  ylab("Box Office Revenue ($M)")

# create a multi-series line chart
ggplot(
  data = timeSeries2,
  aes(
    x = Year,
    y = Box.Office,
    color = Rating
  )
) + geom_line() + 
  ggtitle("Critic score vs Box Office Revenue by rating") + 
  xlab("Critic Score (%)") +
  ylab("Box Office Revenue ($M)")

# create a stacked area chart
ggplot(
  data = timeSeries2,
  aes(
    x = Year,
    y = Box.Office,
    fill = Rating
  )
) + geom_area() + 
  ggtitle("Box Office revenue over time by rating category") + 
  xlab("Year") +
  ylab("Box Office Revenue ($M)")

# create a faceted line chart
ggplot(
  data = timeSeries2,
  aes(
    x = Year,
    y = Box.Office
  )
) + geom_line() + 
  facet_wrap(
    facets = ~Rating
  ) +
  ggtitle("Box Office revenue over time by rating category") + 
  xlab("Year") +
  ylab("Box Office Revenue ($M)")

# three numerical variable visualization using base plot system
# create a gradient color palette. Yellow Orange Red
gradient <- brewer.pal(5, "YlOrRd")

# create gradient color-scale scatter plot
palette(gradient)

# cut allows to convert a numeric variable into a factor. convert a quantitative variable into a qualitative variable
plot(
  x = movies2014$Runtime,
  y = movies2014$Critic.Score,
  col = cut(movies2014$Box.Office, 5),
  pch = 16,
  main = "Critic Score vs Box Office Revenue vs Runtime",
  xlab = "Runtime (min)",
  ylab = "Critic Score (%)"
)

legend(
  x = "bottomleft",
  title = "Box Office ($M)",
  legend = levels(cut(movies2014$Box.Office, 5)),
  col = 1:5,
  pch = 16,
  cex = 0.75
)

# create divergent color palette
divergent <- rev(brewer.pal(5, "RdBu"))

# create divergent color-scale scatter plot
palette(divergent)

plot(
  x = movies2014$Runtime,
  y = movies2014$Critic.Score,
  col = cut(movies2014$Box.Office, 5),
  pch = 16,
  main = "Runtime, Critic Score, and Box Office Revenue",
  xlab = "Runtime (min)",
  ylab = "Critic Score (%)"
)

legend(
  x = "bottomleft",
  title = "Box Office ($M)",
  as.character(levels(cut(movies2014$Box.Office, 5))),
  col = 1:5,
  pch = 16,
  cex = 0.75
)

# reset the color palette
palette("default")

# create a size by area function using base pplot system
getSize <- function(values, scale) {
  ratio <- values / max (values)
  
  size <- sqrt(ratio / pi)
  
  size * scale
}

# create bubble charts
plot(
  x = movies2014$Runtime,
  y = movies2014$Critic.Score,
  # plot character size
  cex = getSize(movies2014$Box.Office, 5),
  main = "Runtime, Critic score, and box office revenue",
  xlab = "Runtime (min)",
  ylab = "critic score (%)"
)

# install scatterplot 3d package
install.packages("scatterplot3d")
library(scatterplot3d)

# create a 3D scatter plot. Points closer are red color and points farther are black
scatterplot3d(
  x = movies2014$Runtime,
  y = movies2014$Critic.Score,
  z = movies2014$Box.Office,
  main = "Runtime, Critic Score, and box office revenue",
  xlab = "Runtime (min)",
  ylab = "critic score (%)",
  zlab = "box office revenue ($M)",
  highlight.3d = TRUE
)

# three numerical variables using lattice plot system
# create a gradient color-scale scatter plot
xyplot(
  x = Critic.Score ~ Runtime,
  data = movies2014,
  col = gradient[cut(movies2014$Box.Office, 5)],
  pch = 16,
  main = "Runtime, critic score, and box office revenue",
  xlab = "Runtime (min)",
  ylab = "Critic score (%)",
  # create a legend
  key = list(
    corner = c(0.05, 0.05),
    title = "box Office ($M)",
    # reduce font size
    cex = 0.75,
    text = list(levels(cut(movies2014$Box.Office, 5))),
    points = list(
      pch = 16,
      col = gradient
    )
  )
)

# create a divergent color-scale scatter plot
xyplot(
  x = Critic.Score ~ Runtime,
  data = movies2014,
  col = divergent[cut(movies2014$Box.Office, 5)],
  pch = 16,
  main = "Runtime, critic score, and box office revenue",
  xlab = "Runtime (min)",
  ylab = "Critic score (%)",
  key = list(
    corner = c(0.05, 0.05),
    title = "Box Office ($M)",
    cex = 0.75,
    text = list(levels(cut(movies2014$Box.Office, 5))),
    points = list(
      pch = 16,
      col = gradient
    )
  )
)

# create bubble chart with lattice. It is difficult to add a legend using lattice but we will see how to do it with 
# ggplot
xyplot(
  x = Critic.Score ~ Runtime,
  data = movies2014,
  cex = getSize(movies$Box.Office, 5),
  pch = 16,
  main = "Runtime, critic score, and box office revenue",
  xlab = "Runtime (min)",
  ylab = "Critic score (%)",
)

# create 3D scatter plot
cloud(
  # box office is a function of critic score and runtime
  x = Box.Office ~ Critic.Score * Runtime,
  data = movies2014,
  # p stands for points and h stands for histogram
  type = c("p", "h"),
  pch = 16,
  main = "Runtime, Critic score, and box office revenue",
  xlab = "Runtime (min)",
  ylab = "Critic score (%)",
  zlab = "Box Office\nRevenue\n($M)"
)

# three numerical variables using ggplot2
# create a gradient color-scale scatter plot
ggplot(
  data = movies2014,
  aes(
    x = Runtime,
    y = Critic.Score, 
    color = Box.Office)) + 
  geom_point() + 
  scale_color_gradient(
    low = gradient[1],
    high = gradient[5]) + 
  ggtitle("Runtime, Critic score, and box office revenue") +
  xlab("Runtime ($min)") + 
  ylab("Critic Score (%)") +
  labs(color = "Box Office\nRevenue ($M)")

# create a divergent color-scale scatter plot
ggplot(
  data = movies2014,
  aes(
    x = Runtime,
    y = Critic.Score, 
    color = Box.Office)) + 
  geom_point() + 
  scale_color_gradientn(colors = divergent) + 
  ggtitle("Runtime, Critic score, and box office revenue") +
  xlab("Runtime ($min)") + 
  ylab("Critic Score (%)") +
  labs(color = "Box Office\nRevenue ($M)")

# create a bubble chart. Instead of using a color label we could also use a size label
ggplot(
  data = movies2014,
  aes(
    x = Runtime,
    y = Critic.Score, 
    size = Box.Office, 10)) + 
  geom_point() + 
  scale_size_area() + 
  ggtitle("Runtime, Critic score, and box office revenue") +
  xlab("Runtime ($min)") + 
  ylab("Critic Score (%)") +
  # size label
  labs(color = "Box Office\nRevenue ($M)")

# note 3D scatter plots not available in ggplot2. Create those using the base plot system or lattice as shon in this same
# R script

# visualize many variables using the base plot system
# Create a correlation matrix indicating the indexes of the columns we want to use
correlations <- cor(movies[,c(2,4,5,6)])

# display the correlation matrix (rounded values)
round(correlation, 2)

# load the correlogram package
library(corrgram)

# create a correlogram. Notice that we don't have to pass only the numeric variables because the corrgram function does
# it automatically
corrgram(movies)

# create a scatter plot matrix from columns 2 until 6
plot(movies[, 2:6])

# load 100 top movies
top100 <- read.csv("Top 100.csv")

# display top 100 movies
head(top100[, c(1,6)])

library(MASS)

# create parallel coordinates plot
parcoord(top100[, c(2,4,5,6)])

# visualize many variables using lattice
# create a correlogram
levelplot(
  x = correlations,
  # a sequence of values from -1 to 1 with an increment of 0.1
  at = seq(-1, 1, 0.1)
)

# create a scatter plot matrix. Scatter Plot Matrix
splom(movies[, c(2:6)])

# create parallel coordinates plot
parallelplot(
  x = top100[, c(2, 4, 5, 6)],
  horizontal.axis = FALSE
)

# visualize many variables using ggplot2
# load reshape2 library
library(reshape2)

# melt correlation matrix. The melt command transform/convert the two dimensional matrix into a data frame containing a 
# row wise representation of the same data in the matrix
melted <- melt(correlations)

# compare original to melted correlations
round(correlations, 2)
# value contained the intersection of the two column variables
head(melted)

# create a correlogram
ggplot(
  data = melted,
  aes(
    x = Var1,
    y = Var2,
    fill = value)) + 
  geom_tile() + 
  scale_fill_gradient2(
    low = "red",
    mid = "white",
    high = "blue",
    limit = c(-1, 1),
    midpoint = 0
  )

# load the ggally library adds functionality to the ggplot package
library(GGally)

# create a scatter plot matrix. The graphs showed depends on the variable type (qualitative or quantitative)
ggpairs(
  data = movies,
  columns = c(2:6)
)

# create a parallel coordinates plot
ggparcoord(top100[, c(2,4,5,6)])


# visualize spatial data using ggplot
library(ggplot2)

# create a base map no data
ggplot() +
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  ggtitle("base map of the world") + 
  xlab("") + 
  ylab("") +
  theme(
    panel.background = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank())

movies <- read.csv("Movies-by-Country.csv")  
head(movies)

# create a dot density map
ggplot(
  data = movies) +
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  geom_point(
    aes(
      x = Longitude,
      y = Latitude)) +
  ggtitle("movies by country") + 
  xlab("") + 
  ylab("") +
  theme(
    panel.background = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank())

# create a contour map
ggplot(
  data = movies) +
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  geom_density2d(
    aes(
      x = Longitude,
      y = Latitude)) +
  ggtitle("density of movies by country") + 
  xlab("") + 
  ylab("") +
  theme(
    panel.background = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank())

# zoom into a map. In order to zoom the map you need to provide appropriate longitude and latitude coordinates to avoid
# distortions in the horizontal or vertical dimensions
ggplot(
  data = movies) +
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  coord_cartesian(
    # longitude
    xlim = c(-20, 59),
    # latitude
    ylim = c(35, 71)) +
  geom_density2d(
    aes(
      x = Longitude,
      y = Latitude)) +
  ggtitle("density of movies by country") + 
  xlab("") + 
  ylab("") +
  theme(
    panel.background = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank())

# create a level map
ggplot(
  data = movies) +
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  coord_cartesian(
    # longitude
    xlim = c(-20, 59),
    # latitude
    ylim = c(35, 71)) +
  stat_density2d(
    aes(
      x = Longitude,
      y = Latitude,
      # the .. indicates the level is computed by the function instead of being provided in the data set
      alpha = ..level..),
    geom = "polygon",
    fill = "blue") +
  ggtitle("density of movies by country") + 
  xlab("") + 
  ylab("") +
  theme(
    panel.background = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank())

# read countries from csv file
countries <- read.csv("Countries.csv")
head(countries)

# create a bubble map
ggplot(
  data = countries) +
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  geom_point(
    aes(
      x = Longitude,
      y = Latitude,
      size = Count)) +
  scale_size_area(
    max_size = 5) +
  ggtitle("count of movies by country") + 
  xlab("") + 
  ylab("") +
  # title of legend
  labs(size = "movies") +
  theme(
    panel.background = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank())

# load map data as a data frame
map <- map_data("world")
head(map)

# load dplyr
library(dplyr)

# join countries and map data. join two data frames
countries2 <- countries %>%
  left_join(map,
            by = c("Country" = "region")) %>%
  select(
    Country,
    Longitude = long,
    Latitude = lat,
    Group = group,
    Order = order,
    Count) %>%
  arrange(Order) %>%
  as.data.frame()

head(countries2)

# create a choropleth
ggplot(
  data = countries2) +
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  geom_polygon(
    aes(
      x = Longitude,
      y = Latitude,
      group = Group,
      fill = Count),
    color = "grey60") +
  scale_fill_gradient(
    low = "white",
    high = "red") +
  ggtitle("count of movies by country") + 
  xlab("") + 
  ylab("") +
  # title of legend
  labs(color = "movies") +
  theme(
    panel.background = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank())

# reproject a map
ggplot(
  data = countries2) +
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  coord_map(
    projection = "ortho",
    orientation = c(41, -74, 0)) +
  geom_polygon(
    aes(
      x = Longitude,
      y = Latitude,
      group = Group,
      fill = Count),
    color = "grey60") +
  scale_fill_gradient(
    low = "white",
    high = "red") +
  ggtitle("count of movies by country") + 
  xlab("") + 
  ylab("") +
  # title of legend
  labs(color = "movies") +
  theme(
    panel.background = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank())

# map projection help files
?mapproject

# visualize hierarchical data using

# load movies by country hierarchy
hierarchy <- read.csv("Hierarchy.csv")
head(hierarchy, 7)

# create a tree path column
hierarchy$Path <- paste(
  "All",
  hierarchy$Continent,
  hierarchy$Country,
  sep = "/"
)

head(hierarchy$Path)

# load the tree package
library(data.tree)

# create a tree from a data frame
tree <- as.Node(
  x = hierarchy,
  pathName = "Path"
)

# print the tree
print(tree, limit = 10)

library(DiagrammeR)

# plot tree
plot(tree)

library(igraph)

# create tree graph
treeGraph <- as.igraph(tree)

# plot tree graph
plot(
  x = treeGraph,
  main = "Geographic distribution hierarchy"
)

# add row names for dendro labels. Setting row names for the data set
row.names(hierarchy) <- hierarchy$Country
head(hierarchy, 10)

# create a distance matrix. Distance between every pair of nodes in the data using in this case the longitude and 
# latitude, columns 3 and 4 of our data set
distance <- dist(hierarchy[, c(3,4)])
round(distance, 0)

# create hierarchical clusters
clusters <- hclust(distance)

# create dendogram
plot(
  x = clusters,
  main = "Hierarchical clusters of countries"
)

library(ape)

# create a phylogenic tree
phylo <- as.phylo(clusters)

# create a radial tree
plot(
  x = phylo,
  type = "fan"
)

# load the tree map package
library(treemap)

# create a frequency tree map
treemap(
  dtf = hierarchy,
  # fields in the data frame
  index = c("Continent", "Country"),
  # field in the data frame
  vSize = "Count",
  # field in the data frame
  vColor = "Continent",
  # we are coloring using a categorical variable
  type = "categorical",
  title = "Count of movies by continent and country",
  position.legend = "none"
)

# create a tree map
treemap(
  dtf = hierarchy,
  # fields in the data frame
  index = c("Continent", "Country"),
  # field in the data frame
  vSize = "Count",
  # field in the data frame
  vColor = "Box.Office",
  # we are coloring using a numeric value
  type = "value",
  palette = c("#FF681D","#FFE1D2"),
  title = "Count of movies and average box office revenue by continent and country",
  title.legend = "Average box office revenue ($M)"
)

# visualize graph and network data
actors <- read.csv("Actors.csv")
head(actors)

# get five time plus acting pairs
actors5 <- actors[actors$Count >= 5, ]

# load igraph package
library(igraph)

# create a graph of acting pairs
graph5 <- graph.data.frame(
  d = actors5,
  directed = FALSE
)

# plot a small graph
plot(
  x = graph5,
  edge.curved = FALSE,
  main = "Five time or more acting pairs"
)

# get actors who have acted together twice or more
actors2 <- actors[actors$Count >= 2, ]

# create an undirected graph object
graph2 <- graph.data.frame(
  d = actors2,
  directed = FALSE
)

# plot a large graph
plot(
  x = graph2,
  vertex.size = 2,
  vertex.label = NA,
  edge.curved = FALSE,
  edge.width = edge_attr(graph2)$Count,
  main = "Twice or more acting pairs"
)

# create graph clusters
clusters <- cluster_edge_betweenness(graph2)

# plot communities graph
plot(
  x = clusters,
  y = graph2,
  vertex.size = 3,
  vertex.label = NA,
  edge.curved = FALSE,
  main = "Acting communities"
)

# visualize textual data
plots <- read.csv("Plots.csv", encoding = "UTF-8")
class(plots$Plot)

# convert from a factor variable to characters
plots$Plot <- as.character(plots$Plot)
head(plots$Plot, 3)

# load text mining package
library(tm)

# load snowball package that contains stemming algorithm
library(SnowballC)

# convert plots into a corpus
corpus <- Corpus(VectorSource(plots$Plot))

# inspect first entry in the corpus
corpus[[1]]$content

# convert terms to lowercase
corpus <- tm_map(corpus, content_transformer(tolower))

# remove punctuation
corpus <- tm_map(corpus, removePunctuation)

# remove stop words from corpus
corpus <- tm_map(corpus, removeWords, stopwords("english"))

# reduce terms to stems in corpus
corpus <- tm_map(corpus, stemDocument, "english")

# remove white space from text corpus
corpus <- tm_map(corpus, stripWhitespace)

# convert corpus to text document
corpus <- tm_map(corpus, PlainTextDocument)

# inspect first entry in the corpus
corpus[[1]]$content

# load the word cloud package
library(wordcloud)

clean.text <- function(some_txt)
{
  some_txt = gsub("&amp", "", some_txt)
  
  some_txt = gsub("(RT|via)((?:\b\\W*@\\w+)+)", "", some_txt)
  
  some_txt = gsub("@\\w+", "", some_txt)
  
  some_txt = gsub("[[:punct:]]", "", some_txt)
  
  some_txt = gsub("[[:digit:]]", "", some_txt)
  
  some_txt = gsub("http\\w+", "", some_txt)
  
  some_txt = gsub("[ t]{2,}", "", some_txt)
  
  some_txt = gsub("^\\s+|\\s+$", "", some_txt)
  
  # define "tolower error handling" function
  
  try.tolower = function(x)
    
  {
    
    y = NA
    
    try_error = tryCatch(tolower(x), error=function(e) e)
    
    if (!inherits(try_error, "error"))
      
      y = tolower(x)
    
    return(y)
    
  }
  
  some_txt = sapply(some_txt, try.tolower)
  
  some_txt = some_txt[some_txt != ""]
  
  names(some_txt) = NULL
  
  return(some_txt)
  
}

clean_text = clean.text(corpus)

corpus <- Corpus(VectorSource(clean_text))
tdm = TermDocumentMatrix(corpus, control = list(removePunctuation = TRUE,
      stopwords("english"), removeNumbers = TRUE, tolower = TRUE))

#we define tdm as matrix
m = as.matrix(tdm) 

#now we get the word orders in decreasing order
word_freqs = sort(rowSums(m), decreasing=TRUE) 
#we create our data set
dm = data.frame(word=names(word_freqs), freq=word_freqs) 

#and we visualize our data
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2")) 

# create a frequency word cloud
wordcloud(
  words = corpus,
  max.words = 50
)

# load the words data from a csv file
words <- read.csv("Words.csv")
head(words, 10)

# create a quantitative word cloud
wordcloud(
  words = words$Term,
  freq = words$Box.Office,
  # no more than 50 words will be displayed in the cloud
  max.words = 50,
  scale = c(2, 0.1)
)

# create a gradient color palette
palette <- brewer.pal(
  n = 9,
  name = "Oranges"
)

# map critic score to colors
colors <- palette[cut(words$Critic.Score, 9)]

# create a word cloud with color
wordcloud(
  words = words$Term,
  freq = words$Box.Office,
  # no more than 50 words will be displayed in the cloud
  max.words = 50,
  scale = c(2, 0.5),
  colors = colors,
  ordered.colors = TRUE
)

# animating data visualizations
# load releases by studio by month
studios <- read.csv("Studios.csv")
head(studios, 5)

# create discrete color palette
palette <- brewer.pal(10, "Set3")

# get the last period data
period <- studios[studios$Period == 183, ]

# create a scatter plot of last period (July 2015)
plot(
  x = period$Count,
  y = period$Box.Office,
  xlim = c(0, 225),
  ylim = c(0, 17500),
  col = palette[as.factor(period$Studio)],
  pch = 19,
  cex = 2,
  main = "Top 10 studios (2000-2015)",
  sub = period$Release,
  xlab = "Movies released",
  ylab = "Box office revenue ($M)"
)

# create animation function
animate <- function() {
 for(i in 1:183) {
   # get current period data
   period <- studios[studios$Period == i,]
   
   # create a scatter plot of current period
   plot(
     x = period$Count,
     y = period$Box.Office,
     xlim = c(0, 225),
     ylim = c(0, 17500),
     col = palette[as.factor(period$Studio)],
     pch = 19,
     cex = 2,
     main = "Top 10 studios (2000-2015)",
     sub = period$Release,
     xlab = "Movies released",
     ylab = "box office revenue ($M)"
   )
   
   # display legend
   legend(
     x = "bottomright",
     as.character(levels(as.factor(period$Studio))),
     col = palette[as.factor(period$Studio)],
     pch = 19,
     cex = 0.75
   )
 }
}

library(animation)

# set the frame rate
ani.options(
  interval = 0.067,
  ani.width = 640,
  ani.height = 480
)

saveVideo(
  expr = animate(),
  video.name = "Studios.mp4",
  ffmpeg = "/usr/bin/ffmpeg",
  # 15 frames per second
  other.opts = "-r 15 -pix_fmt yuv420p"
)

# create a 3D animated scatter plot
movies <- read.csv("Movies.csv")

movies2014 <- movies[movies$Year == 2014, ]

library(lattice)

# create animation function
animate2 <- function() {
  for(i in 1:360)  {
    # create a 3D scatter plot using current angle
    plot <- cloud(
      x = Box.Office ~ Critic.Score * Runtime,
      data = movies2014,
      type = c("p", "h"),
      pch = 16,
      main = "Runtime, critic score, and box office revenue",
      xlab = "Runtime\n(min)",
      ylab = "Critic\nscore\n(%)",
      zlab = "Box office\n revenue\n($M)",
      # indicates rotation matrix
      R.mat = diag(4),
      # rotating on the z axis
      screen = list(
        z = i,
        y = 0,
        x = -60
      )
    )
    
    # draw a plot
    print(plot)
  }
}

saveVideo(
  expr = animate2(),
  video.name = "Cloud.mp4",
  ffmpeg = "/usr/bin/ffmpeg",
  # 15 frames per second
  other.opts = "-r 15 -pix_fmt yuv420p"
)

# create an animated globe
countries2 <- read.csv("Countries2.csv")

library(ggplot2)

# create an animation function
animate3 <- function() {
  for(i in -180:180) {
    # project a map centered at current longitude
    plot <- ggplot(
      data = countries2) + 
      borders(
        database = "world",
        colour = "grey60",
        fill = "grey90") +
      coord_map(
        projection = "ortho",
        orientation = c(0, i, 0)) +
      geom_polygon(
        aes(
          x = Longitude,
          y = Latitude,
          group = Group,
          fill = Count
        ),
        color = "grey60") +
      scale_fill_gradient(
        low = "white",
        high = "red",
        guide = FALSE) + 
      xlab("") +
      ylab("") +
      theme(
        panel.background = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank())
    
    print(plot)
  }
}

# create video of animation
# note: this may take hours
saveVideo(
  expr = animate3(),
  video.name = "Globe.mp4",
  ffmpeg = "/usr/bin/ffmpeg",
  # 15 frames per second
  other.opts = "-r 15 -pix_fmt yuv420p"
)

# create interactive data visualizations using shiny
library(shiny)

# create a ui
ui <- fluidPage("Hello World!")

# create a server
server <- function(input, output) {}

# create a shiny app
shinyApp(
  ui = ui,
  server = server
)

# create a ui with I/O controls
ui <- fluidPage(
  titlePanel("Input and output"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "number",
        label = "choose a number",
        min = 0,
        max = 100,
        value = 25
      )
    ),
    mainPanel(
      textOutput(
        outputId = "text")
    )
  )
)

# create a server that maps input to output
server <- function(input, output) {
  output$text <- renderText({
    paste(
      "you selected", input$number)
  })
}

shinyApp(
  ui = ui,
  server = server
)

library(RColorBrewer)  
library(dplyr)

movies <- read.csv("Movies.csv")
colors <- brewer.pal(4, "Set3")

# create a user interface code
ui <- fluidPage(
  titlePanel("Interactive movie data"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "year",
        label = "year",
        min = 2000,
        max = 2016,
        value = c(2000, 2016),
        sep = ""
      ),
      checkboxGroupInput(
        inputId = "rating",
        label = "Rating",
        choices = c("G", "PG","PG-13","R"),
        selected = c("G", "PG","PG-13","R")
      ),
      textInput(
        inputId = "title",
        label = "title"
      )
    ),
    mainPanel(
      plotOutput(
        outputId = "plot")
    )
  )
)

# create a server
server <- function(input, output) {
  output$plot <- renderPlot({
   subset <- movies %>% 
     filter(Year >= input$year[1]) %>%
     filter(Year <= input$year[2]) %>%
     filter(Rating %in% input$rating) %>%
     filter(grepl(input$title, Title)) %>%
     as.data.frame()
   plot(
     x = subset$Critic.Score,
     y = subset$Box.Office,
     col = colors[as.factor(subset$Rating)],
     pch = 19,
     cex = 1.5,
     xlim = c(0, 100),
     ylim = c(0, 800),
     xlab = "Critic score (%)",
     ylab = "box office revenue ($M)"
   )
   legend(
     x = "topleft",
     as.character(levels(as.factor(movies$Rating))),
     col = colors[1:4],
     pch = 19,
     cex = 1.5
   )
  }
  )
}

shinyApp(
  ui = ui,
  server = server
)
