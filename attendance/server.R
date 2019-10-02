library(shiny)
library(shinyjs)
library(dplyr)
library(tibble)
library(zoo)
library(DT)

student_list <- c("Burton",
                  "Caroline", 
                  "Chaoyu",
                  "Collin",
                  "Daniel",
                  "Eric",
                  "Erin",
                  "Heather",
                  "Jacob",
                  "Jessica",
                  "Khum",
                  "Kyle",
                  "Matthew",
                  "Molly",
                  "Nikki",
                  "Rachel",
                  "Sere",
                  "Shayna",
                  "Sherry",
                  "Sunny"
                  )

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
             # Figure out how many groups there should be based on 
             # the number of people in class today
             n_groups = n %/% 2,
             # Create the right number of assignments to each group
             Group = rep(1:n_groups[1], length.out = n[1]), 
             # Shuffle the group assignments randomly
             Group = sample(Group)
             ) %>%
      group_by(Group) %>%
      summarize(Students = paste(name, collapse = ", ")) 
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
 
})
