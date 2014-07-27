# Code Coursera 

install.packages("ElemStatLearn")
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

# Code Jp

set.seed(13234)
inTrain = train(chd~age+alcohol+obesity+tobacco+typea+ldl,method="glm",family="binomial",data=trainSA)
missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
missClass(trainSA$chd,predict(inTrain,trainSA))
missClass(testSA$chd,predict(inTrain,testSA))