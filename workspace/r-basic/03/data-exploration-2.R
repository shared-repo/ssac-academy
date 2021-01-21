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


#####################################################################
## 연습

?mpg

low_mpg <- mpg %>% filter(displ <= 4)
high_mpg <- mpg %>% filter(displ > 4)
mean(low_mpg$hwy)
mean(high_mpg$hwy)

mpg %>%
  mutate(displ_level = ifelse(displ <= 4, 'low', 'high')) %>% 
  group_by(displ_level) %>% 
  summarise(hwy_mean = mean(hwy))

mpg %>% 
  filter(manufacturer %in% c('audi', 'toyota')) %>% 
  group_by(manufacturer) %>% 
  summarise(cty_mean = mean(cty))

mpg %>% 
  filter(manufacturer %in% c('chevrolet', 'ford', 'honda')) %>% 
  summarise(hwy_mean = mean(hwy))

mpg %>% 
  select(class, cty, hwy) %>% 
  head(10)

mpg %>%
  filter(class %in% c('suv', 'compact')) %>% 
  select(class, cty, hwy) %>% 
  group_by(class) %>% 
  summarise(cty_mean = mean(cty))

mpg %>%
  filter(manufacturer == 'audi') %>% 
  arrange(desc(hwy)) %>% 
  head(5)

mpg %>% 
  mutate(total = cty + hwy,
         mean = total / 2) %>% 
  arrange(desc(mean)) %>% 
  head(3)

mpg %>% 
  group_by(class) %>% 
  summarise(cty_mean = mean(cty)) %>% 
  arrange(desc(cty_mean))

mpg %>% 
  group_by(class) %>% 
  summarise(hwy_mean = mean(hwy)) %>% 
  arrange(desc(hwy_mean)) %>% 
  head(5)

mpg %>% 
  filter(class == 'compact') %>% 
  group_by(manufacturer) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))

fuel <- data.frame(fl = c('c', 'd', 'e', 'p', 'r'), 
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = FALSE)
fuel
mpg

?left_join

mpg %>% 
  inner_join(fuel, by = 'fl') %>% 
  select(model, fl, price_fl) %>% 
  head

##############################################

df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df

is.na(df)

table(is.na(df))
table(is.na(df$sex))
table(is.na(df$score))

df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss

df_nomiss2 <- na.omit(df)
df_nomiss2


exam <- read.csv("data-files/csv_exam.csv")
exam
exam[c(3, 8, 15), "math"] <- NA
exam

exam %>%
  summarise(mean_math = mean(math))

exam %>%
  summarise(mean_math = mean(math, na.rm=T))

math_mean <- mean(exam$math, na.rm=T)
exam$math <- ifelse(is.na(exam$math), math_mean, exam$math)
table(is.na(exam$math))


this_mpg <- as.data.frame(ggplot2::mpg)
this_mpg
this_mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA

table(is.na(this_mpg$drv))
table(is.na(this_mpg$hwy))

this_mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(hwy_mean = mean(hwy))


