# Text Mining

#### install packages ####

# download rJava in advance: 
browseURL("https://www.java.com/en/download/manual.jsp")
install.packages("rJava")
install.packages("tm") 
install.packages("wordcloud")
install.packages("KoNLP")
install.packages("SnowballC")
library(tm)   # Text Mining package
library(wordcloud)   # Word Clouds
library(KoNLP)   # Korean NLP package
library(SnowballC)   # stemmers
library(RColorBrewer)   # ColorBrewer Palettes 


#### English Text Mining - Obama ####

# 코퍼스 생성
obama <- Corpus(DirSource("/Users/Sodami/Documents/OneDrive/R programming/files/obama"))
?Corpus
names(obama)
summary(obama)
str(obama)

# 코퍼스 내용 확인
inspect(obama)
writeLines(as.character(obama[[1]]))

# Pre-processing
getTransformations()

?content_transformer
delete <- content_transformer(function(x, pattern) {gsub(pattern, " ", x)})
obama <- tm_map(obama, delete, ",")

# 공백 제거
obama <- tm_map(obama, stripWhitespace)

# 구두점 제거
obama <- tm_map(obama, removePunctuation)

# 소문자화, 대문자를 구별할 필요가 있을 때는 생략
obama <- tm_map(obama, content_transformer(tolower))

# 숫자 제거
obama <- tm_map(obama, removeNumbers)

# 불용어 제거
obama <- tm_map(obama, removeWords, stopwords("english"))

# 단어줄기 추출 
obama <- tm_map(obama, stemDocument)

# R 버전 3.1.1 이후에서는 'inherits(doc, "TextDocument")는 TRUE가 아닙니다' 라는 에러가 나타날 수 있다. 
# 이때는 다음 명령어를 사용해야 한다.
obama <- tm_map(obama, PlainTextDocument)
inspect(obama) 

# 워드 클라우드 생성
wordcloud(obama, scale = c(4,0.5), max.words = 200, 
          random.order = FALSE, 
          rot.per = 0.35, colors = brewer.pal(8, "Set2"))

obama <- tm_map(obama, content_transformer(gsub),
                pattern = "countri", 
                replacement = "country")

# 사용자가 불용어 제거
obama <- tm_map(obama, removeWords, "whether")

# 여러 개의 불용어 제거
eliminate <- c("whether", "less", "may", "shall", "across")
obama <- tm_map(obama, removeWords, eliminate)



#### Steve Jobs ####

# create corpus
jobs <- Corpus(DirSource("/Users/Sodami/Documents/OneDrive/R programming/files/steve_jobs")) 
jobs
names(jobs)
inspect(jobs)
# print the 1st document in the corpus to the console
writeLines(as.character(jobs[[1]]))

# Pre-Processing
getTransformations()

# create a custom transformation using content_transformer
delete <- content_transformer(function(x, pattern) {gsub(pattern, " ", x)})
jobs <- tm_map(jobs, delete, ",")   # eliminate comma
jobs <- tm_map(jobs, delete, "-")   # eliminate hypen
jobs <- tm_map(jobs, delete, ":")   # eliminate colon

# remove punctuation: replace punctuation marks with ""
jobs <- tm_map(jobs, removePunctuation)

# transform to lower case
jobs <- tm_map(jobs, content_transformer(tolower))

# remove numbers
jobs <- tm_map(jobs, removeNumbers)

# remove stop words 
jobs <- tm_map(jobs, removeWords, stopwords("english"))

# remove extraneous white space
jobs <- tm_map(jobs, stripWhitespace)

# stemming 
jobs <- tm_map(jobs, stemDocument)

# read lines from corpus
writeLines(as.character(jobs[[1]]))


# document term matrix: a matrix that lists all occurrences of words 
# in the corpus, by document
# dimension of DTM: number of documents X the number of words in the corpus
# the large majority of words will appear only in a few documents
# as a result, a DTM is invariably sparse – that is, a large number of its entries are 0

# create a DTM
steve <- DocumentTermMatrix(jobs)
steve   # 1 by 594 dimension matrix in which 0% of the rows are zero

# frequency of occurence of each word
freq <- colSums(as.matrix(steve))
length(freq)  # column matrix variable freq
freq

# order freq in descending order
ordered.freq <- order(freq, decreasing = T)

# inspect frequent terms
freq[head(ordered.freq)]
# inspect sparse terms
freq[tail(ordered.freq)]

# get a list of terms that occur more than ten times in the corpus
findFreqTerms(steve, 10)

# removeSparseTerms
stevejobs <- data.frame(term = names(freq), 
                        counts = freq)
head(stevejobs)
rownames(stevejobs)

library(ggplot2)
ggplot(subset(stevejobs, counts > 7), aes(x = term, y = counts)) +
  geom_bar(stat="identity", fill = "midnightblue") +
  coord_flip() +
  theme_bw()
dev.off()

wordcloud(names(freq), freq, min.freq = 7)
dev.off()
