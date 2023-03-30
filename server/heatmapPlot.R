#----------------------------------- heatmap ------------------------------------------------------

file_lookup <- list(
  "ctrl_p130_siCTRL vs DOX_p130_siCTRL" = "GSE135842-1-Control_P130_siCTRL-vs-DOXO_P130_siCTRL.txt",
  "ctrl_p130_siP107 vs DOX_p130_siP107" = "GSE135842-2-Control_P130_siP107-vs-DOXO_P130_siP107.txt",
  "ctrl_RB+p130_siCTRL vs DOX_RB+p130_siCTRL" = "GSE135842-3-Control_RB+P130_siCTRL-vs-DOXO_RB-P130_siCTRL.txt",
  "ctrl_RB+p130_siP107 vs DOX_RB+p130_siP107" = "GSE135842-4-Control_RB+P130_siP107-vs-DOXO_RB-P130_siP107.txt",
  "Normal vs Doxo_PDL1-pos" = "GSE198396-1-Normal-vs-PDL1_pos.txt",
  "Normal vs Doxo_PDL1-neg" = "GSE198396-2-Normal-vs-PDL1_neg.txt",
  "Normal vs Doxo-treated" = "GSE154101-Normal-vs-Doxo.txt",
  "FCIBC02 Parent_ctrl vs Parent_Doxo" = "GSE136631-1-FCBIC02-Par_ctrl-vs-Par_Doxo.txt",
  "SUM149 Parent_ctrl vs Parent_Doxo" = "GSE136631-2-SUM149-Par_ctrl-vs-Par_Doxo.txt",
  "FCIBC02 Parent_ctrl vs DoxoR_ctrl" = "GSE136631-3-FCBIC02-Par_ctrl-vs-DoxoR_ctrl.txt",
  "SUM149 Parent_ctrl vs DoxoR_ctrl" = "GSE136631-4-SUM149-Par_ctrl-vs-DoxoR_ctrl.txt"
)  


# Get the file name based on the comparison choice
file_name <- reactive({
  file_lookup[[input$comparison]]
})  

selected_df <- reactive({
  # Get the file path based on the user input
  file_path <- file.path("data", file_name())
  
  # Load the data and cache it
  data <- data.frame(fread(file_path), row.names = 1, check.names = F)
  
  on.exit(rm(data))
  
  return(data)
})


# add column indicating whether the gene is an up- or down- regulated protein-coding gene or lncRNA
selected_df_mutated <- reactive({
  Sign <- case_when(
    selected_df()$logFC >= input$FC & selected_df()$FDR < input$FDR & selected_df()$Biotype == "Protein_Coding" ~ "Up-reg_Prot",
    selected_df()$logFC >= input$FC & selected_df()$FDR < input$FDR & selected_df()$Biotype == "lncRNA" ~ "Up-reg_lncRNA",
    selected_df()$logFC <= -input$FC & selected_df()$FDR < input$FDR & selected_df()$Biotype == "Protein_Coding" ~ "Down-reg_Prot",
    selected_df()$logFC <= -input$FC & selected_df()$FDR < input$FDR & selected_df()$Biotype == "lncRNA" ~ "Down-reg_lncRNA",
    TRUE ~ "Unchanged")
  
  cbind(Significance = Sign, selected_df())
})


# filter data to have only DEGs
heatmap_data <- reactive({
  filtered_data <- filter(selected_df_mutated(), Significance!="Unchanged")
  on.exit(rm(filtered_data))
  return(filtered_data)
})  


# further subset data based on whether user chooses to display protein-coding genes or lncRNAs genes
heatmap_data_subset <- reactive({
  if(input$gene_type2 == "lncRNA genes"){
    data <- heatmap_data()[heatmap_data()$Biotype=="lncRNA",]
  } else {
    data <- heatmap_data()[heatmap_data()$Biotype=="Protein_Coding",]
  }
  
  on.exit(rm(data))
  
  return(data)
})


# plot heatmap while catching errors that appear when there are no enough DEGs 
output$heatmap <- renderPlot({
  tryCatch(
    {
      pheatmap(heatmap_data_subset()[,7:(ncol(heatmap_data_subset()))],
               cluster_rows = T,
               cluster_cols = F,
               show_rownames = F,
               angle_col = "45",
               scale = "row",
               color = rev(morecols(100)),
               cex=1.1, 
               legend=T,
               main = input$comparison)
    }, 
    error = function(e) {
      if (grepl("must have n >= 2 objects to cluster", e$message)) {
        message <- "Sorry, no enough DEGs identified"
      } else if (grepl("'from' must be a finite number", e$message)) {
        message <- "Sorry, no enough DEGs identified"
      } 
      
      plot.new()
      text(0.5, 0.5, message, cex = 1.2)
      
    })
})