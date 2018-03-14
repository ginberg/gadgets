library(shiny)
library(miniUI)

googleSearchAddin <- function() {

  ui <- miniPage(
    mainPanel(
      htmlOutput("inc")
    )
  )

  server <- function(input, output, session) {

    # stop app on browser close
    session$onSessionEnded(stopApp)

    # Get the document context.
    context <- rstudioapi::getActiveDocumentContext()

    getPage<-function(searchString) {
      URL <- URLencode(paste0('https://www.google.com/search?q=', searchString))
      return((HTML(readLines(URL, warn=FALSE))))
    }
    output$inc<-renderUI({
      searchString <- context$selection[[1]]$text
      getPage(searchString)
    })

    observeEvent(input$done, {
      stopApp()
    })
  }

  runGadget(ui, server, viewer = browserViewer())
}
