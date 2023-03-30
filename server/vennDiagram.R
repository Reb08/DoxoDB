#------------------------------------------------- Venn Diagram ------------------------------------------------------

# creates list of up- or down-regulated genes from all the comparisons of the selected study based on the selected expression pattern 

gene_sets <- reactive ({
  lapply(comparisons(), function(c) {
    
    if (input$expression3 == "up-regulated genes") {
      c <- studyInput() %>%
        filter(Comparison == c & logFC >= input$FC & FDR <= input$FDR) %>%
        pull(Ensembl_ID)
    } else {
      c <- studyInput() %>%
        filter(Comparison == c & logFC <= - input$FC & FDR <= input$FDR) %>%
        pull(Ensembl_ID)
    }
    
  })%>% setNames(comparisons())
  
})

output$VENN <- renderPlot({
  
  if (input$study == "GSE154101"){
    
    shinyjs::show("p_onecomparison")
    
  } else if (input$study == "GSE135842" ) {
    
    shinyjs::hide("p_onecomparison")
    
    plot(eulerr::venn(gene_sets()),  fills = list(myCol1),
         labels = NULL, quantities = TRUE, legend = list(labels=comparisons()))
    
  } else if (input$study == "GSE163361") {
    
    shinyjs::hide("p_onecomparison")
    
    plot1 <- plot(eulerr::venn(gene_sets()[1:2]), fill = myCol2, labels = NULL, quantities = TRUE, legend = list(labels=comparisons()[1:2]), main = " ")
    plot2 <- plot(eulerr::venn(gene_sets()[3:4]), fill = myCol1, labels = NULL, quantities = TRUE, legend = list(labels=comparisons()[3:4]), main = " ")
    grid.arrange(plot1, plot2)
    
  } else {
    shinyjs::hide("p_onecomparison")
    
    plot(eulerr::venn(gene_sets()), fill=myCol2)
    
  }
})