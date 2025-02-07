library(tigerstats)
library(caret)
library(corrplot)
library(ggplot2)
library(car)
library(rpart)
library(rpart.plot)
library(e1071)
library(pROC)
library(randomForest)
library(cluster)
df<-read.csv(file="/Users/liankairen/Desktop/Northeastern/ALY 6040/Project/Pokemon.csv")
sum(is.na(df))
summary(df)
str(df)
attach(df)
##number of legendary
ggplot(df) + geom_bar(aes(x = Legendary, fill = Legendary))
df$Legendary[df$Legendary=="False"]=0
df$Legendary[df$Legendary=="True"]=1
sum(df$Legendary==1)
sum(df$Legendary==0)

###corrplot
df$Legendary<-as.numeric(df$Legendary)
M <- cor(df[c(5:11,13)]) 
M
corrplot(M, method = "circle",type="upper")
df$Legendary<-as.factor(df$Legendary)

###barplot and histgram
table1<-table(Type.1)
table2<-table(Type.2)
barplot(table1)
barplot(table2)
par(mfrow = c(2, 2))
hist(Total, main="Total")
hist(HP, main="HP")
hist(Attack, main="Attack")
hist(Defense, main="Defense")
hist(Sp..Atk, main="Special Attack")
hist(Sp..Def, main="Special Defense")
hist(Speed, main = "Speed")
hist(Generation,main = "Generation")

###boxplot
boxplot(Total, main="Total")
boxplot(HP, main="HP")
boxplot(Attack, main="Attack")
boxplot(Defense, main="Defense")
boxplot(Sp..Atk, main="Special Attack")
boxplot(Sp..Def, main="Special Defense")
boxplot(Speed, main = "Speed")
boxplot(Generation,main = "Generation")

###some attributes comparison
par(mfrow=c(1,1))
plot(Attack,Defense,xlab="Attack",ylab = "Defence",col=as.factor(df[,13]),main="Attack vs. Defense")
plot(Sp..Atk,Sp..Def,xlab = "SP Attack",ylab = "SP Defence",col=as.factor(df[,13]),main="SP Attack vs. SP Defense")
###1.	If the ratio of attack and defence have a positive relationship vs. HP?
plot(HP,Attack,col=as.factor(df[,13]),main="HP vs. Attack")
plot(HP,Defense,col=as.factor(df[,13]),main="HP vs. Defense")
plot(Attack,Sp..Atk,col=as.factor(df[,13]),xlab="Attack", ylab="SP Attack",main="Attack vs. SP Attack")
plot(Defense,Sp..Def,col=as.factor(df[,13]),xlab="Defence", ylab="SP Defence",main="Defence vs. SP Defence")

###attack and defense in type 1
###2.	Which type 1 is with the most potent attack power?
plot(Attack,Defense,xlab="Attack",ylab = "Defence",col=as.factor(df[,3]),main="Attack vs. Defense")

###chi-square test
chisq1 <- chisq.test(HP,Attack)
chisq1
chisq2<-chisq.test(HP,Defense)
chisq2


###Set train and test set
set.seed(123)
df0=df[df$Legendary==0,]
dim(df0) #735 
df1=df[df$Legendary==1,]
dim(df1) #65
#training / testing set 
train=rbind(df0[1:40,], df1[1:40,])
dim(train) #40 LEGENDARY, 40 NON-LEGENDARY
test=rbind(df0[41:735,], df1[41:65,])

#1,Decision tree
modelDT<- rpart(Legendary ~HP+Attack+Defense+Sp..Atk+Sp..Def+Speed, data=train)
summary(modelDT)
rpart.plot(modelDT,type=2,main="Decision Tree Plot")
preDT<-predict(modelDT,test,type="class")
DT.cf<-caret::confusionMatrix(as.factor(preDT),as.factor(test$Legendary))
DT.cf

preDT2<-predict(modelDT,test,type = 'prob')
aucDT<-auc(test$Legendary,preDT2[,2])
plot(roc(test$Legendary,preDT2[,2]),main="ROC for Decision Tree")
aucDT

#2,Random forest
set.seed(123)
modelRF<-randomForest(as.factor(Legendary) ~HP+Attack+Defense+Sp..Atk+Sp..Def+Speed,data=train, importance=T)
modelRF
plot(modelRF,main="Random Forest Plot")

preRF<- predict(modelRF,newdata=test,type="class")
preRF
RF.cf<-caret::confusionMatrix(as.factor(preRF),as.factor(test$Legendary))
RF.cf

preRF2<-predict(modelRF,test,type = 'prob')
aucRF<-auc(test$Legendary,preRF2[,2])
plot(roc(test$Legendary,preRF2[,2]),main="ROC of Random Forest")
aucRF


#3 Kernel SVM
set.seed(123)
modelSVM1<-svm(Legendary ~HP+Attack+Defense+Sp..Atk+Sp..Def+Speed+Generation, 
              data=train,kernel="radial",cost=1,scale=F)
modelSVM2<-svm(Legendary ~HP+Attack+Defense+Sp..Atk+Sp..Def+Speed+Generation, 
              data=train,kernel="linear",cost=1,scale=F)
modelSVM3<-svm(Legendary ~HP+Attack+Defense+Sp..Atk+Sp..Def+Speed+Generation, 
              data=train,kernel="sigmoid",cost=1,scale=F)
modelSVM4<-svm(Legendary ~HP+Attack+Defense+Sp..Atk+Sp..Def+Speed+Generation, 
              data=train,kernel="polynomial",cost=1,scale=F)
modelSVM4
summary(modelSVM4)
plot(modelSVM1,train,HP~Defense,main="SVM Plot")
plot(modelSVM2,train,HP~Defense,main="SVM Plot")
plot(modelSVM3,train,HP~Defense,main="SVM Plot")
plot(modelSVM4,train,HP~Defense,main="SVM Plot")

preSVM<-predict(modelSVM4, newdata=test)
preSVM
SVM.cf<-caret::confusionMatrix(as.factor(preSVM),as.factor(test$Legendary))
SVM.cf
preSVM2<-predict(modelSVM4,newdata=test,type = 'prob')
roc(response=test$Legendary,predictor=as.numeric(preSVM2))
plot(roc(response=test$Legendary,predictor=as.numeric(preSVM2)),main="ROC of SVM")


###Clustering
df1=df[,1:5]
df1
df2=subset(df1,select = -c(Name,X.,Type.2))
df2
head(df2)
df3=subset(df2,select = -c(Type.1))
df3

df4=subset(df,select = -c(Name,X.,Type.1,Type.2,Legendary))
df4
model1=kmeans(df4,3)
clusplot(df4,model1$cluster)
model1

clusplot(df4,model1$cluster,color=T,shade=T)

df4=subset(df,select = -c(Name,X.,Type.1,Type.2,Legendary))
df4
model2=kmeans(df4,4)
clusplot(df4,model2$cluster)
model2

clusplot(df4,model2$cluster,color=T,shade=T)

df4=subset(df,select = -c(Name,X.,Type.1,Type.2,Legendary))
df4
model3=kmeans(df4,5)
clusplot(df4,model3$cluster)
model3

clusplot(df4,model3$cluster,color=T,shade=T)



