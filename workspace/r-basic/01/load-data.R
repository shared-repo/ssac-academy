#
list.files()
list.files("./01")
list.files('data-files/')
list.files(recursive = TRUE)
list.files(all.files = TRUE)

# 
scan1 <- scan('data-files/scan-1.txt')
scan2 <- scan("data-files/scan-2.txt", what = "")
scan2

data <- scan()
data

#
input3 <- readline()
input3

#
scan4 <- scan("data-files/scan-4.txt", what = "")
scan4

input5 <- readLines("data-files/scan-4.txt")
input5

# 
fruits <- read.table("data-files/fruits.txt")
fruits

fruits <- read.table("data-files/fruits.txt", header = T)
fruits

fruits2 <- read.table("data-files/fruits-2.txt", skip = 2)
fruits2

#
fruits3 <- read.csv('data-files/fruits-3.csv', head)
fruits3

cols <- c("NO", "NAME", "PRICE", "QTY")
fruit4 <- read.csv("data-files/fruits-4.csv", header = F, col.names = cols)
fruit4

#
# install.packages("sqldf")
# install.packages("googleVis")

library(sqldf)
library(googleVis)

Fruits
write.csv(Fruits, "data-files/fruits-sql.csv", quote = F, row.names = F)

read.csv('data-files/fruits-sql.csv')
read.csv.sql("data-files/fruits-sql.csv", sql="SELECT * FROM file WHERE Year = 2008")

# 
# install.packages('readxl')
library(readxl)

df_exam <- read_excel('data-files/excel_exam.xlsx')
df_exam
df_exam2 <- as.data.frame(df_exam)
df_exam2

#
save(df_exam2, file = "data-files/df_exam2.rda")
rm(df_exam2)
df_exam2
load('data-files/df_exam2.rda')
df_exam2


#
# install.packages("RJDBC")
library(RJDBC)

driver2 <- JDBC("com.mysql.cj.jdbc.Driver",
                "jdbc-drivers/mysql-connector-java-8.0.23.jar",
                identifier.quote = "'")
conn2 <- dbConnect(driver2,
                   "jdbc:mysql://127.0.0.1:3306/employees?serverTimezone=UTC",
                   "root", "Pa$$w0rd")
rs2 <- dbGetQuery(conn2, "select * from employees limit 1, 10")
rs2 

dbDisconnect(conn2)
