# ---------------------------------- Download Page -------------------------------------

tabPanel(title=list(icon("download"),"Download"),
         titlePanel(div(HTML("Download <em>DoxoDB</em> Data"))),
         
         p("All data in DoxoDB were processed from a snakemake pipeline available in the Analysis_of_Doxo_Studies ", tags$a(href="https://github.com/Reb08/Analysis_of_Doxo_Studies", "GitHub Repository")),
         
         fluidRow(
           column(3,
                  selectInput("dataset", h5("Select a dataset"),
                              choices = c("GSE135842", "GSE198396", "GSE154101", "GSE163361")),  # allow user to select dataset to download
                  radioButtons("filetype", "File type:",
                               choices = c("csv", "tsv")),  # allow user to select type of file
                  
                  downloadButton('downloadData', 'Download', class="btn-primary"),
                  br(),
                  helpText("It takes around 15 seconds for the download window to appear"),
                  
           ), # end column
           
           column(9,
                  div(DT::dataTableOutput("table2"), style = "font-size: 85%; width: 90%"))
         ) # end fluidRow
         
)