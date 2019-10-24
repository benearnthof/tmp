library(shiny)
library(shinyjs)
library(rlang)

ui <- fluidPage(
  includeScript("autoscroll.js"),
  shinyjs::useShinyjs(),
  textInput("expr", label = "Enter an R expression",
            value = "shinyjs::info('Hello!')"),
  actionButton("run", "Run", class = "btn-success"),
  shinyjs::hidden(
    div(
      id = "error",
      style = "color: red; font-weight: bold;",
      div("Could not evaluate expression without error. Try again."),
      div("Error: ", br(),
          span(id = "errorMsg", style = "margin-left: 10px;"))
    )
  ),
  verbatimTextOutput("test")
)

server <- function(input, output, session) {
  shinyEnv <- env()
  
  observeEvent(input$run, {
    shinyjs::hide("error")
    
    tryCatch(
      isolate(
        eval(parse(text = input$expr), envir = shinyEnv)
      ),
      error = function(err) {
        shinyjs::html("errorMsg", as.character(shiny::tags$i(err$message)))
        shinyjs::show(id = "error", anim = TRUE, animType = "fade")
      }
    )
  })
  observe({
    if (input$run < 1) {
      return()
    }
    output$test <- renderPrint(
      mget(ls(shinyEnv), envir = shinyEnv)
    )
  })
}

shinyApp(ui = ui, server = server)
