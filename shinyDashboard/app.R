# library(rhino)
# rhino::init()
# rhino::build_js()
# replace .rhino/.gitignore with node_modules

ui <- dashboardPage(
  dashboardHeader(title = "Dynamic sidebar"),
  dashboardSidebar(
    sidebarMenu(
      tabItems(
        "tab1",
        tabItem("t_1", textInput("t_1a", "more text?"))
      ),
      textInput("t", "text here"),
      menuItemOutput("menuitem"),
      menuItemOutput("menuitem2"),
      textInput("t2", "text here")
    )
  ),
  dashboardBody()
)

server <- function(input, output) {
  output$menuitem <- renderMenu({
    menuItem("Menu item", icon = icon("calendar"))
  })

  output$menuitem2 <- renderMenu({
    menuItem("Menu item 2", icon = icon("calendar"))
  })
}

shinyApp(ui, server)
