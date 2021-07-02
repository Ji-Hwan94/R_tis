install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")
library(KoNLP)
library(dplyr)
install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)
install.packages("multilinguer")
library(multilinguer)
install_jdk()
install.packages(c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval", "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", "rversions"), type = "binary")
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))
library(KoNLP)
Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jdk-11.0.10")
install.packages("stringr")
library(stringr)

# 대통령 연설문 단어빈도를 wordcloud로 
txt <- readLines("이명박.txt")
txt <- str_replace_all(txt, "\\W", " ") # 특수문자 삭제
nouns <- extractNoun(txt) # 명사 추출
wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
df_word <- filter(df_word, nchar(word) >= 2 & df_word != "국민" & df_word != "우리") # 단어의 음운의 수가 2개 이상인 경우, '우리', '국민'이라는 단어를 제거
pal <- brewer.pal(8,"Dark2") 
set.seed(1234)
wordcloud(words = df_word$word, # 단어
          freq = df_word$freq, # 빈도
          min.freq = 5, # 최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, # 고빈도 단어 중앙 배치
          rot.per = .1, # 회전 단어 비율
          scale = c(4, 0.3), # 단어 크기 범위
          colors = pal) # 색깔 목록





