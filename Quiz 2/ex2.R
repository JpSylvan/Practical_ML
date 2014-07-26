library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
for (i in 1:dim(training)[2]) {
  print(class(training[,i]))
}

test=cut2(training$FlyAsh,g=2)
plot(training$CompressiveStrength,col=test)

#FlyAsh n'explique pas l'effet escalier et on peut supposer que c'est pareil pour les autres variables 