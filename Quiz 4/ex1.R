# Code Coursera

library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

# Code Jp

vowel.train$y = as.factor(vowel.train$y)
vowel.test$y = as.factor(vowel.test$y)

set.seed(33833)
treeFit = train(y~.,data=vowel.train,method="rf")
confusionMatrix(predict(treeFit,vowel.test),vowel.test$y)

set.seed(33833)
gbmFit = train(y~.,data=vowel.train,method="gbm",verbose=F)
confusionMatrix(predict(gbmFit,vowel.test),vowel.test$y)

agree=predict(gbmFit,vowel.test)==predict(treeFit,vowel.test)
confusionMatrix(predict(gbmFit,vowel.test)[agree==T],vowel.test$y[agree==T])
confusionMatrix(predict(treeFit,vowel.test)[agree==T],vowel.test$y[agree==T])