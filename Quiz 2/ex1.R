adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50, list=F)
training = adData[trainIndex,]
testing = adData[-trainIndex,]