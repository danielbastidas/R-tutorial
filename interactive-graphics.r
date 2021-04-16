# install package from github
require(devtools)
install_github('ramnathv/rCharts')

library(rCharts)
library(ggplot2)

rPlot(price ~ carat | cut, color='cut', data = diamonds, type='point')

# the following graph allows you to see the values of the data in the graphic
library(ggvis)
library(ggplot2)

content <- function(data) {
  paste0("Carat: ", data$carat, " Price", as.character(data$price))
}

diamonds %>% 
  ggvis(~carat, ~price, fill=~cut) %>%
  layer_points(opacity:=1/2) %>%
  add_tooltip(content, "hover")
