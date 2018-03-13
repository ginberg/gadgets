library(shiny)
library(miniUI)

googleSearchAddin <- function() {

  ui <- miniPage(
    mainPanel(
      htmlOutput("inc")
    )
  )

  server <- function(input, output, session) {

    # Get the document context.
    context <- rstudioapi::getActiveDocumentContext()
    print(context)

    getPage<-function(searchString) {
      URL <- URLencode(paste0('https://www.google.com/search?q=', searchString))
      print(URL)
      return((HTML(readLines(URL))))
    }
    output$inc<-renderUI({
      searchString <- context$selection[[1]]$text
      getPage(searchString)
    })

    observeEvent(input$done, {
      stopApp()
    })
  }

  runGadget(ui, server)
}
