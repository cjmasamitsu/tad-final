library(tidyverse)
library(shiny)
library(quanteda)
library(twitteR)
library(rtweet)
library(tidytext)
library(purrr)

# Data Preparation --------------------------------------------------------

#api_key <- "HWVzk33XVo4NnBIeskWlldF6s"
#api_secret_key <- "7iIOzHGP2Cr1fQpLNRhpQOh3kg0StusGAAngTZIhF8tpeGrv8j"
#access_token <- "51381814-ZiCjRmPFpjqO9v6FyFZGKDaGdnvPCR15PBdKwdqEP"
#access_token_secret <- "smMfC2hYy0OggQI98cQMtq9wbekNyqeza0qDN4YzwjJGY"

#token <- create_token(
#  app = "masamitsu-tad-final",
#  consumer_key = api_key,
#  consumer_secret = api_secret_key,
#  access_token = access_token,
#  access_secret = access_token_secret)

#senators <- 
  c("SenShelby",
    "Ttuberville",
    "lisamurkowski",
    "SenDanSullivan",
    "SenMarkKelly",
    "SenatorSinema",
    "SenTomCotton",
    "JohnBoozman",
    "SenFeinstein",
    "SenAlexPadilla",
    "SenatorBennet",
    "SenatorHick",
    "ChrisMurphyCT",
    "SenBlumenthal",
    "SenatorCarper",
    "ChrisCoons",
    "ScottforFlorida",
    "marcorubio",
    "ossoff",
    "ReverendWarnock",
    "brianschatz",
    "maziehirono",
    "MikeCrapo",
    "SenatorRisch",
    "SenDuckworth",
    "SenatorDurbin",
    "Braun4Indiana",
    "SenToddYoung",
    "ChuckGrassley",
    "joniernst",
    "RogerMarshallMD",
    "JerryMoran",
    "LeaderMcConnell",
    "RandPaul",
    "BillCassidy",
    "SenJohnKennedy",
    "SenAngusKing",
    "SenatorCollins",
    "ChrisVanHollen",
    "SenatorCardin",
    "senmarkey",
    "SenWarren",
    "SenGaryPeters",
    "SenStabenow",
    "amyklobuchar",
    "SenTinaSmith",
    "SenHydeSmith",
    "SenatorWicker",
    "HawleyMO",
    "RoyBlunt",
    "SteveDaines",
    "SenatorTester",
    "SenatorFischer",
    "BenSasse",
    "SenCortezMasto",
    "SenJackyRosen",
    "SenatorShaheen",
    "SenatorHassan",
    "CoryBooker",
    "SenatorMenendez",
    "MartinHeinrich",
    "SenatorLujan",
    "SenSchumer",
    "SenGillibrand",
    "SenatorBurr",
    "SenThomTillis",
    "SenJohnHoeven",
    "SenSherrodBrown",
    "SenRobPortman",
    "jiminhofe",
    "SenatorLankford",
    "RonWyden",
    "SenJeffMerkley",
    "SenBobCasey",
    "SenToomey",
    "SenJackReed",
    "SenWhitehouse",
    "GrahamBlog",
    "SenatorTimScott",
    "SenatorRounds",
    "SenJohnThune",
    "MarshaBlackburn",
    "BillHagertyTN",
    "JohnCornyn",
    "SenTedCruz",
    "SenatorRomney",
    "SenMikeLee",
    "SenatorLeahy",
    "SenatorSanders",
    "timkaine",
    "MarkWarner",
    "PattyMurray",
    "SenatorCantwell",
    "SenCapito",
    "Sen_JoeManchin",
    "SenatorBaldwin",
    "SenRonJohnson",
    "SenLummis",
    "SenJohnBarrasso")

# Pull 100 tweets per Senator
# sentweets <- get_timeline(senators, n = 1)

# Drop columns of lists for corpus/dfm
# sentweets_df <- sentweets[,-which(sapply(sentweets, class) == "list")]

# Create corpus and DFM
# sentweets_corpus <- corpus(as.character(sentweets_df$text))
# sentweets_dfm <- sentweets_corpus %>% 
#  tokens(remove_punct = TRUE) %>% 
#  dfm(tolower = TRUE, remove = stopwords("english")) %>% 
#  dfm_wordstem(.)

df <- data.frame(dose=c("D0.5", "D1", "D2"),
                 len=c(4.2, 10, 29.5))
p<-ggplot(data=df, aes(x=dose, y=len)) +
  geom_bar(stat="identity")

# Shiny UI ----------------------------------------------------------------

ui <- fluidPage(
  # Main Title
  titlePanel("How are United States Senators using Twitter to engage their constituents?"),
  navlistPanel(
    
    # Category 1
    "By State",
    tabPanel("Republicans",
             mainPanel(
               h2("test 1"),
               h4("test 2"),
               plotOutput("plot1")
             ))
  )
)


# Shiny Server ------------------------------------------------------------

server <- function(input, output){
  output$plot1 <- renderPlot({
    p
    
  })
}

shinyApp(ui = ui, server = server)

