student_list <- c("Scott B.",
                  "Tori B.",
                  "Tulsi G.",
                  "Scott K.",
                  "Preston P.",
                  "Chloe S.",
                  "Janalee T.")

shinyUI(
  fluidPage(
    titlePanel("R Programming for Research, Fall 2016"),
    
    id = "form", 
    
    fluidRow(

      column(3, 
             textInput("date", label = h3("Date input"), value = "2016-09-01") 
      ),
      
      column(3, 
             checkboxGroupInput("student_list", 
                                "Students in attendance",
                                choices = student_list,
                                selected = student_list),
             actionButton('makegroups', 'Student Groups'), 
             downloadButton('downloadData', 'Download')

             ),
      column(3, 
             DT::dataTableOutput('tbl')
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
