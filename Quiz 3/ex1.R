# Code Coursera 

install.packages("rpart.plot")
install.packages("rattle")
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(rattle)
library(rpart.plot)

# Code Jp

inTrain = createDataPartition(y=segmentationOriginal$Case,list=F)
training = segmentationOriginal[segmentationOriginal$Case=='Train',]
testing = segmentationOriginal[segmentationOriginal$Case=='Test',]
set.seed(125)
modFit = train(Class~.,data=training,method="rpart")
print(modFit)
fancyRpartPlot(modFit$finalModel)

# Du coup pour : 
# a. TotalIntench2 = 23,000; FiberWidthCh1 = 10; PerimStatusCh1=2 
# b. TotalIntench2 = 50,000; FiberWidthCh1 = 10;VarIntenCh4 = 100 
# c. TotalIntench2 = 57,000; FiberWidthCh1 = 8;VarIntenCh4 = 100 
# d. FiberWidthCh1 = 8;VarIntenCh4 = 100; PerimStatusCh1=2 
#On a les réponses suivantes : 
# PS
# WS
# PS
# Not possible to predict