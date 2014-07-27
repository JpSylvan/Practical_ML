# Code Coursera 

library(lubridate)  # For year() function below
setwd("D:/Mes Documents/Coursera/Practical Machine Learning")
dat = read.csv("Quiz 4/gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

# Code Jp

library(forecast)
modFit = bats(tstrain)

# Don't know yet what the result is, but I know it's not 93%
# It's 96%