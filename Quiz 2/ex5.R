#Code Coursera

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

#Code Jp

#Reshaping
dim(training) #131 colonnes
names(training) #12 variables qui comment par IL
X = data.frame(training[,58:69],diagnosis=training$diagnosis)

#GLM Without preprocessing
modelFit = train(diagnosis~.,data=X,method="glm")
acc1 = mean(predict(modelFit,newdata=testing)==testing$diagnosis)
confusionMatrix(testing$diagnosis,predict(modelFit,newdata=testing))
#GLM With PCA preprocessing
preProc = preProcess(X[,-13],method="pca",thresh=80)
trainPC = predict(preProc,X[,-13])
modelFit = train(X$diagnosis~.,data=trainPC,method="glm")
testPC=predict(preProc,newdata=testing[,58:69])
confusionMatrix(testing$diagnosis,predict(modelFit,newdata=testPC))