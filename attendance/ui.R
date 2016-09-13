shinyUI(
  fluidPage(
    titlePanel("R Programming for Research Fall 2016"),
    
    id = "form", 
    
    fluidRow(

      column(3, 
             textInput("date", label = h3("Date input"), value = "2016-09-01") 
      ),
      
      column(3, 
             checkboxInput("Tulsi Ram Gompo", "Tulsi Ram Gompo", FALSE), 
             checkboxInput("Janalee Thompson", "Janalee Thompson", FALSE), 
             checkboxInput("Preston Phillips", "Preston Phillips", FALSE), 
             checkboxInput("Scott Braley", "Scott Braley", FALSE), 
             checkboxInput("Tori Burket", "Tori Burket", FALSE), 
             checkboxInput("Scott Kelleher", "Scott Kelleher", FALSE), 
             checkboxInput("Chloe Stenkamp", "Chloe Stenkamp", FALSE), 
             actionButton("download", "Download", class = "btn-primary")  
             
     
             
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
