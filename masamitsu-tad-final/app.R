

# Load Packages -----------------------------------------------------------

# library(shiny)
library(tidyverse)
library(quanteda)
library(twitteR)
library(rtweet)
library(tidytext)
library(purrr)
library(naivebayes)
library(e1071)


# Pull Tweets  ------------------------------------------------------------

# Code has been hashed out, only pulled data once which requires manual inputs after original DF was created
# api_key <- "HWVzk33XVo4NnBIeskWlldF6s"
# api_secret_key <- "7iIOzHGP2Cr1fQpLNRhpQOh3kg0StusGAAngTZIhF8tpeGrv8j"
# access_token <- "51381814-ZiCjRmPFpjqO9v6FyFZGKDaGdnvPCR15PBdKwdqEP"
# access_token_secret <- "smMfC2hYy0OggQI98cQMtq9wbekNyqeza0qDN4YzwjJGY"

# token <- create_token(
#   app = "masamitsu-tad-final",
# consumer_key = api_key,
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

# Pull 115 tweets per Senator
# sentweets <- get_timeline(senators, n = 115)

# Write results to CSV for manual entry of categories
# write_csv(sentweets, "sentweets.csv")


# Data Preparation --------------------------------------------------------

sentweets <- read_csv("sentweets.csv")
glimpse(sentweets)

# Change names to be uniform
sentweets$name %>% unique(.)
sentweets["name"][sentweets["name"] == "Sen. Lisa Murkowski"] <- "Lisa Murkowski"
sentweets["name"][sentweets["name"] == "Sen. Dan Sullivan"] <- "Dan Sullivan"
sentweets["name"][sentweets["name"] == "Senator Mark Kelly"] <- "Mark Kelley"
sentweets["name"][sentweets["name"] == "Senator John Boozman"] <- "John Boozman"
sentweets["name"][sentweets["name"] == "Senator Dianne Feinstein"] <- "Dianne Feinstein"
sentweets["name"][sentweets["name"] == "Senator Alex Padilla"] <- "Alex Padilla"
sentweets["name"][sentweets["name"] == "Senator John Hickenlooper"] <- "John Hickenlooper"
sentweets["name"][sentweets["name"] == "Senator Tom Carper"] <- "Tom Carper"
sentweets["name"][sentweets["name"] == "Senator Chris Coons"] <- "Chris Coons"
sentweets["name"][sentweets["name"] == "Reverend Raphael Warnock"] <- "Raphael Warnock"
sentweets["name"][sentweets["name"] == "Senator Mazie Hirono"] <- "Mazie Hirono"
sentweets["name"][sentweets["name"] == "Senator Mike Crapo"] <- "Mike Crapo"
sentweets["name"][sentweets["name"] == "Senator Dick Durbin"] <- "Dick Durbin"
sentweets["name"][sentweets["name"] == "Senator Todd Young"] <- "Todd Young"
sentweets["name"][sentweets["name"] == "ChuckGrassley"] <- "Chuck Grassley"
sentweets["name"][sentweets["name"] == "Senator Jerry Moran"] <- "Jerry Moran"
sentweets["name"][sentweets["name"] == "Senator Angus King"] <- "Angus King"
sentweets["name"][sentweets["name"] == "Sen. Susan Collins"] <- "Susan Collins"
sentweets["name"][sentweets["name"] == "Senator Chris Van Hollen"] <- "Chris Van Hollen"
sentweets["name"][sentweets["name"] == "Senator Ben Cardin"] <- "Ben Cardin"
sentweets["name"][sentweets["name"] == "Senator Gary Peters"] <- "Gary Peters"
sentweets["name"][sentweets["name"] == "Sen. Debbie Stabenow"] <- "Debbie Stabenow"
sentweets["name"][sentweets["name"] == "Senator Tina Smith"] <- "Tina Smith"
sentweets["name"][sentweets["name"] == "U.S. Senator Cindy Hyde-Smith"] <- "Cindy Hyde-Smith"
sentweets["name"][sentweets["name"] == "Senator Roger Wicker"] <- "Roger Wicker"
sentweets["name"][sentweets["name"] == "Senator Roy Blunt"] <- "Roy Blunt"
sentweets["name"][sentweets["name"] == "Senator Jon Tester"] <- "John Tester"
sentweets["name"][sentweets["name"] == "Senator Deb Fischer"] <- "Deb Fischer"
sentweets["name"][sentweets["name"] == "Senator Cortez Masto"] <- "Cortez Masto"
sentweets["name"][sentweets["name"] == "Senator Jacky Rosen"] <- "Jacky Rosen"
sentweets["name"][sentweets["name"] == "Sen. Jeanne Shaheen"] <- "Jeanne Shaheen"
sentweets["name"][sentweets["name"] == "Sen. Maggie Hassan"] <- "Maggie Hassan"
sentweets["name"][sentweets["name"] == "Senator Bob Menendez"] <- "Bob Menendez"
sentweets["name"][sentweets["name"] == "Senator Ben Ray Luján"] <- "Ben Ray Luján"
sentweets["name"][sentweets["name"] == "Senator Thom Tillis"] <- "Thom Tillis"
sentweets["name"][sentweets["name"] == "Senator John Hoeven"] <- "John Hoeven"
sentweets["name"][sentweets["name"] == "Sen. Jim Inhofe"] <- "Jim Inofe"
sentweets["name"][sentweets["name"] == "Sen. James Lankford"] <- "James Lankford"
sentweets["name"][sentweets["name"] == "Senator Jeff Merkley"] <- "Jeff Merkley"
sentweets["name"][sentweets["name"] == "Senator Bob Casey"] <- "Bob Casey"
sentweets["name"][sentweets["name"] == "Senator Pat Toomey"] <- "Pat Toomey"
sentweets["name"][sentweets["name"] == "Senator Jack Reed"] <- "Jack Reed"
sentweets["name"][sentweets["name"] == "Senator Mike Rounds"] <- "Mike Rounds"
sentweets["name"][sentweets["name"] == "Senator John Thune"] <- "John Thune"
sentweets["name"][sentweets["name"] == "Sen. Marsha Blackburn"] <- "Marsha Blackburn"
sentweets["name"][sentweets["name"] == "Senator John Cornyn"] <- "John Cornyn"
sentweets["name"][sentweets["name"] == "Senator Ted Cruz"] <- "Ted Cruz"
sentweets["name"][sentweets["name"] == "Senator Mitt Romney"] <- "Mitt Romney"
sentweets["name"][sentweets["name"] == "Sen. Patrick Leahy"] <- "Patrick Leahy"
sentweets["name"][sentweets["name"] == "Sen. Maria Cantwell"] <- "Maria Cantwell"
sentweets["name"][sentweets["name"] == "Senator Patty Murray"] <- "Patty Murray"
sentweets["name"][sentweets["name"] == "Senator Joe Manchin"] <- "Joe Manchin"
sentweets["name"][sentweets["name"] == "Sen. Tammy Baldwin"] <- "Tammy Baldwin"
sentweets["name"][sentweets["name"] == "Senator Ron Johnson"] <- "Ron Johnson"
sentweets["name"][sentweets["name"] == "Sen. John Barrasso"] <- "John Barrasso"
sentweets["name"][sentweets["name"] == "Senator Cynthia Lummis"] <- "Cynthia Lummis"
sentweets["name"][sentweets["name"] == "Bill Cassidy, M.D."] <- "Bill Cassidy"
sentweets["name"][sentweets["name"] == "Dr. Roger Marshall"] <- "Roger Marshall"
sentweets["name"][sentweets["name"] == "Leader McConnell"] <- "Mitch McConnell"
sentweets["name"][sentweets["name"] == "Sen. Bernie Sanders"] <- "Bernie Sanders"
sentweets$name %>% unique(.)

sentweets_corpus <- corpus(as.character(sentweets_df$text))
sentweets_dfm <- sentweets_corpus %>% 
  tokens(remove_punct = TRUE) %>% 
  dfm(tolower = TRUE, remove = stopwords("english")) %>% 
  dfm_wordstem(.)

# Naive Bayes Analysis ----------------------------------------------------

train_matrix = as.matrix(sentweets)
dependent = as.factor(sentweets$category)

nb = e1071::naiveBayes(
  x = train_matrix,
  y = dependent,
  method = "class")

nb_prediction <- predict(nb, train_matrix)

results = data.frame(
  Predictions = nb_prediction,
  Actuals = dependent
)

df <- select(sentweets, name, party, region)
df$category <- results$Predictions
df$category <- as.character(df$category)


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
  tags$br(),
    titlePanel("What type of rhetoric are United States Senators using on Twitter?", "Twitter Rhetoric"),
  tags$br(),
    fluidRow(
      column(4,
             wellPanel(
               selectInput("region", "Region", df$region %>% 
                             append("(All)") %>% 
                             sort()),    
             )
      ),
      column(4,
             wellPanel(
               selectInput("party", "Party", df$party %>% 
                             append("(All)") %>% 
                             sort()),
             )
      ),
      column(4,
             wellPanel(
               selectInput("name", "Name", df$name %>% 
                             append("(All)") %>% 
                             sort()),
             )
      ), 
    ),
    
    # Bar Chart
    tags$br(),
    tags$hr(),
    p("United States Senators are using Twitter in different ways. Some senators use Twitter as a platform to communicate upcoming events and policy updates. Other senators use Twitter to criticize or praise others. The dashboard below demonstrates how each senator is using Twitter individually as well as by region and party affiliation."),
    tags$hr(),
    tags$br(),
    tags$br(),
    
    h4("Senatorial Tweets by Rhetoric"),
    plotOutput("categoryBar1"),
    tags$br(),
    tags$br(),
    tags$br(),
    
    tags$hr(),
    h4("Methodological Approach:"),
    p("The goal of the dashboard is to address the question, “What rhetoric are United States using when talking about others on Twitter?”* First, the Twitter API was used to download senators’ Tweets. Next, a portion of the Tweets were categorized manually, and finally, Naïve Bayes was conducted to predict the category of the remaining Tweets. "),
    tags$br(),
    
    tags$hr(),
    h4("Data Collection:"),
    p("The first step in downloading senators’ Tweets was creating a list of all 100 senators’ Twitter handles. Afterward, the maximum allowable requests through the Twitter API were utilized to download as many Tweets per senator as possible. The result is approximately 115 Tweets per senator, which was scraped on April 28th, 2022. The final dataset includes 11,287 Tweets from all 100 senators. While 11,500 Tweets were expected, some senators did not have 115 Tweets and Bernie Sander’s Twitter handle recently changed so only one Tweet was included."), 
    p("In addition, not all senators’ names were in the same format. For example, some senators chose Twitter names like “Sen. Susan Collins,” or “Senator Bob Menendez,” but others chose solely their name. All names were updated to reflect solely the senator’s first and last name."),
    tags$br(),
    
    tags$hr(),
    h4("Methods of Analysis:"),
    p("Categorizing senatorial Tweets into three distinct categories was a difficult endeavor. For simplicity, the categories chosen are only reflective of their rhetoric about another individual or group."),
    p("Below is an example of how the Tweets were categorized manually:"),
    tags$ul(
      tags$li('“Climate change is bad” | Neutral'),
      tags$li('“Climate change is good” | Neutral'),
      tags$li('“The Biden Administration’s handling of climate change is bad.” | Critical'),
      tags$li('“The Biden Administration’s handling of climate change is good.” | Praise')
    ),
    p("In addition to adding a “category” column, “region” and “party” columns were also added manually for dashboard filtering. "),
    p("In order to use Naïve Bayes to predict the majority of Tweets, approximately 20 Tweets per senator were manually labeled as “critical,” “neutral,” or “praise. Once these Tweets were appropriately labeled, Naïve Bayes was conducted to predict the rest. In the end, the predictions were added to a dataframe with the “name,” “region,” and “party” variables.  This dataset is used to display the results in a bar plot in the above dashboard. "),
    tags$br(),
 
    tags$hr(),
    h4("Methodology Evaluation:"),
    p("Once over 15% of the Tweets were manually categorized, the Naïve Bayes model performed well in predicting the category. Comparing the actual (manually-entered) category with the predicted category shows that majority of the Tweets were predicted correctly. By proxy, manually-entered categories are subject to subconscious bias. The three categories were specifically chosen to maintain a bipartisan point of view. The Tweet labels “critical,” “neutral,” and “praise” fit objectively in those categories."),
    p("In addition, the results are not from a single timeframe and were scraped statically. Some senators Tweet much more often than others – and as a result, individual senators’ Tweets should be assessed carefully. "),
    tags$br(),
    
    tags$hr(),
    h4("Suggestions for Improvement:"),
    p("In the future, this dashboard could be improved by:"),
    tags$ul(
      tags$li("Expanding the Twitter developer API access to allow more Tweets to be downloaded per senator"),
      tags$li("Scraping the Tweets dynamically based on the date the dashboard is accessed"),
      tags$li("Fixing Bernie Sander’s Twitter handle to include his Tweets"),
      tags$li("Adding a date range filter to look at Tweets during a specific day, week, or month"),
      tags$li("Adding an additional label for current events so rhetoric around a specific issue could be assessed"),
    ),
    tags$br(),
    tags$br(),
    tags$br()
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$categoryBar1 <- renderPlot({
      
      if (input$name != "(All)") {
        df <- filter(df, name == input$name)
      }
  
      if (input$party != "(All)") {
        df <- filter(df, party == input$party)
      }
      
      if (input$region != "(All)") {
        df <- filter(df, region == input$region)
      }
      
      ggplot(df, aes(category)) +
        geom_bar(aes(fill = category)) +
        scale_fill_manual("Rhetoric", values = c("critical" = "indianred1", "neutral" = "lightgoldenrod1", "praise" = "seagreen2")) +
        xlab("Category of Tweets") +
        ylab("Number of Tweets") +
        labs(caption = "Data from Twitter | Collected on April 28,2022 by Casey Masamitsu") +
        theme_minimal()
      
  })
}
    

# Run the application 
shinyApp(ui = ui, server = server)




