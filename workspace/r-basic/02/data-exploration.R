#
exam <- read.csv("data-files/csv_exam.csv")
exam

head(exam, n = 3)
tail(exam, n = 3)
str(exam)
dim(exam)
summary(exam)

#
this_mpg <- as.data.frame(ggplot2::mpg)
head(this_mpg)
tail(this_mpg)
View(this_mpg)
dim(this_mpg)
str(this_mpg)
class(this_mpg)
summary(this_mpg)

#
install.packages(c('dplyr', 'hflights'))
library(dplyr)
library(hflights) # 테스트 데이터 셋 패키지

str(hflights)
head(hflights)

hflights_df <- tbl_df(hflights)
hflights_df

#
filter(hflights_df, Month == 1 & DayofMonth == 1)
filter(hflights_df, Month == 1 | Month == 2)

arrange(hflights_df, ArrDelay, Year, Month)
arrange(hflights_df, desc(ArrDelay), Month, Year)

select(hflights_df, Year, Month, DayOfWeek)
select(hflights_df, Year:DayOfWeek)
select(hflights_df, -(Year:DayOfWeek))

mutate(hflights_df,
       gain = ArrDelay - DepDelay,
       gain_per_hour = gain/(AirTime/60))

transform(hflights,
          gain = ArrDelay - DepDelay,
          gain_per_hour = gain/(AirTime/60))

summarise(hflights_df, delay = mean(DepDelay, na.rm = TRUE))

planes <- group_by(hflights_df, TailNum)
delay <- summarise(planes, count = n(),
                   dist = mean(Distance, na.rm = T),
                   delay = mean(ArrDelay, na.rm = T))
delay
delay <- filter(delay, count > 20, dist < 2000)
delay

library(ggplot2)
ggplot(delay, aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth()

#
a1 <- group_by(hflights, Year, Month, DayofMonth)
a2 <- select(a1, Year:DayofMonth, ArrDelay, DepDelay)
a2
a3 <- summarise(a2, arr = mean(ArrDelay, na.rm = TRUE),
                dep = mean(DepDelay, na.rm = TRUE))
a3
a4 <- filter(a3, arr > 30 | dep > 30)
a4

# function chain
hflights_df %>%
  group_by(Year, Month, DayofMonth) %>%
  summarise(arr = mean(ArrDelay, na.rm = TRUE),
            dep = mean(DepDelay, na.rm = TRUE)) %>%
  filter(arr > 30 | dep > 30)

hflights_df