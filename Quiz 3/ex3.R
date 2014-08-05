# Code Coursera 
library(pgmm)
data(olive)
olive = olive[,-1]

# Code Jp

library(caret)
library(rattle)
library(rpart.plot)
modFit = train(Area~.,data=olive,method="rpart")
print(modFit$finalModel)
newdata = as.data.frame(t(colMeans(olive)))
predict(modFit,newdata=newdata[,-1])