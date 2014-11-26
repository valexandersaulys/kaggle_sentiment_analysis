#   Makeshift Functions 
#   * * * Created by Vincent A. Saulys
#   * * * B.Eng Student At McGill University
#   For the Kaggle Movie Sentiment Analysis Contest

library(caret)  # For model training
library(tm) # For Text Mining
library(SnowballC) # For certain advanced Text Mining
library(plyr)

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


