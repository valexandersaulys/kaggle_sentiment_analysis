#   Script for Movie Analysis
#   * * * Created by Vincent A. Saulys
#   * * * B.Eng Student At McGill University
#   For the Kaggle Movie Sentiment Analysis Contest

rm(list = ls())  # clear workspace

set <- read.delim(file="train.tsv", stringsAsFactors=FALSE)
#test <- read.delim(file="test.tsv", stringsAsFactors=FALSE)
#set <- set[1:1600,]

library(caret)  # For model training & other useful functions
library(tm) # For Text Mining
library(SnowballC) # For certain advanced Text Mining
library(plyr)
library(class) # To load k-Nearest Neighbour Classification (kNN)
library(RTextTools)

# We have 156,060 entries, so we split to 3/4 for training and 1/4 for validation
len <- (3/4) * length(set[,1])

dm <- create_matrix(set$Phrase, removeStopwords=FALSE)
container <- create_container(matrix=dm,  # This will take a long time to compute
                              labels=set$Sentiment, 
                              trainSize=1:(len-1),
                              testSize=len:length(set[,1]), 
                              virgin=FALSE  # Does the data have corresponding labels?, FALSE if it does
                              )

SVM <- train_model(container,"SVM")  # MAXENT not working
# returns a data.frame of predicted codes and probabilities for the specificied algorithm
SVM_CLASSIFY <- classify_model(container,SVM)  

analytics <- create_analytics(container,SVM_CLASSIFY)
analytics