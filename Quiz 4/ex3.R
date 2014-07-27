set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

# Code Jp

set.seed(233)
modFit = train(CompressiveStrength~.,method="lasso",data=training,trace=T)
plot.enet(modFit$finalModel, xvar = "penalty", use.color = TRUE)

# Cement is the last one to be set to 0 as lambda increased