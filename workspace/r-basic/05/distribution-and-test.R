
# 기초 통계량
score <- c(85, 90, 93, 86, 82)

mean(score)
sum(score) / length(score)

median(score)

var(score)

sd(score)

fivenum(1:10)
summary(1:10) #fivenum + average
x <- 1:10
c( min(x), quantile (x, 1/4) , median (x), quantile (x, 3/4) , max (x))
IQR (1:10)
quantile (1:10 , c(1/4, 3/4))
x <- factor (c("a", "b", "c", "c", "c", "d", "d"))
x
table (x)
which.max(table(x))
which.min(table(x))

## 표본 추출 1
sample(1:10, 5)
sample(1:10, replace = T)
sample(1:10, 5, replace = T, prob = 1:10)
sample(1:10) # shuffle

## 표본 추출 2

# install.packages("sampling") 
library(sampling);

iris

x <- strata(c("Species"), size=c(3, 3, 3), method="srswor", data=iris)
x
getdata(iris, x)

#종별로 다른 수의 표본 추출
strata(c("Species"), size = c(3, 1, 1), method = "srswr", data = iris)

iris$Species2 <- rep (1:2 , 75)
iris

strata(c("Species", "Species2"), size =c(1, 1, 1, 1, 1, 1) ,
       method ="srswr", data = iris )

## 표본 추출 3
# install.packages("doBy")
library(doBy);

#각 층마다 동일한 표본 추출
sampleBy(~Species , frac =.1 , data = iris, systematic = T)  # 1 / frac

## 정규분포

height <- rnorm(n = 1000000, mean = 168, sd = 7)
hist(height, breaks = 10, probability = T)
hist(height, breaks = 100)
hist(height, breaks = 1000)

## 상관계수
x <- c(3, 5, 8, 11, 13) # 제품 판매 개수
y <- c(1, 2, 3, 4, 5) # DM 발송 회수

cor(x, y)

## 상관계수 2
cor(iris$Sepal.Width, iris$Sepal.Length)
cor(iris[, 1:4])

# install.packages("corrgram")
library(corrgram)

corrgram(cor(iris[, 1:4]), type = "corr", upper.panel = panel.conf)

## 상관계수 3

# install.packages("Hmisc")
library(Hmisc)
x <- c(3, 4, 5, 3, 2, 1, 7, 5)
rank(sort(x))

m <- matrix(c(1:10, (1:10)^2), ncol = 2)
m
rcorr(m, type = "pearson")$r
rcorr(m, type = "spearman")$r

### 상관계수 4
# install.packages("Kendall")
library(Kendall)
Kendall(m[,1], m[,2])

### 상관계수 5

cor.test(c(1, 2, 3, 4, 5), c(1, 0, 3, 4, 5), method = "pearson")
cor.test(c(1, 2, 3, 4, 5), c(1, 0, 3, 4, 5), method = "spearman")
cor.test(c(1, 2, 3, 4, 5), c(1, 0, 3, 4, 5), method = "kendall")


### 분할표

table (c("a", "b", "b", "b", "c", "c", "d"))

d <- data.frame (x=c("1", "2", "2", "1"),
                 y=c("A", "B", "A", "B"),
                 num=c(3, 5, 8, 7))
d
xt <- xtabs(num ~ x + y, data = d)
xt

### 카이제곱 검정

# install.packages("gmodels")
library(gmodels)

study <- read.csv("data-files/pass-cross.csv", header = T)
study

CrossTable(study$공부함, study$합격, chisq = T)

### 카이제곱 검정 2

library(MASS)
str(survey)
head(survey)
?survey

head(survey[,c("Sex", "Exer")])

xtabs(~ Sex + Exer, data = survey)

chisq.test(xtabs(~Sex + Exer, data = survey))

### 카이제곱 검정

xtabs(~W.Hnd + Clap, data = survey)
chisq.test(xtabs(~W.Hnd + Clap, data = survey))

fisher.test(xtabs(~ W.Hnd + Clap, data = survey))

# 맥니마 검정

help(mcnemar.test)
Performance <-
  matrix(c(794, 86, 150, 570),
         nrow = 2,
         dimnames = list("1st Survey" = c("Approve", "Disapprove"),
                         "2nd Survey" = c("Approve", "Disapprove")))
Performance
mcnemar.test(Performance)

### 분포에 대한 검정

table(survey$W.Hnd)
chisq.test(table(survey$W.Hnd), p = c(.2, .8))

binom.test(86, 86 + 150, 0.5)

shapiro.test(rnorm(1000))

### t.test

x <- rnorm(30)
mean(x)
sd(x)
t.test(x)

?t.test

### t.test 2

score1 <- read.csv("data-files/tdata.csv", header = T)
score1

mean(score1$성적)
result <- t.test(score1$성적, alternative = c("greater"), mu = 75)
result

score2 <- read.csv("data-files/tdata2.csv", header = T)
score2

mean(score2$성적)
result2 <- t.test(score2$성적, alternative = c("greater"), mu = 75)
result2

### 두 연속형 변수 비교

sleep
sleep2 <- sleep[, -3]
sleep2

tapply(sleep2$extra, sleep2$group, mean)

library(doBy)
summaryBy(extra ~ group, sleep2)

var.test(extra ~ group, sleep2) # 등분산성 검정

t.test(extra ~ group, data = sleep2, paired = FALSE, var.equal = TRUE)

### 짝지은 이표본 평균 비교

sleep
sleep$extra[sleep$group == 1]
sleep$extra[sleep$group == 2]

with(sleep, # 이후에는 sleep 생략 가능 
     t.test(extra[group == 1], extra[group == 2], 
            paired = TRUE))

### 분산 분석

a <- c(100, 98, 85, 90, 88, 80)
b <- c(73, 80, 80, 75, 67, 57)
c <- c(110, 104, 91, 109, 85, 95)
life <- data.frame(a, b, c)
life
b.life <- stack(life)
b.life

op = par(mfrow = c(1, 2))
boxplot(values ~ ind, data = b.life)
stripchart(life)
par(op)

oneway.test(values ~ ind, data = b.life, var.equal = TRUE)


b.life.aov <- aov(values ~ ind, data = b.life)
summary(b.life.aov)

b.life.lm <- lm(values ~ ind, data = b.life)
anova(b.life.lm)

### 이원분산분석

twoway.comparisons.data <- read.csv('data-files/twoway-comparisons.csv')
print(twoway.comparisons.data)


towway.comparisons.data.aov <- aov(StressReduction ~ Treatment * Age,
                                   twoway.comparisons.data)
summary(towway.comparisons.data.aov)

towway.comparisons.data.aov <- aov(StressReduction ~ Treatment + Age,
                                   twoway.comparisons.data)
summary(towway.comparisons.data.aov)
