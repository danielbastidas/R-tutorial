# install package from github
require(devtools)
install_github('ramnathv/rCharts')

library(rCharts)
library(ggplot2)

rPlot(price ~ carat | cut, color='cut', data = diamonds, type='point')
