library(shiny)
library(shinyjs)
library(dplyr)
library(tibble)
library(zoo)
library(DT)

shinyServer(function(input, output) {
  
  humanTime <- function() format(Sys.time(), "%Y%m%d")
  
  fieldsAll <- c("date", "Tulsi R.G.", "Janalee T.", "Preston P.", 
                 "Scott B.", "Tori B.", "Scott K.", "Chloe S.")
  
  formData <- reactive({  
    data <- sapply(fieldsAll, function(x) input[[x]])
    data <- c(data, timestamp = humanTime())
    data <- as.data.frame(data)
    data <- rownames_to_column(data)
    
    att_date <- as.Date(data$data[1], format = "%Y-%m-%d")
    
    timestamp <- as.Date(data$data[9], format = "%Y%m%d")
    
    data$date <- att_date
    data$timestamp <- timestamp 
    
    data <- data[2:8,]
    rownames(data) <- c(1:7)
    colnames(data) <- c("name", "here", "date", "timestamp")
    
  })
  
  Groups <- reactive({ 
    data <- sapply(fieldsAll, function(x) input[[x]])
    data <- c(data, timestamp = humanTime())
    data <- as.data.frame(data)
    data <- rownames_to_column(data)
    
    att_date <- as.Date(data$data[1], format = "%Y-%m-%d")
    
    timestamp <- as.Date(data$data[9], format = "%Y%m%d")
    
    data$date <- att_date
    data$timestamp <- timestamp 
    
    data <- data[2:8,]
    rownames(data) <- c(1:7)
    colnames(data) <- c("name", "here", "date", "timestamp")
    
    groups <- data %>%
      filter(here == 1) %>%
      select(name) %>%
      mutate(n = n(), 
             n_groups = ifelse(n > 5, 3, 2), 
             Name = sample(name), 
             Group = rep(1:n_groups[1], 
                         ceiling(n[1] / n_groups[1]))[1:n[1]]) %>%
      group_by(Group) %>%
      summarize(Students = paste(Name, collapse = ", "))
    
    groups
  }
    
 )
    
output$downloadData <- downloadHandler(
    filename = function() { paste(input$date, '.csv', sep = '') }, 
    content = function(file) {
      write.csv(formData(), file)
    }
  )

observeEvent(input$makegroups, {
    output$tbl <- DT::renderDataTable({
      groups <- Groups()
      datatable(groups)
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