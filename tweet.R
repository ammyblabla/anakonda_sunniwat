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
tw <- twitteR::searchTwitter('#sweat16', n = 1e4, since = '2017-11-08', retryOnRateLimit = 1e3)
d <- twitteR::twListToDF(tw)
write_json(d, "tweet.json")