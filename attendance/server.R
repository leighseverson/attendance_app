library(shiny)
library(shinyjs)
library(dplyr)
library(tibble)
library(zoo)
library(DT)

student_list <- c("Marialexia",
                  "Colleen",
                  "Drew",
                  "Rebecca",
                  "Mackenzie",
                  "Elle",
                  "Kate",
                  "Katie",
                  "Brian",
                  "Lizette",
                  "Ethan",
                  "Maggie",
                  "Mercedes",
                  "Ray")

shinyServer(function(input, output) {
  
  form_data <- reactive({  
    attendance <- data.frame(name = input$student_list,
                       date = input$date,
                       timestamp = Sys.Date())
  })
  
  make_attendance_file <- reactive({
    attendance_file <- data.frame(student = student_list) %>%
      mutate(attended = as.numeric(student %in% input$student_list))
    
  })
  
  make_groups <- reactive({ 
    groups <- form_data() %>%
      select(name) %>%
      mutate(n = n(),
             n_groups = n %/% 2,
             Name = sample(name),
             Group = rep(1:n_groups[1], length.out = n[1])) %>%
      group_by(Group) %>%
      summarize(Students = paste(Name, collapse = ", ")) 
  }
    
 )
    
output$downloadData <- downloadHandler(
    filename = function() { paste("attendance_", input$date, ".csv", sep = "") },
    content = function(file) {
      write.csv(make_attendance_file(), file, row.names = FALSE)
    }
  )

observeEvent(input$makegroups, {
   output$tbl <- renderTable({
     make_groups()
    },
    caption = "Group assignments",
    caption.placement = "top",
    include.rownames = FALSE,
    include.colnames = FALSE)
})
 
  
#  observeEvent(input$download, {
#    
#    output$message <- renderText({
#      
#      progress <- shiny::Progress$new(session, min = 1, max = 10)
#      on.exit(progress$close())
#      
#      progress$set(message = 'Downloading form')
#      
#      for (i in 1:10) {
#        progress$set(value = i)
#        Sys.sleep(0.1)
#      }
#      "Thanks, your form has been downloaded."
#    })
#    
#  })
})