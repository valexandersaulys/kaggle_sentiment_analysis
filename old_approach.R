#   Script for Movie Analysis
#   * * * Created by Vincent A. Saulys
#   * * * B.Eng Student At McGill University
#   For the Kaggle Movie Sentiment Analysis Contest

rm(list = ls())  # clear workspace

train <- read.delim(file="train.tsv", stringsAsFactors=FALSE)
#test <- read.delim(file="test.tsv", stringsAsFactors=FALSE)

#source('makeshift_funcs.R') # For my own functions, wasn't working so its commented out
library(caret)  # For model training
library(tm) # For Text Mining
library(SnowballC) # For certain advanced Text Mining
library(plyr)
library(class) # To load k-Nearest Neighbour Classification (kNN)


clean_up <- function(df) {
  library(tm)
  corp <- Corpus(DataframeSource(df))
  
  
  corp <- tm_map(corp, content_transformer(tolower))
  corp <- tm_map(corp, removePunctuation)
  corp <- tm_map(corp, removeNumbers)
  corp <- tm_map(corp, removeWords, stopwords("english"))
  corp <- tm_map(corp, stemDocument)
  corp <- tm_map(corp, stripWhitespace)
  
  return(corp)
}


# Make train's Sentiment rating into factor of five levels from 0 to 4
train$Sentiment <- as.factor(train$Sentiment)

# Splitting up the data set depending on the different sentiment ratings
# I'm theorizing a Kmeans cluster will be found 
# Whichever a given text is will be determined by the closest kmeans
zero <- train[train$Sentiment==0,]
one <- train[train$Sentiment==1,]
two <- train[train$Sentiment==2,]
three <- train[train$Sentiment==3,]
four <- train[train$Sentiment==4,]

myframes <- list(zero, one, two, three, four)
corpi_train <- lapply(myframes, clean_up) 
rm(myframes)



# Make train's Sentiment rating into factor of five levels from 0 to 4
train$Sentiment <- as.factor(train$Sentiment)
corpi_manifesto <- clean_up(train)

tdm <- TermDocumentMatrix(corpi_manifesto)
dtm <- DocumentTermMatrix(corpi_manifesto)
weighted <- weightTfIdf(dtm)


weighted

#dP <- createDataPartition(tdmasdfawefawef,p=0.65,list=FALSE)[, 1]

#knn_pred <- knn(tdm[dP,],tdm[-dP,])



