var1 <- c(10, 20, 30, 40, 50) #y축 설정 – x축은 자동으로 따라옴
plot(var1)

x <- 1 : 3 # seq(1, 3)
y <- 3 : 1
plot(x, y)
plot(x, y, xlim = c(1, 10), ylim = c(1, 5))

# prev_par <- par(family="AppleGothic")

plot(x, y, xlim = c(1, 10), ylim = c(1, 5),
     xlab = "x축 이름", ylab = "y축 이름",
     main = "그래프 제목")

# par(prev_par)

# 
v1 <- c(100, 130, 120, 160, 150)
plot(v1, type = 'o', col = "red", ylim = c(0, 200), axes = F, ann = F)

axis(1, at = 1 : 5, lab = c("MON", "TUE", "WED", "THU", "FRI"))
axis(2, ylim = c(0, 200))
title(main = "FRUITxxxxx", col.main = "red", font.main = 4)
title(xlab = "DAY", col.lab = "black")
title(ylab = "price", col.lab = "blue")

#
prev_par <- par(no.readonly = TRUE) # 기존 그래픽옵션 읽어서 저장

par(mfrow = c(1, 3))
plot(v1, type = "o")
plot(v1, type = "s")
plot(v1, type = "l")

par(prev_par) # 기존 그래픽 옵션 복원


#
v1 <- c(1, 2, 3, 4, 5)
v2 <- c(5, 4, 3, 2, 1)
v3 <- c(3, 4, 5, 6, 7)
plot(v1, type = "s", col = "red", yli = c(1, 5))
lines(v2, type = "o", col = "blue", ylim = c(1, 5))
lines(v3, type = "l", col = "green", ylim = c(1, 15))

# 
v1 <- c(1, 2, 3, 4, 5)
v2 <- c(5, 4, 3, 2, 1)
v3 <- c(3, 4, 5, 6, 7)
plot(v1, type = "s", col = "red", ylim = c(1, 10))
lines(v2, type = "o", col = "blue", ylim = c(1, 5))
lines(v3, type = "l", col = "green", ylim = c(1, 15))
legend(4, 9, c("v1", "v2", "v3"), cex = 0.9,
       col = c("red", "blue", "green"), lty = 1)


#
x <- matrix(c(5, 4, 3, 2), 2, 2)
x
barplot(x, beside = T, names = c(5, 3), col = c("green", "yellow"))

v1 <- c(100, 120, 140, 160, 180)
v2 <- c(120, 130, 150, 140, 170)
v3 <- c(140, 170, 120, 110, 160)

qty <- data.frame(BANANA = v1, CHERRY = v2, ORANGE = v3)
qty
barplot(as.matrix(qty), main = "Fruit's Sales QTY",
          beside = T, col = rainbow(nrow(qty)), ylim = c(0, 400))
legend(14, 400, c("MON", "TUE", "WED", "THU", "FRI"),
         cex = 0.8, fill = rainbow(nrow(qty)))

peach <- c(180, 200, 250, 198, 170)
colors <- c()
for (i in 1 : length(peach)) {
  if (peach[i] >= 200) {
    colors <- c(colors, "red")
  } else if ( peach[i] >= 180) {
    colors <- c(colors, "yellow")
  } else {
    colors <- c(colors, "green")
  }
}

barplot(peach, main = "Peach Sales QTY",
            names.arg = c("MON","TUE","WED","THU","FRI"), col = colors)

#

v1 <- c(10, 12, 15, 11, 20)
v2 <- c(5, 7, 15, 8, 9)
v3 <- c(11, 20, 15, 18, 13)

boxplot(v1, v2, v3, col = c("blue", "yellow", "pink"),
        names = c("Blue", "Yellow", "Pink"), horizontal = T)

#
# install.packages("igraph")
library(igraph)

name <- c('장동건 대표이사', '일지매 부장', '김유신 과장', '손흥민 대리',
          '추신수 대리', '이순신 부장', '유관순 과장', '신사임당 대리', '강감찬 부장',
          '광개토 과장', '정몽주 대리')
pemp <- c('장동건 대표이사', '장동건 대표이사', '일지매 부장', '김유신 과장', 
          '김유신 과장', '장동건 대표이사', '이순신 부장', '유관순 과장',
          '장동건 대표이사', '강감찬 부장', '광개토 과장')

emp <- data.frame(이름 = name, 상사이름 = pemp)
emp
g <- graph.data.frame(emp, directed = T)
plot(g, layout = layout.fruchterman.reingold, vertex.size = 8,
       edge.arrow.size = 0.5)

#
total <- read.csv("data-files/학생별전체성적-new.txt",
                    header = T, sep = ",")
total
row.names(total) <- total$이름
total
total <- total[, 2:7]
total

stars(total, flip.labels = FALSE, draw.segment = FALSE,
        frame.plot = TRUE, full = TRUE,
        main = "학생별 과목별 성적분석 - STAR Chart")
stars(total, flip.labels = F, draw.segment = T, frame.plot = T,
      full = T, main = "학생별 과목별 성적분석 - 나이팅게일 차트")

##############################################################################################

# install.packages("ggplot2")
library(ggplot2)

korean <- read.table("data-files/학생별국어성적-new.txt",
                     header = T, sep = ",")
korean

ggplot(korean, aes(x=이름,y=점수)) + geom_point()

ggplot(korean, aes(x=이름,y=점수)) + geom_bar(stat = "identity")

ggplot(korean, aes(x=이름,y=점수)) +
  geom_bar(stat = "identity", fill = "green", color = "red")

gg <- ggplot(korean, aes(x=이름,y=점수)) +
  geom_bar(stat = "identity", fill = "green", color = "red")
gg + theme(axis.text.x = element_text(angle = 45, hjust = 1,
                                        vjust = 1, color = "blue", size = 8))

#
score_kem <- read.csv("data-files\\학생별과목별성적-국영수-new.csv", header = T)
score_kem

# install.packages('plyr')
library(plyr)

sort_kem <- arrange(score_kem, 이름, 과목)
sort_kem
sort_kem2 <- ddply(sort_kem, "이름", transform,
                     누적합계 = cumsum(점수))
sort_kem2
sort_kem3 <- ddply(sort_kem2, "이름", transform,
                     누적합계 = cumsum(점수),
                     label = cumsum(점수) - 0.5 * 점수)
sort_kem3

ggplot(sort_kem3, aes(x = 이름, y = 점수, fill = 과목)) +
  geom_bar(stat = "identity") +
  geom_text(aes(y = label, label = paste(점수, "점")),
            color = "black", size = 4)

#
v_mt <- mtcars
v_mt
graph1 <- ggplot(v_mt, aes(x = hp, y = mpg))
graph1 + geom_point()

graph1 + geom_point(aes(color = factor(am)))

graph1 + geom_point(aes(size = wt))

graph1 + geom_point(aes(shape = factor(am),
                        size = wt))

graph1 + geom_point(aes(shape = factor(am),
                        color = factor(am),
                        size = wt)) +
  scale_color_manual(values = c("red", "green"))

graph1 + geom_point(color = "red") + geom_line()

three <- read.csv("data-files\\학생별과목별성적-3기-3명.csv",
                  header = T)
three
sort_score <- arrange(three, 이름, 과목)
sort_score
ggplot(sort_score, aes(x = 과목, y = 점수, color = 이름,
                         group = 이름)) + geom_line()
