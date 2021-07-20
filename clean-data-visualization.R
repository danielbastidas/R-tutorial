# cleaning up data visualization
movies <- read.csv("Movies.csv")

# create a frequency bar chart with defaults
plot(as.factor(movies$Rating))

# add context to out bar chart
plot(
  as.factor(movies$Rating),
  main = "count of movies by MPAA rating category",
  xlab = "MPAA rating category",
  ylab = "count of movies"
)

library(RColorBrewer)

# create a color palette
palette <- brewer.pal(9, "Pastel1")

# clean up our bar chart
plot(
  as.factor(movies$Rating),
  col = palette[2],
  border = NA,
  main = "count of movies by MPAA rating category",
  xlab = "MPAA rating category",
  ylab = "count of movies"
)

# save as a PNG image
png(
  filename = "count-of-movies-by-rating.png",
  width = 640,
  height = 480
)

plot(
  as.factor(movies$Rating),
  col = palette[2],
  border = NA,
  main = "count of movies by MPAA rating category",
  xlab = "MPAA rating category",
  ylab = "count of movies"
)

# after this command the file is saved
dev.off()

# save ggplot2 data visualization
?ggsave
