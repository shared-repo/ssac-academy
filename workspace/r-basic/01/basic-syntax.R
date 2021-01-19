# 현재 작업 경로 표시
getwd()

#
print(pi)
print(pi, digits = 3)

# 
cat(1, ':', 'a', '\n', 2, ':', 'b', '\n')
cat(1, ':', 'a', '\n', 2, ':', 'b', '\n', sep="")

#
var1 <- 10
# var1
print(var1)
var2 <- Sys.Date()
print(var2)

#
ls()
objects()
objects(all.names = T) # T == TRUE

#
rm(var1)
str1 = 'hello'
str2 = 'hi'
str3 = 'bye'

rm(list=ls())

#
print(10 / 3)
print(10 %/% 3)
print(10 %% 3)

#
"2" + "2"
as.numeric("2") + as.numeric("2")

#
t <- T
f <- F

print(t)
print(t|f)
print(t||f)

#
sum(1, NA, 2)
sum(1, NA, 2, na.rm = T)

#
gender <- factor('m', c('m', 'f'))
gender
nlevels(gender)
levels(gender)
levels(gender) <- c('male', 'female')
gender

gender2 <- factor('c', c('m', 'f'))
gender2

#
as.Date('2014-11-01')
as.Date('2014년 11월 1일')
as.Date('2014년 11월 1일', format = '%Y년 %m월 %d일')

#
x = 1
if (x > 0) {
  print(x * 2)
} else if (x == 0) {
  print(0)
} else {
  print(x * 3)
}

no <- 11
ifelse(no %% 2 == 0, 'even number', 'odd number')

x <- 0
while (TRUE) {
  x <- x + 1
  if (x == 6) break
  if (x %% 2 == 0) next
  print(x)
}

x <- 10
for (i in 1 : x) {
  print(i)
}

#
score <- c(85, 90, 76, 82, 79)

min(score)
max(score)
mean(score)
summary(score)

myfunc3 <- function(a, b = 10) {
  return (a * b)
}

myfunc3(10, 20) # 10 x 20 (a : 10, b : 20)
myfunc3(10) # 10 x 10
# myfunc3() # error : a는 필수 (기본 값 지정 X)
myfunc3(b = 20, a = 50)

#
install.packages(c('dplyr', 'ggplot2'))
installed.packages()
.libPaths()

library(ggplot2)

#
vec1 <- c(1, 2, 3, 4, 5)
vec1
c(1, 2, 3, 4, "5")

vec1[3]
vec1[2:4]

vec1 <- c(vec1, 7)
vec1

vec1[9] <- 9
vec1

vec1 <- append(vec1, c(10, 11), after = 3)
vec1

var1 <- c(1, 2, 3)
# var1 <- c(1, 2, 3, 1, 2)
var4 <- c(1, 2, 3, 4, 5)
var1 + var4

# 
fruits <- c(10, 20, 30)
fruits
names(fruits) <- c("apple", "banana", "peach")
fruits
fruits[1]
fruits['apple']

seq(1, 10)
seq(1, 20, 3)
NROW(fruits)

vec7 <- c(1, 3, 5, 4, 7, 0)
100 %in% vec7

#
mat3 <- matrix(c(1, 2, 3, 4), nrow = 2) 
mat3
mat3[1:2,2]
mat3[,]
mat3[1,]

#
mat4 <- matrix(c(1,2,3,4,5,6,7,8,9), nrow = 3, byrow = T)
mat4
mat4 <- rbind(mat4, c(11, 12, 13))
mat4
mat4 <- rbind(mat4, c(15, 16, 17, 18))
mat4
mat4 <- rbind(mat4, c(19, 20))
mat4

#
array1 <- array(c(1:12), dim = c(4, 3))
array1

array2 <- array(c(1:12), dim = c(2, 2, 3))
array2
array2[,2,]

#
list1 <- list(name = 'John Doe', address = 'Seoul, Korea', phone = '010-0000-0000', salary = 1000)
list1
list1$name
list1$phone
list1[1]
list1[[1]]

#
no <- c(1, 2, 3, 4)
name <- c("Apple", "Peach", "Banana", "Grape")
price <- c(500, 200, 100, 50)
qty <- c(5, 2, 4, 7)
sales <- data.frame(NO=no, NAME=name, PRICE=price, QTY=qty)
sales

sales$NAME
sales[1,]
sales[,1]

subset(sales, qty < 5)
subset(sales, price == 200)

no <- c(1, 2, 3, 4)
name <- c("장동건", "김윤석", "송강호", "최민식")
address <- c("서울", "대전", "포항", "경주")
phone <- c(1111, 2222, 3333, 4444)
hobby <- c("독서", "미술", "낚시", "등산")
member <- data.frame(NO = no, NAME = name, ADDRESS = address,
                     PHONE = phone, HOBBY = hobby)
member

subset(member, NO > 2)
subset(member, NO > 2, select = c('NAME', 'PHONE'))
