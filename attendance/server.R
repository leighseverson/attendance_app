library(shiny)
library(shinyjs)
library(dplyr)
library(tibble)
library(zoo)

shinyServer(function(input, output, session) {
  output$download <- downloadHandler({
    filename = function() {
      paste0("attendance_", humanTime(), ".csv")
    }
    
         content = function(file) {
        write.csv(loadData(), file, row.names = FALSE)
      }
      
    })
  
  
  humanTime <- function() format(Sys.time(), "%Y%m%d")
  
  fieldsAll <- c("date", "Tulsi Ram Gompo", "Janalee Thompson", "Preston Phillips", 
                 "Scott Braley", "Tori Burket", "Scott Kelleher", "Chloe Stenkamp")

  
  formData <- reactive({
    
   # fieldsAll[1] <- as.Date(fieldsAll[1], format = "%Y-%m-%d")
    
    data <- sapply(fieldsAll, function(x) input[[x]])
    data <- c(data, timestamp = humanTime())
    data <- as.data.frame(data)
    data <- rownames_to_column(data)
    
  #  date_char <- as.character(data$data[1])
  #  date_num <- as.numeric(date_char)
    att_date <- as.Date(data$data[1], format = "%Y-%m-%d")
    
    timestamp <- as.Date(data$data[9], format = "%Y%m%d")
    
    data$date <- att_date
    data$timestamp <- timestamp 
    
    data <- data[2:8,]
    rownames(data) <- c(1:7)
    data
    #colnames(data) <- c("name", "here", "date", "timestamp")
    
  })
  
  
  compute_data <- function(updateProgress = NULL) {
    # Create 0-row data frame which will be used to store data
    dat <- data.frame(x = numeric(0), y = numeric(0))
    
    for (i in 1:10) {
      Sys.sleep(0.25)
      
      # Compute new row of data
      new_row <- data.frame(x = rnorm(1), y = rnorm(1))
      
      # If we were passed a progress update function, call it
      if (is.function(updateProgress)) {
        text <- paste0("x:", round(new_row$x, 2), " y:", round(new_row$y, 2))
        updateProgress(detail = text)
      }
      
      # Add the new row of data
      dat <- rbind(dat, new_row)
    }
    
    dat
  }
  
      observeEvent(input$download, {
        
        output$message <- renderText({
          
          progress <- shiny::Progress$new(session, min = 1, max = 10)
          on.exit(progress$close())
          
          progress$set(message = 'Downloading form')
          
          for (i in 1:10) {
            progress$set(value = i)
            Sys.sleep(0.1)
          }
          "Thanks, your form has been downloaded."
        })
        
        
      #  progress <- shiny::Progress(message = "Downloading form", value = 0)
      #  on.exit(progress$close())
      #  
      #  updateProgress <- function(value = NULL, detail = NULL) {
      #    if (is.null(value)) {
      #      value <- progress$getValue()
      #      value <- value + (progress$getMax() = value) / 5
      #    }
      #    progress$set(value = value, detail = detail)
      #    compute_data(updateProgress)
      #  }
      
      out_directory <- "~/Desktop/attendance"
      if(!dir.exists(out_directory)){
        dir.create(out_directory)
      }
      
      out_file <- paste0(out_directory, "/", Sys.time(), ".rds")
      
      saveRDS(object = formData(), file = out_file)
      
   #   shinyjs::toggle("form")
   #   shinyjs::toggle("submit_another")
      
    })
      
   #   observeEvent(input$submit_another, {
  #      shinyjs::toggle("form")
  #      shinyjs::toggle("message")
  #    })
    

})


