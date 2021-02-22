#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dotenv)
library(DBI)
library(RPostgreSQL)

# Loading the .env parameters to server 
load_dot_env(file = ".env")

# Making the connection 
DBI::dbDriver('PostgreSQL')
require(RPostgreSQL)
drv <- dbDriver("PostgreSQL")

# Connection URI
con <- dbConnect(
    drv, 
    dbname=Sys.getenv("POSTGRE_DB"), 
    host=Sys.getenv("POSTGRE_HOST"), 
    port=Sys.getenv("POSTGRE_PORT"), 
    user=Sys.getenv("POSTGRE_USER"), 
    password=Sys.getenv("POSTGRE_PASSWORD")
)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Heart failure API daily request count"),

    # Show a plot of the generated distribution
    mainPanel(
        plotOutput("dailyUsage")
    )
    )

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$dailyUsage <- renderPlot({
        # Getting data 
        d = dbGetQuery(
            con, 
            "SELECT date(dt), count(*) queries
            FROM requests
            group by date(dt)
            order by date(dt)")

        plot(d, type="b")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
