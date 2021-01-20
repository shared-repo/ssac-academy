#
# install.packages(c('XML', 'httr'))

library(XML)
library(httr)

url <- 'https://en.wikipedia.org/wiki/World_population'

html <- GET(url) # 지정된 url로 요청 보내기

html$content # 응답 내용

rawToChar(html$content) # byte -> char

tables <- readHTMLTable( rawToChar(html$content) ) # html에서 <table>...</table>을 추출
length(tables)

tables[6]

population_table <- readHTMLTable( rawToChar(html$content), which = 6, header = T ) # html에서 n번째 <table>...</table>을 추출
population_table

population_table[,2:3]


#
movies <- readLines("https://www.imdb.com/chart/top") # 지정된 url의 응답을 행별로 읽어서 vector로 반환
movies[1:10]

from <- grep("table class=\"chart full-width\"", movies) # moviews vector에서 지정된 문자열을 포함하는 위치 반환
movies[612]
to <- grep("The Top Rated Movie list only includes theatrical features.", movies)
movies[10634]
movies250 <- movies[from:(to-3)]
head(movies250, n = 1) # 목록의 앞부분에서 지정된 갯수의 데이터를 반환
tail(movies250, n = 1) # 목록의 뒷부분에서 지정된 갯수의 데이터를 반환

imdb250 <- readHTMLTable(movies250)
imdb250 <- imdb250[[1]] # list의 첫 번 째 항목의 값 반환
imdb250 <- imdb250[,c(2,3)] # 2열과 3열의 데이터만 뽑아서 저장
class(imdb250)
imdb250[1:10,]

#
# install.packages('jsonlite') # json data 처리 패키지
library(jsonlite)

url2 <- 'http://openapi.seoul.go.kr:8088/794e56714e6f686337304645616b68/json/GeoInfoAnnualPrecipitationWGS/1/100'
json <- readLines(url2, encoding = "UTF-8", warn = F) # 지정된 url로 요청을 보내고 응답 수신 (서울시 공공데이터)
json
class(json)

data <- fromJSON(json) # json string -> R object ( 여기서는 list로 변경 )
class(data)
data

df <- data.frame(data$GeoInfoAnnualPrecipitationWGS$row)
df
View(df)

as.numeric(df$MEAN_PRE)

bplot <- barplot(as.numeric(df$MEAN_PRE),
                 main = 'Annual Precipitation',
                 col = rainbow(10),
                 ylim = c(0, 2000),
                 names.arg = df$NAM,
                 cex.name = 0.7, las = 2)
text(x = bplot, y = df$MEAN_PRE - 300, 
     labels = paste(df$MEAN_PRE, 'mm'),
     col = 'black', cex = 0.7, srt = 90)
