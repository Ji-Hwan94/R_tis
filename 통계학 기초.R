# 표준편차
score <- c(90, 70, 50, 30)
avg <- mean(score)
avg

var <- var(score) #분산
var

sd <- sd(score) # 표준편차
sd

score <- c(70, 60, 60, 50)

avg <- mean(score)
avg

var <- var(score)
var

sd <- sd(score)
sd

score1 <- c(90, 70, 50, 30)
score2 <- c(70, 60, 60, 50)

mean(score1)
mean(score2)

# 표준편차가 작을 수록 평균에 가깝다.
sd(score1)
sd(score2)

install.packages("ggplot2")
library(ggplot2)

mpg <- as.data.frame(ggplot2::mpg)

library(dplyr)

#compact와 suv 자동차의 도시 연비 t 검정정
mpg_diff <- mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c("compact", "suv"))

head(mpg_diff)

table(mpg_diff$class)

# mpg_diff ,비교대상 ~ 기준, 분산은 같다고 설정
t.test(data=mpg_diff, cty~class, var.equal=T)

# 일반 휘발유와 고급 휘발유의 도시 연비 검정 t
mpg_diff2 <- mpg %>% 
  select(fl, cty) %>% 
  filter(fl %in% c("r", "p"))

table(mpg_diff2$fl)

# mpg_diff2 ,비교대상 ~ 기준, 분산은 같다고 설정
t.test(data=mpg_diff2, cty~fl, var.equal=T)


# 상관행렬 히트맵
head(mtcars)
car_cor <- cor(mtcars) # 상관 행렬 생성
round(car_cor, 2) # 소수점 셋째 자리에서 반올림해 출력

install.packages("corrplot")
library(corrplot)

#히트맵 생성
corrplot(car_cor) # 1에 가까울 수록 정비례, -1에 가까울 수록 반비례

# method를 이용해서 그림을 바꿀 수 있다.
corrplot(car_cor, method = "number")

col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))

corrplot(car_cor,
         method = "color", # 색깔로 표현
         col = col(200), # 색상 200개 선정
         type = "lower", # 왼쪽 아래 행렬만 표시
         order = "hclust", # 유사한 상관계수끼리 군집화
         addCoef.col = "black", # 상관계수 색깔
         tl.col = "black", #변수명 색깔
         tl.srt = 45, # 변수명 45도 기울
         diag = F) # 대각 행렬 제외
