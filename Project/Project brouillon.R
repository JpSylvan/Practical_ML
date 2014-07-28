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
num_NA=vector(mode="numeric",length=dim(pml_training)[2])
for (i in 1:length(num_NA)) {
  num_NA[i] = mean(is.na(pml_training[,i]))
}

Type=character(dim(pml_training)[2])
for (i in 1:length(Type)) {
  Type[i] = class(pml_training[,i])
}
Num = (Type == "numeric")|(Type == "integer")

#We keep only the feature which are not factors, anyway the factor feature are all empty
#And only the features where mean(is.na)<90%
pml_training=pml_training[,(num_NA<0.9)&Num]
pml_testing=pml_testing[,(num_NA<0.9)&Num]

pca=preProcess(x=pml_training[,Num],method="pca",thresh=0.9)
trainPC = predict(pca,pml_training[,Num])
#modFit = train(pml_training$classe~.,data=trainPC,method="rf")
testPC=predict(pca,newdata=pml_testing[,Num])
modFit = train(pml_training$classe~.,data=trainPC,method="glm")
predict(modFit,newdata=testPC)
confusionMatrix(pml_testing$classe,predict(modFit,newdata=testPC))

#Just understood pml_testing doesn't contain the classe feature, so we cannot run test on it.
#We need to do a partition
pml_training=read.csv(file="pml-training.csv",header=T,sep=,)
pml_training=pml_training[,-1]
pml_testing=read.csv(file="pml-testing.csv",header=T,sep=,)
pml_testing=pml_testing[,-1]
inTrain = createDataPartition(pml_training$classe, p = 3/4)[[1]]
training = pml_training[inTrain,]
testing = pml_training[-inTrain,]

num_NA=vector(mode="numeric",length=dim(training)[2])
for (i in 1:length(num_NA)) {
  num_NA[i] = mean(is.na(training[,i]))
}

#We keep only the feature which are not factors, anyway the factor feature are all empty
training=training[,num_NA<0.9]
testing=testing[,num_NA<0.9]
Type=character(dim(training)[2])
for (i in 1:length(Type)) {
  Type[i] = class(training[,i])
}
Num = (Type == "numeric")|(Type == "integer")

pca=preProcess(x=training[,Num],method="pca",thresh=0.9)
print(pca)
trainPC = predict(pca,training[,Num])
#modFit = train(pml_training$classe~.,data=trainPC,method="rf")
testPC = predict(pca,newdata=testing[,Num])
modFit = train(training$classe~.,data=trainPC,method="glm")
predict(modFit,newdata=testPC)
confusionMatrix(pml_testing$classe,predict(modFit,newdata=testPC))