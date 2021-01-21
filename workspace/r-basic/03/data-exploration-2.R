# package import 

library(dplyr)
library(ggplot2)


# 1. 컬럼 이름 변경
df_raw <- data.frame(var1 = c(1, 2, 1),
                     var2 = c(2, 3, 2))
df_raw

df_new <- df_raw

df_new2 <- rename(df_new, v1 = var1, v2 = var2)
df_new2


colnames(df_raw)
colnames(df_raw) <- c("vx", 'vy')
df_raw

#####

copied_mpg <- mpg
copied_mpg

renamed_mpg <- rename(copied_mpg, city = cty, highway = hwy)
renamed_mpg

# 2. 새 컬럼 추가

mpg$mean <- (mpg$cty + mpg$hwy) / 2 # 복합연비비
mpg

summary(mpg$mean)
hist(mpg$mean)

mpg$test <- ifelse(mpg$mean >= 20, "pass", "fail")
mpg

table(mpg$test) # 빈도표
qplot(mpg$test) # ggplot의 약식 버전
ggplot(mpg, aes(x = test)) + geom_histogram(stat="count")

mpg$grade <- ifelse(mpg$mean >= 30, "A",
                    ifelse(mpg$mean >= 25, "B",
                           ifelse(mpg$mean >= 20, "C", "D")))
mpg
table(mpg$grade)
qplot(mpg$grade)

select(mpg, mean, test, grade)
select(mpg, -(displ:fl))

# 필터
exam <- read.csv("data-files/csv_exam.csv")
exam
exam %>% filter(class == 1)
exam %>% filter(class != 1)
exam %>% filter(math > 50)
exam %>% filter(math < 50)
exam %>% filter(english >= 80)
exam %>% filter(english <= 80)
exam %>% filter(class == 1 & math > 50)
exam %>% filter(class == 2 & english >= 80)
exam %>% filter(math >= 90 | english >= 90)
exam %>% filter(class == 1 | class == 2 | class == 3)

# 컬럼 선택
exam %>% select(english)
exam %>% select(class, math, english)
exam %>% select(-math)
exam %>% select(-math, -english)
exam %>%
  filter(class == 1) %>%
  select(english)
exam %>%
  select(id, math) %>%
  head(10)

# 정렬
exam %>% arrange(class, desc(math))

# 새 컬럼 추가
exam %>%
  mutate(total = math + english + science) %>%
  head(5)

exam %>%
  mutate(total = math + english + science,
         mean = total / 3) %>%
  head(5)

# 집계 함수
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math))

####

mpg %>%
  group_by(manufacturer) %>%
  filter(class == 'suv') %>%
  mutate(tot = (cty + hwy) / 2) %>%
  summarise(mean_tot = mean(tot)) %>%
  arrange(desc(mean_tot)) %>%
  head(5)

# 결합
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))
test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))
test1
test2
total <- left_join(test1, test2, by = 'id')
total
name <- data.frame(class = c(1, 2, 3, 4, 5),
                   instructor = c("kim", "lee", "park", "choi", "jung"))
name
exam
exam_new <- left_join(exam, name, by = "class")
exam_new

group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))
group_a
group_b
group_all <- bind_rows(group_a, group_b)
group_all

