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

shinyUI(
  fluidPage(
    
    id = "form", 
    
    fluidRow(

      column(3, 
             dateInput("date", label = "Class date",
                       value = Sys.Date()) 
      ),
      
      column(3, 
             checkboxGroupInput("student_list", 
                                "Students in attendance",
                                choices = student_list,
                                selected = student_list),
             actionButton('makegroups', 'Assign groups'), 
             downloadButton('downloadData', 'Download')

             ),
      column(3, 
             tableOutput('tbl')
             ),
      
      textOutput("message")
      
   #   shinyjs::toggle(
  #      div(
  #        id = "submit_another", 
  #        actionLink("submit_another", "Fill out a new form")
  #      )
  #    )
      
  
    )
    
       
#    shinyjs::hidden(
#      div(
#        id = "thankyou_msg", 
#        h3("Thanks, your form was downloaded!")
#      )
#    )

))

# attendance_app
