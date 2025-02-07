install.packages("TraMineR")
library(TraMineR)
library(sqldf)
library(dplyr)
library(psych)
library(car)
library(Matrix)
df<-read.csv(file="/Users/liankairen/Desktop/ALY 6080/20220413_Northeastern_AwanTunai_Capstone_Data.csv")
sum(is.na(df))
sum(is.na(df$sku_id))
sum(is.na(df$date))
sum(is.na(df$price))
summary(df)
str(df)

###EDA
attach(df)
a<-hist(merchant_id, main="merchant_id")
sort(table(merchant_id),decreasing=TRUE)[1:3]
b<-hist(order_id, main="order_id")
sort(table(order_id),decreasing=TRUE)[1:3]
sqldf("select count(distinct(merchant_id)) from df")

###Merchant 1607
t1<-df[merchant_id=="1607",]
sum(is.na(t1))
summary(t1)
t1<-arrange(t1,t1$order_id)
head(t1,5)
boxplot(t1$price,main="Price of Merchant ID 1607")
options(scipen=999)
hist(t1$order_id, main="order_id")
sqldf("select count(distinct(order_id)) from t1")
sqldf("select count(distinct(date)) from t1")
sqldf("select count(distinct(sku_id)) from t1")
scatterplot(t2$date~t2$price,xlab="Date ", ylab="Price",ylim=c(1000,1000000) ,pch=19)
###Merchant 1477
t2<-df[merchant_id=="1477",]
sum(is.na(t2))
t2<-arrange(t2,t2$order_id)
head(t2,5)
options(scipen=999)
hist(t2$order_id, main="order_id")
sqldf("select count(distinct(order_id)) from t2")
sqldf("select count(distinct(date)) from t2")

t2<-arrange(t2,t2$date)
head(t2,5)
plot(t2)
t2<-arrange(t2,t2$price)

###Merchant 1196
t3<-df[merchant_id=="1196",]
sum(is.na(t3))
plot(t3)
t3<-arrange(t3,t3$order_id)
sqldf("select count(distinct(id)) from t3")
head(t1,5)
head(t3,5)
t3<-arrange(t3,t3$price)

###TraMinR Sqeuencial Plot
df.labels <- c("Merchant ID", "SKU ID", "Date",
                 "Top Cat ID", "Sub Cat ID", "Price")
df.scodes <- c("MID","SKU","Date","TCat","SCat","P")
df.seq <- seqdef(df, 3:8, states=df.scodes, labels=df.labels)

seqiplot(df.seq, withlegend=T) 


###Time series
library(ggplot2)
df$date <- as.Date(df$date)
str(df)
ggplot(data = t1, aes(x = date, y = price)) +
  geom_bar(stat = "identity", fill = "black") +
  labs(title = "Daily Price",
       subtitle = "2021",
       x = "Date", y = "Pirce($)")

ggplot(data = t1, aes(x = date, y = sku_id)) +
  geom_bar(stat = "identity", fill = "black") +
  labs(title = "Daily Price",
       subtitle = "2021",
       x = "Date", y = "Price($)")

scatterplot(t1$price~t1$date,xlab="Date ", ylab="Price",pch=19)
str(t2)

##########Sequntial Plot
unique(df$sku_id)

df$sku_id <- as.character(df$sku_id)

df2 <- filter(df, df$sku_id %in% c('33','1204','14766','2740','1558','468','8','360','2037'))
sort(table(df2$sku_id))
length(unique(df2$merchant_id))
df2$merchant_id <- as.character(df2$merchant_id)

df2 <- df2[order(df2$merchant_id, df2$date),c(3,4,5)]

############################################################ Time Related
df2$date <- as.Date(df2$date)
df2$time_elapsed <- c(rep(0,nrow(df2)))
uniq <- df2[!duplicated(df2$merchant_id),]
for (j in 1:nrow(uniq)) {
  for (i in 1:nrow(df2))  {
    if (df2$merchant_id[i] == uniq$merchant_id[j]){
      df2$time_elapsed[i] <- abs(difftime(df2[i,3], uniq[j,3], units = c('days')))
    }
  }
}
########################################################################
library(reshape2)
library(splitstackshape)

df3 <- df2[,c(1,2)]
df3 <- getanID(df3, 'merchant_id')[]


seqset <- dcast(df3, merchant_id ~ .id, value.var="sku_id", fill=0)

seq.lab <- c('0','8','33','360','468','1204','1558','2037','2740','14766')
seq.col <- c('white','red','blue','green','yellow','orange','purple','lightblue','brown','gray')
def.seq.short <- seqdef(seqset, 2:21, labels = seq.lab, cpal = seq.col)
## All sequences
plot(def.seq.short, idxs=0, space = 0, border=NA)
## 10 most common sequences
plot(def.seq.short)
#################Phase 2 Sequential Plot
def.seq.short <- seqdef(seqset, 2:21, labels = seq.lab, cpal = seq.col)

HAMdist <- seqdist (def.seq.short, method = "HAM")
distance <- cbind(rep(1:nrow(def.seq.short), each = nrow(def.seq.short)), rep(1:nrow(def.seq.short),nrow(def.seq.short)),as.vector(HAMdist))
distance1 <- distance[(distance[,2]>distance[,1]),]
colnames(distance1) <- c("base","compare","sact")
distance1 <- as.data.frame(distance1)

edgeOrdering <- function(indata){
  indat <- cbind(base = indata$base, compare = indata$compare, sact = indata$sact)
  indat <- indat[order(indat[,3], decreasing = TRUE),]
  n <- dim(indat)[1]
  Nrow <- max(c(indat[,1], indat[,2]))
  
  #initialization
  left_orig <- left <- right_orig <- right <- list()
  left_orig[1:n] <- left[1:n] <- indat[,1]
  right_orig[1:n] <- right[1:n] <- indat[,2]
  cl_r <- cl_l <- rep(0,n)
  L <- 0
  
  while (L < Nrow){
    m <- dim(indat)[1]
    if(m==0){break}
    combined <- c(left[[1]],right[[1]])
    L <- length(combined)
    if (m==1){break}
    
    indatList <- edge(indat, combined, left, right, cl_l, cl_r, m)
    indat <- indatList$rest
    left <- indatList$left
    right <- indatList$right
    cl_l <- indatList$cl_l
    cl_r <- indatList$cl_r
  }
  combined
}
checkList <- function(baseList, compareV){
  lapply(baseList, function(x){
    if(length(x)==length(compareV)){1-sum(x!=compareV)}
    else{x<-0}
  })
}
edge <- function (indata, combined, left, right, cl_l, cl_r, m){
  delete <- NULL
  if (cl_r[1]==1){
    delete <- c(delete, (1:m)[checkList(right, right[[1]])==1])
    delete <- c(delete, (1:m)[checkList(left, rev(right[[1]]))==1])
    
    index1 <- (1:m)[checkList(right, rev(right[[1]]))==1]
    index1 <- index1[index1 != 1]
    right[index1] <- lapply(right[index1], function(x) x <- rev(combined))
    cl_r [index1] <- 1
    
    index2 <- (1:m)[checkList(left, right[[1]])==1]
    index2 <- index2[index2!=1]
    left[index2] <- lapply(left[index2], function(x) x <- combined)
    cl_l[index2] <- 1
  }
  else {
    index1 <- (1:m)[checkList(right, right[[1]])==1]
    index1 <- index1 [index1 != 1]
    right[index1] <- lapply(right[index1], function(x) x <- rev(combined))
    cl_r[index1] <- 1
    
    index2 <- (1:m)[checkList(left, right[[1]])==1]
    index2 <- index2[index2 != 1]
    left[index2] <- lapply(left[index2], function(x) x <- combined)
    cl_l[index2] <- 1
  }
  
  if(cl_l[1]==1){
    delete <- c(delete, (1:m)[checkList(left, left[[1]])==1])
    delete <- c(delete, (1:m)[checkList(right, rev(left[[1]]))==1])
    
    index3 <- (1:m)[checkList(left, rev(left[[1]]))==1]
    index3 <- index3[index3 != 1]
    left[index3] <- lapply(left[index3], function(x) x <- rev(combined))
    cl_l[index3] <- 1
    index4 <- (1:m)[checkList(right, left[[1]])==1]
    index4 <- index4[index4 != 1]
    right[index4] <- lapply(right[index4], function(x) x <- combined)
    cl_r[index4] <- 1
  }
  else {
    index3 <- (1:m)[checkList(left, left[[1]])==1]
    index3 <- index3[index3 != 1]
    left[index3] <- lapply (left[index3], function(x) x <- rev(combined))
    cl_l[index3] <- 1
    
    index4 <- (1:m)[checkList(right, left[[1]])==1]
    index4 <- index4[index4 != 1]
    right[index4] <- lapply(right[index4], function(x) x <- combined)
    cl_r[index4] <- 1
  }
  
  index5 <- (1:m)[sapply(left, length) == sapply(right, length)]
  for (k in index5){
    if(sum(left[[k]]!=right[[k]])==0) delete <- c(delete,k)
  }
  
  delete <- unique(c(1, delete))
  
  if ((m-length(delete)) == 1) rest <- matrix(indata[-delete,], nrow=1)
  else rest <- indata [-delete,]
  left <- left[-delete]
  right <- right[-delete]
  cl_l <- cl_l[-delete]
  cl_r <- cl_r[-delete]
  
  if ((m-length(delete))>1){
    orderNew <- order(rest[,3], decreasing = TRUE)
    rest <- rest[orderNew,]
    left <- left[orderNew]
    right <- right[orderNew]
    cl_l <- cl_l[orderNew]
    cl_r <- cl_r[orderNew]
  }
  
  list(rest = rest, left=left, right = right, cl_l = cl_l, cl_r = cl_r)
}
finl <- edgeOrdering(distance1)
finlp <- def.seq.short[finl,]

## All sequences
par(mar=c(1,2.1,1,1))
plot(finlp, idxs=0, space = 0, border=NA)
