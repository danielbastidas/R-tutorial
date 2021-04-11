url <- 'https://s3-us-west-2.amazonaws.com/downloads.fractracker.org/PA/PA_UncDWs_07292013.zip'
download.file(url,'tmp.zip', method = 'curl', mode ='wb')
df <- read.csv(unz('tmp.zip', 'PA_UncDWs_07292013.csv'))
head(df)
library(maps)

map('state', 'pennsylvania')
points(df$LONGITUDE, df$LATITUDE, cex=0.1)

library(mapproj)

map('state')
map('state', proj = 'azequidistant')
map('state', proj = 'orthographic')
map('state', proj = 'bonne', param=65)

map()
map(proj = 'orthographic')

library(ggmap)
ggmap(get_map())
# google now requires an API key to access the map data. So what do we said, fuck google I'm not paying it any
# shit
