## using JQUERY and shinyJS
# Install and load the necessary packages
if (!require("shinydashboard")) install.packages("shinydashboard")
if (!require("shinyjs")) install.packages("shinyjs")


# Load necessary libraries
library(shiny)
library(shinyjs)
library(shinydashboard)

# Define UI
ui <- fluidPage(
  
  tags$head(
    tags$script(src = "https://cdn.jsdelivr.net/npm/sweetalert2@11.10.0/dist/sweetalert2.all.min.js"),
    tags$link(
      rel = "stylesheet",
      href = "https://cdn.jsdelivr.net/npm/sweetalert2@11.10.0/dist/sweetalert2.min.css"
    ),
    tags$script(src = "script.js")
  ),
  
  titlePanel("Data Pattern Visualization with JavaScript Button"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose CSV File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")
      ),
      
      useShinyjs(),  # Set up shinyjs
      textInput(inputId = "text", "Enter text here"),
      actionButton("btn", "Get text value"),
      actionButton("btn2", "Get the attribute id"),
      verbatimTextOutput("value"),
      verbatimTextOutput("value2"),
      
      
      tags$hr(),
      checkboxInput("header", "Header", TRUE),
      tags$hr(),
      tags$div(id = "buttonDiv",  HTML("<button id='myButton'>Click me!</button>")),
      tags$div(id = "buttonDiv", HTML("<button id='myButton2'>Other Things!</button>")),
      tags$div(id = "buttonDiv", HTML("<button id='myButton3'>More...</button>")),
      tags$div(id = "buttonDiv", HTML("<button id='myElement'>should i be here</button>")),
      tags$div(id = "buttonDiv", HTML("<button id='showButton'>Show</button>")),
      tags$div(id = "buttonDiv", HTML("<button id='hideButton'>Hide</button>")),

      # tags$script(HTML("
      #   $(document).ready(function(){
      #     $('#myButton').click(function(){
      #       alert('Button clicked!');
      #     });
      #   });
      # ")),
      tags$script(HTML("
        $(document).ready(function(){
          $('#myButton').dblclick(function(){
            alert('Button Double clicked!');
          });
        });
      ")),
    # tags$script(HTML("
    #     $(document).ready(function(){
    #       $('#myButton').mouseenter(function(){
    #         alert('Mouse entered the element!');
    #       });
    #     });
    #   ")),
    # 
    # tags$script(HTML("
    #     $(document).ready(function(){
    #       $('#myButton').mouseleave(function(){
    #         alert('Mouse left the element!');
    #       });
    #     });
    #   ")),
    
    tags$script(HTML("
        $(document).ready(function(){
          $('#myButton').keydown(function(){
            alert('Key is being pressed!');
          });
        });
      ")),
    
    tags$script(HTML("
        $(document).ready(function(){
          $('#myButton').keyup(function(){
            alert('Key was released!');
          });
        });
      ")),
    
    tags$script(HTML("
  $(document).ready(function(){
    $('#myButton2').click(function(){
      $('#myElement').slideUp('slow');
    });
  });
")),
    
    tags$script(HTML("
  $(document).ready(function(){
    $('#myButton2').click(function(){
      $('#myButton').slideUp('slow');
    });
  });
")),
    
    tags$script(HTML("
  $(document).ready(function(){
    $('#myButton3').click(function(){
      $('#myButton2').text('Did it work...!');
    });
  });
")),
    
    tags$script(HTML("
  $(document).ready(function(){
    $('#hideButton').click(function(){
      $('#myElement').hide();
    });
    $('#showButton').click(function(){
      $('#myElement').show();
    });
  });
"))
    
  ),
    mainPanel(
      plotOutput(
        "plot"
      ) %>% tagAppendAttributes(
        # Calling the function which has been defined in the 
        # external script
        onclick = "alertme('plot')"
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  
  observeEvent(input$btn, {
    # Run JavaScript code to get the value of the text input
    runjs('Shiny.setInputValue("text_val", $("#text").val());')
  })
  
  output$value <- renderPrint({
    input$text_val
  })
  
  observeEvent(input$btn2, {
    # Run JavaScript code to get the value of the text input
    runjs('Shiny.setInputValue("text_attr", $("#text").attr("id"));')
  })
  
  output$value2 <- renderPrint({
    input$text_attr
  })
  
  output$plot <- renderPlot({
    req(input$file1)
    df <- read.csv(input$file1$datapath, header = input$header)
    if (is.data.frame(df) && ncol(df) >= 2) {
      ggplot(df, aes(x=df[,1], y=df[,2])) + geom_point() + theme_minimal() +
        labs(x=names(df)[1], y=names(df)[2], title="Data Pattern Visualization")
    }
    #plot(iris)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
