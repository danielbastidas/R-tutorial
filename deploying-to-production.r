# deploying our model to production
install.packages('shiny')
library(shiny)
library(tree)
#library(caret)
#library(e1071)
# load color brewer library, previously installed
library(RColorBrewer)

# create UI
ui <- fluidPage("Hello World!")

# create a simple server without any operation
server <- function(input, output) {}
print(server)

# create a shiny app
shinyApp(
  ui = ui,
  server = server
)

ui <- fluidPage(
  titlePanel("input and output"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "num",
        label = "choose a number",
        min = 0,
        max = 100,
        value = 25
      )),
    mainPanel(
      textOutput(
        outputId = "text"
      )
    )
    )
  )

# create a server that maps input to output
server <- function(input, output) {
  output$text <- renderText({
    paste("you selected", input$num)
  })
}

shinyApp(
  ui = ui,
  server = server
)

setwd('/home/danielbastidas/git-repo/R-tutorial')

# load a previously created model. I'm loading the tree model
load("Tree.RData", parent.frame())
?load
ls()
print(model)

# create a color palette
palette <- brewer.pal(3,"Set2")

# create a user interface again
ui <- fluidPage(
  titlePanel("Iris species predictor"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "petal.length",
        label = "Petal Length (cm)",
        min = 1,
        max = 7,
        value = 4
      ),# sliderinput end
      sliderInput(
        inputId = "petal.width",
        label = "Petal Width (cm)",
        min = 0.0,
        max = 2.5,
        step = 0.5,
        value = 1.5
      ) # sliderinput end
    ),# sidebarpanel end
    mainPanel(
      textOutput(
        outputId = "text"
      ),
      plotOutput(
        outputId = "plot"
      )
    ) # mainpanel end
  ) # sidebarlayout end
)

# once again create a server
server <- function(input, output) {
  output$text = renderText({
    
    # create predictors
    predictors <- data.frame(
      Petal.Length = input$petal.length,
      Petal.Width = input$petal.width,
      Sepal.Length = 0, # assigning next to values in zero because they are not used in the prediction model
      Sepal.Width = 0
    )
    
    # make prediction
    prediction = predict(
      object = model,
      newdata = predictors,
      type = "class"
    )
    
    # create prediction text
    paste(
      "The predicted species is ",
      as.character(prediction)
    )
  }
  )
  
  output$plot = renderPlot({
    
    # create a scatter plot colored by species
    plot(
      x = iris$Petal.Length,
      y = iris$Petal.Width,
      pch = 19,
      col = palette[as.numeric(iris$Species)],
      main = "Iris petal length vs width",
      xlab = "petal length (cm)",
      ylab = "petal width (cm)"
    )
    
    # plot the decision tree boundaries
    partition.tree(
      model,
      label = "Species",
      add = TRUE
    )
    
    # draw predictor on plot
    points(
      x = input$petal.length,
      x = input$petal.width,
      col = "red",
      pch = 4, # plot character, this is the x in the plot
      cex = 2, # plot symbol size so it appears greater in the plot
      lwd = 2
    )
  })
}

# tie all together creating the app
shinyApp(
  ui = ui,
  server = server
)
