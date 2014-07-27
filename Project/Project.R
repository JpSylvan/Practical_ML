library(caret)

# Getting the data
setwd("D:/Mes documents/Coursera/Practical Machine Learning/Project")
pml_training=read.csv(file="pml-training.csv",header=T,sep=,)
pml_training=pml_training[,-1]
pml_testing=read.csv(file="pml-testing.csv",header=T,sep=,)
pml_testing=pml_testing[,-1]
# Ploting the data (the variable we want to predict is classe)

dim(pml_training)
plot(pml_training$classe)

# Preprocessing the data

# Too many NA, let's check the features with to many NA
num_NA=vector(mode="numeric",length=length(dim(pml_training)[2]))
for (i in 1:length(num_NA)) {
  num_NA[i] = mean(is.na(pml_training[,i]))
}

pml_training=pml_training[,num_NA<0.9]
Type=character(dim(pml_training)[2])
for (i in 1:length(Type)) {
  Type[i] = class(pml_training[,i])
}
Num = (Type == "numeric")|(Type == "integer")
pca=preProcess(x=pml_training[,Num],method="pca",thresh=0.9)
trainPC = predict(pca,pml_training[,Num])
modFit = train(pml_training$classe~.,data=trainPC,method="rf")
testPC=predict(pca,newdata=pml_testing[,Num])
confusionMatrix(pml_testing$classe,predict(modFit,newdata=testPC))

