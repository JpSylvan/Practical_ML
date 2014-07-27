# Code Coursera
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# Code Jp

set.seed(62433)
treeFit = train(diagnosis~.,data=training,method="rf")
treePred = predict(treeFit,testing)
gbmFit = train(diagnosis~.,data=training,method="gbm",verbose=F)
gbmPred = predict(gbmFit,testing)
ldaFit = train(diagnosis~.,data=training,method="lda")
ldaPred = predict(ldaFit,testing)
comboTrain = data.frame(treePred,gbmPred,ldaPred,diagnosis=testing$diagnosis)
comboFit = train(diagnosis~.,method="rf",data=comboTrain)

confusionMatrix(treePred,testing$diagnosis)$overall[1]
confusionMatrix(gbmPred,testing$diagnosis)$overall[1]
confusionMatrix(ldaPred,testing$diagnosis)$overall[1]
confusionMatrix(predict(comboFit,testing),testing$diagnosis)$overall[1]

#Same as boosting and equal to tree and lda