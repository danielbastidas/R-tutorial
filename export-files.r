library(ggplot2)
df <- diamonds
setwd('~/git-repo/R-tutorial')

write.table(df,
            file='diamonds.csv',
            sep=',',
            col.names=colnames(diamonds),
            qmethod='escape')

write.csv(df, 'diamonds2.csv')

# how to open a program from R
system('meld diamonds.csv diamonds2.csv')

library(foreign)
# the following export two files used by statistical applications. The txt file contains the data and
# the sps file contains a metada about the data contained in the txt file
write.foreign(df, 'diamonds.txt', 'diamonds.sps', package = 'SPSS')

# using the RData format. Notice the RData format is lightweight
save(df, file = 'diamonds.RData')
# remove the data frame from the app to show the load functionality
rm(df)
load('diamonds.RData')
