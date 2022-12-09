library(golem)
library(shinyMobile)

# create a Shiny module for selecting a letter
mod1 <- golem("LetterSelector")

# define the UI for the module
mod1$ui <- mobilePage(
  h1("Select a Letter"),
  selectInput("letter", "Select a letter:", letters),
  actionButton("submit", "Submit")
)

# define the server logic for the module
mod1$server <- function(input, output, session) {
  # when the submit button is clicked, print the selected letter
  observeEvent(input$submit, {
    print(input$letter)
  })
}

# create a Shiny module for counting the number of times a letter appears in a text
mod2 <- gollem("LetterCounter")

# define the UI for the module
mod2$ui <- mobilePage(
  h1("Count the Number of Times a Letter Appears"),
  textAreaInput("text", "Enter some text:"),
  actionButton("count", "Count")
)

# define the server logic for the module
mod2$server <- function(input, output, session) {
  # when the count button is clicked, count the number of times the selected letter appears in the text
  observeEvent(input$count, {
    # get the selected letter from the first module
    letter <- callModule(mod1, "letter")
    # count the number of times the letter appears in the text
    count <- sum(grepl(letter, input$text))
    # print the count
    print(count)
  })
}

# run the Shiny app
runApp(
  mobilePage(
    mod1,
    mod2
  )
)