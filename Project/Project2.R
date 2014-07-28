# On lance le modele sur la table entiere, maintenant qu'on sait
#qu'il est valable

library(caret)
library(foreach)
library(doParallel)
cl<-makeCluster(detectCores())
registerDoParallel(4)

# Getting the data and partitioning
setwd("D:/Mes documents/Coursera/Practical Machine Learning/Project")
#setwd("C:/Documents and Settings/jean-pierre.sylvan/Mes documents/Practical_ML/Project")
pml_training=read.csv(file="pml-training.csv",header=T,sep=,)
pml_training=pml_training[,-1]
pml_testing=read.csv(file="pml-testing.csv",header=T,sep=,)
pml_testing=pml_testing[,-1]

#We keep only the feature which are not factors, anyway the factor feature are all empty
#And only the features where mean(is.na)<90%

num_NA=vector(mode="numeric",length=dim(pml_training)[2])
for (i in 1:length(num_NA)) {
  num_NA[i] = mean(is.na(pml_training[,i]))
}

Type=character(dim(pml_training)[2])
for (i in 1:length(Type)) {
  Type[i] = class(pml_training[,i])
}
Num = (Type == "numeric")|(Type == "integer")


table = pml_training[,Num & (num_NA<0.9)]
pca=preProcess(x=table,method="pca",thresh=0.9)
trainPC = predict(pca,table)
modFit = train(pml_training$classe~.,data=trainPC,method="rf")

# Prediction de classe sur la table pml_testing avec modFit
pml_testing2=pml_testing[,(num_NA<0.9)&Num]
pml_testing2PC=predict(pca,newdata=pml_testing2)
predict(modFit,newdata=pml_testing2PC)