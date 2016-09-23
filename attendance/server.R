library(shiny)
library(shinyjs)
library(dplyr)
library(tibble)
library(zoo)
library(DT)

student_list <- c("Scott B.",
                  "Tori B.",
                  "Tulsi G.",
                  "Scott K.",
                  "Preston P.",
                  "Chloe S.",
                  "Janalee T.")

shinyServer(function(input, output) {
  
  humanTime <- function() format(Sys.time(), "%Y%m%d")
  
  form_data <- reactive({  
    att_date <- as.Date(input$date, format = "%Y-%m-%d")
    timestamp <- as.Date(humanTime(), format = "%Y%m%d")
    
    attendance <- data.frame(name = input$student_list,
                       date = att_date,
                       timestamp = timestamp)
  })
  
  make_groups <- reactive({ 
    groups <- form_data() %>%
      select(name) %>%
      mutate(n = n(),
             n_groups = ifelse(n > 5, 3, 2),
             Name = sample(name),
             Group = rep(1:n_groups[1],
                         ceiling(n[1] / n_groups[1]))[1:n[1]]) %>%
      group_by(Group) %>%
      summarize(Students = paste(Name, collapse = ", ")) %>%
      select(-Group)
  }
    
 )
    
# output$downloadData <- downloadHandler(
#     filename = function() { paste(input$date, '.csv', sep = '') }, 
#     content = function(file) {
#       write.csv(formData(), file)
#     }
#   )

observeEvent(input$makegroups, {
   output$tbl <- DT::renderDataTable({
      datatable(make_groups())
    })
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