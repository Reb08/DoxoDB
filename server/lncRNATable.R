studyInput_lncRNA <- reactive({
  if(input$study_lncRNA == "GSE135842"){
    data <- data.frame(fread("data/GSE135842-All_lncRNAs.txt"))
  } else if (input$study_lncRNA == "GSE198396"){
    data <- data.frame(fread("data/GSE198396-All_lncRNAs.txt"))
  } else if (input$study_lncRNA == "GSE154101"){
    data <- data.frame(fread("data/GSE154101-All_lncRNAs.txt"))
  } else {
    data <- data.frame(fread("data/GSE163361-All_lncRNAs.txt"))
  }

  on.exit(rm(data))

  return(data)
})



# change the options for the "comparison" drop down menu (in ExplorePanel.R) based on the study selected in the "study" drop down menu (in ExplorePanel.R)
comparisons_lncRNA <- reactive({
  if(input$study_lncRNA == "GSE135842"){
    c("ctrl_p130_siCTRL vs DOX_p130_siCTRL",
      "ctrl_p130_siP107 vs DOX_p130_siP107",
      "ctrl_RB+p130_siCTRL vs DOX_RB+p130_siCTRL",
      "ctrl_RB+p130_siP107 vs DOX_RB+p130_siP107")
  } else if (input$study_lncRNA == "GSE198396"){
    c("Normal vs Doxo_PDL1-pos",
      "Normal vs Doxo_PDL1-neg")
  } else if (input$study_lncRNA == "GSE154101") {
    c("Normal vs Doxo-treated")
  } else {
    c("FCIBC02 Parent_ctrl vs Parent_Doxo",
      "SUM149 Parent_ctrl vs Parent_Doxo",
      "FCIBC02 Parent_ctrl vs DoxoR_ctrl",
      "SUM149 Parent_ctrl vs DoxoR_ctrl")

  }
})

observeEvent(input$study_lncRNA, {
  updateSelectInput(
    session,
    inputId = "comparison_lncRNA",
    label = "Select Comparison",
    choices = comparisons_lncRNA(),
    selected = comparisons_lncRNA()[1]
  )
})

my_table <- reactive({

  data <- studyInput_lncRNA()[studyInput_lncRNA()$Comparison == input$comparison_lncRNA, ] # only displays genes that belong to the right comparisons

  on.exit(rm(data))

  return(data)

})


output$downloadlncRNATable <- downloadHandler(


  # This function returns a string which tells the client browser what name to use when saving the file.
  filename = function() {
    paste(input$study_lncRNA, "-", input$comparison_lncRNA,"-lncRNA_table.tsv", sep = "")
  },

  # This function should write data to a file given to it by the argument 'file'.
  content = function(file) {

    # Write to a file specified by the 'file' argument
    write.table(my_table(), file,
                row.names = FALSE, quote=F, sep="\t")
  }
)


# might need to change this
output$table_lncRNA <- DT::renderDataTable({
  
  font.size <- "14px"

  DT::datatable(
    my_table()[, c("Ensembl_ID", "Gene_symbol", "logFC", "FDR", "LncBook.ID", "Type", "Conservation", "nearest.PC", "Top.correlated.gene")],
    selection = list(mode="single", selected=1),  # allows user to select only one row at a time
    options = list(lengthMenu = c(5, 10, 50), pageLength = 5, scrollX=T, rowHeight=10),
    rownames=FALSE
  )
})


selected_row2<- reactive({
  req(input$table_lncRNA_rows_selected)
  my_table()[input$table_lncRNA_rows_selected, ]
})

# render the right-hand output
output$selected_row_miRNA <- renderPrint({
  t <- selected_row2()$miRNA
  formatted_t <- gsub(",", "\n", t)
  cat(formatted_t)

  #cat(selected_row()$miRNA)
})

output$selected_row_GWAS <- renderPrint({
  t <- selected_row2()$GWAS
  formatted_t <- gsub(",", "\n", t)
  formatted_t2 <- gsub(";", "\n", formatted_t)
  cat(formatted_t2)
})



