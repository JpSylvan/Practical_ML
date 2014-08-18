
library(caret)
library(foreach)
library(doParallel)

# Getting the data and partitioning
setwd("D:/Mes documents/Coursera/Practical Machine Learning/Project")
#setwd("C:/Documents and Settings/jean-pierre.sylvan/Mes documents/Practical_ML/Project")
pml_training=read.csv(file="pml-training.csv",header=T,sep=,)
pml_training=pml_training[,-1]
pml_testing=read.csv(file="pml-testing.csv",header=T,sep=,)
pml_testing=pml_testing[,-1]

#We keep only the feature which are not factors, anyway the factor feature are all empty
#And only the features where mean(is.na)<90%
Type=character(dim(pml_training)[2])
for (i in 1:length(Type)) {
    Type[i] = class(pml_training[,i])
}
Num = (Type == "numeric")|(Type == "integer")

num_NA=vector(mode="numeric",length=dim(pml_training)[2])
for (i in 1:length(num_NA)) {
    num_NA[i] = mean(is.na(pml_training[,i]))
}

pml_training2 = pml_training[,Num & (num_NA<0.9)]

#Preprocessing of the data with PCA
pca=preProcess(x=pml_training2,method="pca",thresh=0.9)
trainPC = predict(pca,plm_training2)

#Random Forest with Cross-Validation to see if the model based on a training set applies to a testing set
cv = trainControl(method="cv")
modFit = train(pml_training$classe~.,data=trainPC,method="rf",trControl=cv)

# Prediction of "classe" on the 20 obs given by Coursera in the pml_testing table
pml_testing2=pml_testing[,(num_NA<0.9)&Num]
pml_testing2PC=predict(pca,newdata=pml_testing2)
predict(modFit,newdata=pml_testing2PC)

