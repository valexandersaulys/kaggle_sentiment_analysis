# I am trying to get some specific functions out and am testing them here

set <- read.delim(file="train.tsv", stringsAsFactors=FALSE)
test <- read.delim(file="test.tsv", stringsAsFactors=FALSE)


dm <- create_matrix(set$Phrase, removeStopwords=FALSE)
dt <- create_matrix(test$Phrase, removeStopwords=FALSE,
                    weighting=weightTF,originalMatrix=dm)

predSize <- length(test)
predictionContainer <- create_container(dt, labels=rep(0,predSize), 
                                        testSize=1:predSize, 
                                        virgin=FALSE)