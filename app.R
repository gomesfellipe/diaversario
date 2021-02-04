library(shiny)
library(shinydashboard)
library(shinyjs)
library(shinyWidgets)
library(shinydashboardPlus)
library(vov)

ui <- fluidPage(title = "diaversario",
                use_vov(),
                useShinyjs(),
                setBackgroundImage(
                    src = "https://images.clipartlogo.com/files/istock/previews/9382/93824905-color-glossy-happy-birthday-balloons-banner-background-vector.jpg"
                ),
                tags$head(tags$link(rel = "stylesheet", type = "text/css",
                                    href = "infobox.css")),
                theme = bslib::bs_theme(version = 4, bootswatch = "sketchy"),
                
                titlePanel(vov::fade_in_down(div("Qual sua idade em dias?"))),
                
                sidebarLayout(
                    sidebarPanel(
                        dateInput("born",
                                  "Informe sua data de nascimento:",
                                  value = Sys.Date()),
                        actionButton(inputId = "button", label = "Calcular!"),
                        helpText("Nenhum dado é armazenado.", br(),
                                 "Código aberto, confira ", tags$a(href="https://www.github.com/gomesfellipe/diaversario", "aqui"))
                    )
                    ,
                    
                    mainPanel(
                        uiOutput("frame"),
                        uiOutput("n_day"), br(),
                        uiOutput("n_10000"), br(),
                        uiOutput("day_10000"), br()
                        
                    )
                ),
                br(),
                div(style = 'font-size: 8pt; color: #5c5b5f; text-align:left',
                    tags$em("By", tags$a(href="https://gomesfellipe.github.io/", "Fellipe Gomes"), 
                            " - 2021"),
                    socialButton(url = "https://www.linkedin.com/in/gomesfellipe/", type = "linkedin"),
                    socialButton(url = "http://github.com/gomesfellipe", type = "github"),
                    socialButton(url = "https://medium.com/@gomesfellipe", type = "medium"),
                    socialButton(url = "https://www.kaggle.com/gomes555", type = "kaggle"))
)

server <- function(input, output, session) {  
    
    observeEvent(input$button, {
        hide("frame")
    })
    
    output$frame <- renderUI({
        url = "https://giphy.com/embed/dyjL2vi0AocEEE6ZkA"
        my_test <- tags$iframe(src=url, height=100, width=200, frameBorder=0)
        print(my_test)
        my_test
    })
    
    observeEvent(input$button, {
        
        if(input$born != Sys.Date()){
            # dias corridos
            output$n_day <- renderUI({
                
                req(input$button)
                
                n = difftime(Sys.Date(), input$born)
                
                infoBox(title = "", glue::glue("Você tem {format(as.numeric(n), big.mark='.', decimal.mark=',')} dias de vida!"), 
                        icon = icon("birthday-cake"), color = "yellow", width = 6, )
            })
            
            # completa 10.000 dias de vida em:
            output$n_10000 <- renderUI({
                
                req(input$button)
                
                day = input$born+lubridate::days(10000)
                
                if(input$born < Sys.Date() - lubridate::days(10000)){
                    txt <- "Você já competou 10.000 dias de vida!"
                }else{
                    txt <- glue::glue("Completará 10.000 no dia {format(day, '%d/%m/%Y')}")
                }
                
                infoBox(title = "", txt,
                        icon = icon("calendar", lib = "glyphicon"), color = "yellow", width = 6)   
            })
            
            # Faltam quantos dias para 10000?
            output$day_10000 <- renderUI({
                
                req(input$button)
                
                day = difftime(input$born+lubridate::days(10000), Sys.Date())
                
                if(input$born < Sys.Date() - lubridate::days(10000)){
                    txt <- "Parabéns!"
                }else{
                    txt <- glue::glue("Faltam {format(as.numeric(day), big.mark='.', decimal.mark=',')} dias para seu 10.000º diaversário!")
                }
                
                infoBox(title = "", txt,
                        icon = icon("clock"), color = "yellow", width = 6)
            })
            
        }else{
            sendSweetAlert(
                session = session,
                title = "ERRO !!",
                text = "Insira data de nascimento!",
                type = "error")
        }
        
    })
    
}

shinyApp(ui = ui, server = server)