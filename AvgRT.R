install.packages("twitteR")
install.packages("magrittr")
install.packages("readr")
install.packages("jsonlite")
library(twitteR)
library(magrittr)
library(readr)
library(jsonlite)

setwd("C:/Users/User/Desktop/tweet")

consumer_key <- "4soP4FWea5Dk2SBtHwXCO8mcm"
consumer_secret <- "EwGR1Qab8zLOcnzyr7HoviaKJUYnJulDlpLlxIHEKp6xCfLias"
access_token <- "908136362280337409-TyyUFBYDi2pxjLVwdzZBbAzPsklX1Hz"
access_secret <- "FzieCcsaoST6scT8Lc2lXiD00yrKZk82kMkCVkx0neI4w"

write_json <- function(df, path, df_type = "rows", raw_type = "mongo"){
  require(readr)
  require(jsonlite)
  df %>% 
    toJSON(dataframe = df_type, raw = raw_type) %>%
    write_lines(path)
  df
}

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

get_ones_tweets <- function(user_name) {
  tw <- twitteR::userTimeline(user_name, n = 3200)
  d <- twitteR::twListToDF(tw)
  d <- d[!complete.cases(d[ , 4]),]
  
  avrg <- 0
  for (i in seq(1, nrow(d), 1)) {
    avrg <- avrg + d$retweetCount[i]
  }
  return(c((avrg/nrow(d)), nrow(d)))
}

middle <- get_ones_tweets("Pada_Sweat16")
result <- data.frame("Name" = "Pada_Sweat16", "AverageofRT" = middle[1], "Amount" = middle[2], stringsAsFactors=F)


middle <- get_ones_tweets("Proud_Sweat16")
result <- rbind(result, list("Proud_Sweat16", middle[1], middle[2]))

middle <- get_ones_tweets("Ant_Sweat16")
result <- rbind(result, list("Ant_Sweat16", middle[1], middle[2]))

middle <- get_ones_tweets("Petch_Sweat16")
result <- rbind(result, list("Petch_Sweat16", middle[1], middle[2]))

middle <- get_ones_tweets("Ae_Sweat16")
result <- rbind(result, list("Ae_Sweat16", middle[1], middle[2]))

middle <- get_ones_tweets("anny_sweat16")
result <- rbind(result, list("anny_sweat16", middle[1], middle[2]))

middle <- get_ones_tweets("Mint_Sweat16")
result <- rbind(result, list("Mint_Sweat16", middle[1], middle[2]))

middle <- get_ones_tweets("Pim_Sweat16")
result <- rbind(result, list("Pim_Sweat16", middle[1], middle[2]))

middle <- get_ones_tweets("Sonja_Sweat16")
result <- rbind(result, list("Sonja_Sweat16", middle[1], middle[2]))

middle <- get_ones_tweets("Music_Sweat16")
result <- rbind(result, list("Music_Sweat16", middle[1], middle[2]))

middle <- get_ones_tweets("Fame_Sweat16")
result <- rbind(result, list("Fame_Sweat16", middle[1], middle[2]))

middle <- get_ones_tweets("Nink_Sweat16")
result <- rbind(result, list("Nink_Sweat16", middle[1], middle[2]))

middle <- get_ones_tweets("MahnmookSweat16")
result <- rbind(result, list("MahnmookSweat16", middle[1], middle[2]))


write_json(result, "AvrofRT.json")
