library(lubridate)

# get the week day, only the number
wday('2021-04-08')
# get the week day, get the name of the day
wday('2021-04-08', label=TRUE)

birthDate <- ymd(19830408)
wday(birthDate, label = TRUE)
