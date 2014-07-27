# Code Coursera

set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

# Code Jp

set.seed(325)
mod <- svm(CompressiveStrength ~ ., data = training)
pred <- predict(mod, testing)
sqrt(sum((pred - testing$CompressiveStrength)^2)/length(pred)) #6.72