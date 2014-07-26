#Code de Coursera
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

#Code Jp
dim(training) #131 colonnes
names(training) #12 variables qui comment par IL
X = training[,58:69]
pca=preProcess(X,method="pca",thresh=0.9)
print(pca)