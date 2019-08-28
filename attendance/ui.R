student_list <- c("Caroline", 
                  "Cetan",
                  "Chaoyu",
                  "Collin",
                  "Daniel",
                  "Eric",
                  "Erin",
                  "Hazheen",
                  "Heather",
                  "Jacob",
                  "Jessica",
                  "Kristin",
                  "Kyle",
                  "Marcel Kate",
                  "Matthew",
                  "Patrick",
                  "Rachel",
                  "Sara",
                  "Shayna",
                  "Sherry",
                  "Tianqinq",
                  "Tyler"
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
