student_list <- c("Jenni A.",
                  "Aeriel B.",
                  "Rebecca C.",
                  "Grant E.",
                  "Amy F.",
                  "Sarah H.",
                  "Yuqin J.",
                  "Alyssa M.",
                  "Camron P.",
                  "Anastasia R.",
                  "Kyle R.",
                  "Ana V.",
                  "Amanda W.",
                  "Kathleen W.",
                  "Kayla W.",
                  "Nichole M.",
                  "Marjo F.",
                  "Randy X.",
                  "Shayna W.",
                  "Katy K."
                  )

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

    )

))
