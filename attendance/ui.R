shinyUI(
  fluidPage(
    titlePanel("R Programming for Research Fall 2016"),
    
    id = "form", 
    
    fluidRow(

      column(3, 
             textInput("date", label = h3("Date input"), value = "2016-09-01") 
      ),
      
      column(3, 
             checkboxInput("Tulsi R.G.", "Tulsi R.G.", FALSE), 
             checkboxInput("Janalee T.", "Janalee T.", FALSE), 
             checkboxInput("Preston P.", "Preston P.", FALSE), 
             checkboxInput("Scott B.", "Scott B.", FALSE), 
             checkboxInput("Tori B.", "Tori B.", FALSE), 
             checkboxInput("Scott K.", "Scott K.", FALSE), 
             checkboxInput("Chloe S.", "Chloe S.", FALSE), 
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
