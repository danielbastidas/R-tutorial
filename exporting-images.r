library(ggplot2)
getwd()
setwd('~/git-repo/R-tutorial')

# with this line we are setting the device that will contain the image that is generated in the following line
png('diamonds.png')
plot(diamonds$color)
dev.off()

png('diamonds-color.png')
ggplot(diamonds, aes(x=color)) + geom_bar()
dev.off()

ggplot(diamonds, aes(x=color, fill=color)) + geom_bar()
ggsave("diamonds-color-2.png")
