library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

# Code Jp

vowel.train$y = as.factor(vowel.train$y)
vowel.test$y = as.factor(vowel.test$y)
set.seed(33833)
inTrain = train(y~.,data=vowel.train,method="rf")
vI <- varImp(inTrain$finalModel)
vI$sample <- row.names(vI); vI <- vI[order(vI$Overall, decreasing = T),]
vI

#Personne n'arrive au résultat proposé par Coursera. Il faut choisir :
x.2
x.1
x.5
x.6
x.8
x.4
x.9
x.3
x.7
x.10