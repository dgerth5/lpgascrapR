library(rvest)
library(tidyr)

url <- "https://www.lpga.com/tournaments/isps-handa-womens-australian-open/results?filters=2019" ## this is an example, insert desired tournament url here
webpage <- read_html(url)

ranking <- html_nodes(webpage, '.results .table-content:nth-child(1)')
rank <- html_text(ranking)

players <- html_nodes(webpage, '.player-toggle')
player <- html_text(players)
player <- gsub("\r","", player)
player <- gsub("\n","", player)
player <- gsub("\t","", player)

scores <- html_nodes(webpage, '.results .table-content:nth-child(3)')
score <- html_text(scores)
score <- gsub("\r","", score)
score <- gsub("\n","", score)
score <- gsub("\t","", score)

totals <- html_nodes(webpage, '.results .table-content:nth-child(4)')
total <- html_text(totals)
total <- as.numeric(total)

to_par <- html_nodes(webpage, '.results .table-content:nth-child(5)')
par <- html_text(to_par)

df <- data.frame(rank,player,score,total,par)
ab <- separate(df, score, c('R1', 'R2','R3','R4'), sep="\\-")
R1 <- ab$R1
R2 <- ab$R2
R3 <- ab$R3
R4 <- ab$R4
df <- data.frame(rank,player,R1,R2,R3,R4,total)
View(df)

