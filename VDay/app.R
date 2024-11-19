# Let's make a shiny app using the Valentine's Day Dataset from TidyTuesday R.


#Load all the libraries
library(shiny)
library(tidytuesdayR)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(DT) # For interactive data tables



#Homework: needs one dynamic figure and one other output
#publish on shinyapps.io so it can be viewed online - CHECK
#need one other output?? 

#Data loading. We picked a vday themed dataset bc i'm a lover girl at heart!
valentine_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-13/gifts_age.csv')

#Let's make a bar graph for our dynamic figure. I want to be able to toggle between the age groups!
#I want to modify code using one of the demos from the shiny.posit.co
#https://github.com/rstudio/shiny-examples/blob/main/064-telephones-by-region/ui.R


# Define UI for the app
ui <- fluidPage(
  titlePanel("Valentine's Day Spending by Age Group"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        inputId = "age_group",
        label = "Select Age Groups:",
        choices = unique(valentine_data$Age), # Use unique age groups from the dataset
        selected = unique(valentine_data$Age) # Default to all age groups selected
      ),
      selectInput(
        inputId = "category",
        label = "Select Spending Category:",
        choices = colnames(valentine_data)[3:9], # Select spending columns
        selected = "Candy"
      )
    ),
    mainPanel(
      plotOutput(outputId = "spendingPlot"),
      DT::DTOutput(outputId = "filteredTable") # Use DTOutput for the table
    )
  )
)

# Define server 
server <- function(input, output) {
  # Reactive data filtered by age group
  filtered_data <- reactive({
    valentine_data %>%
      filter(Age %in% input$age_group)
  })
  
  # Generate spending plot
  output$spendingPlot <- renderPlot({
    filtered_data() %>%
      ggplot(aes(x = Age, y = !!sym(input$category), fill = Age)) +
      geom_bar(stat = "identity", position = "dodge") +
      theme_minimal() +
      labs(
        title = paste("Spending on", input$category, "by Age Group"),
        x = "Age Group",
        y = paste("Spending on", input$category)
      )
  })
  
  # Display filtered data table
  output$filteredTable <- DT::renderDT({
    filtered_data() %>%
      select(Age, all_of(input$category))
  }, options = list(pageLength = 10, scrollX = TRUE))
}

# Run the application
shinyApp(ui = ui, server = server)

#deployApp() #runs the app and updates automatically
