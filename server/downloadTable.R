#-------------------------------------------------table download------------------------------------------------------
datasetInput <- reactive({
  if(input$dataset == "GSE135842"){
    data <- data.table(fread("data/GSE135842-All_Samples.txt"))
  } else if (input$dataset == "GSE198396"){
    data <- data.table(fread("data/GSE198396-All_Samples.txt"))
  } else if (input$dataset == "GSE154101"){
    data <- data.table(fread("data/GSE154101-All_Samples.txt"))
  } else {
    data <- data.table(fread("data/GSE136631-All_Samples.txt"))
  }
  
  on.exit(rm(data))
  
  return(data)
})


output$table2 <- DT::renderDataTable(
  DT::datatable({
    datasetInput()
    
  }, options=list(scrollX=TRUE)))

output$downloadData <- downloadHandler(
  
  # This function returns a string which tells the client browser what name to use when saving the file.
  filename = function() {
    paste(input$dataset, input$filetype, sep = ".")
  },
  
  # This function should write data to a file given to it by the argument 'file'.
  content = function(file) {
    sep <- switch(input$filetype, "csv" = ",", "tsv" = "\t")
    
    # Write to a file specified by the 'file' argument
    write.table(datasetInput(), file, sep = sep,
                row.names = FALSE)
  }
)