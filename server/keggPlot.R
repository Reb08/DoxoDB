# ----------------------------------------------KEGG plot-------------------------------------------------------------------

# obtain full list of genes in Ensembl-ID and create new list in ENTREZ-ID
dedup_ids <- reactive({
  data <- studyInput_mutated() %>% dplyr::pull(Ensembl_ID)
  ids <-
    clusterProfiler::bitr(data,
                          fromType = "ENSEMBL",
                          toType = "ENTREZID",
                          OrgDb = "org.Hs.eg.db")
  dedup_ids = ids[!duplicated(ids[c("ENSEMBL")]), ]
})


data_kegg <- reactive({
  studyInput_mutated()[studyInput_mutated()$Ensembl_ID %in% dedup_ids()$ENSEMBL,]
}) 


# add new column to data with entrez-ID
data_kegg_mutated <- reactive({
  data_kegg() %>% mutate(EntrezID = dedup_ids()$ENTREZID)
})


# subset data based on user's choice of up or down regulated genes
KEGG_analysis_data <- reactive({
  if (input$expression2 == "up-regulated genes") {
    data_kegg_mutated()[data_kegg_mutated()$Significance == "Up-reg protein-coding gene" |
                          data_kegg_mutated()$Significance == "Up-reg lncRNA", ]
  } else {
    data_kegg_mutated()[data_kegg_mutated()$Significance == "Down-reg protein-coding gene" |
                          data_kegg_mutated()$Significance == "Down-reg lncRNA", ]
  }
})


# perform pathway analysis using clusterProfiler
KEGG_results <- reactive({
  
  gene_list <- KEGG_analysis_data()$EntrezID
  
  clusterProfiler::enrichKEGG(
    gene = gene_list,
    universe = data_kegg_mutated()$EntrezID,
    organism = "hsa",
    keyType = "ncbi-geneid"
  )
})


output$KEGG <- renderPlot({
  tryCatch({
    
    if (nrow(KEGG_results())== 0) {
      message <- "Sorry, no enriched terms found"
      plot.new()
      text(0.3, 0.9, message, cex = 1.1)
    } else {
      dotplot(
        KEGG_results(),
        showCategory = 20,
        title = "Enriched Pathways",
        font.size = 10
      )
    }
  },
  error = function(e) {
    message <- "Sorry, no enough DEGs identified"
    plot.new()
    text(0.5, 0.5, message, cex = 1.1)
  })
})
