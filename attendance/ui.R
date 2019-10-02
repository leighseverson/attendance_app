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
