# ----------------------------------------- Documentation Page ------------------------------------------------------------

tabPanel(title=list(icon("circle-info"),"Documentation"),
         fluidRow(
           
           column(7, offset=2, 
                  navlistPanel(
                    tabPanel("Home",
                             h3(em("DoxoDB"), "Documentation"),
                             h6("v1.0.0"),
                             p("2023-05-03"),
                             p(strong("DoxoDB"), "is a web database for", strong("accessing and exploring expression data of Doxorubicin-induced protein-coding and lncRNA genes."),
                               "The data for this database was derived from four studies profiled by", em("Distefano et al., 2023."),
                               strong("DoxoDB"), "is the work of the ", tags$a(href="https://heartlncrna.github.io/", "Uchida laboratory,"), "Center for RNA Medicine, Aalborg University, and the ", tags$a(href="https://www.bioresnet.org/", "Bioinformatic Reaserch Network.")),
                             br(),
                             p("Key features:"),
                             tags$ul(
                               tags$li("View transcriptomic data across four different studies and across different conditions"),
                               tags$li("Explore differential gene expression results"),
                               tags$li("Download processed datasets")
                             )
                    ), # end tabPanel("Home")
                    
                    tabPanel("Datasets",
                             h4("Datasets"),
                             p("The current version of", strong("DoxoDB"), "contains the following datasets:"),
                             tags$ul(
                               tags$li(tags$a(href="https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE135842", "GSE135842:"), "RNA-seq data of human foreskin fibroblasts with CRISPR-Cas9 mediated knockout of p130 alone or in combination with RB1. Cells were further transfected with siRNA against the p107 transcript or control sequence and treated with either 0 or 350 nM Doxorubicin"),
                               tags$li(tags$a(href="https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE198396", "GSE198396:"), "RNA-seq data of human foreskin fibroblasts HCA2 cells. These were divided into normal HCA2 cells, PD-L1-positive and PD-L1-negative senescent HCA2 cells induced by 24 hours of 100 nM Doxorubicin treatement"),
                               tags$li(tags$a(href="https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE154101", "GSE154101:"), "RNA-seq data of human pulmonary arterial adventitial fibroblasts treated with either vehicle control or Doxorubicin (0.5 µg/ml)"),
                               tags$li(tags$a(href="https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE163361", "GSE163361:"), "RNA-seq data of SUM149 and FCIBC02 Parental and Doxorubicin-resistant inflammatory breast cancer cell lines. Cells were also treated with either vehicle or Doxorubicin")
                             )
                    ),# end tabPanel("Datasets")
                    
                    tabPanel("DoxoDB Interfaces",
                             h4("DoxoDB Interfaces"),
                             tags$figure(
                               align="center",
                               tags$img(
                                 src="volcanoPage_v2.png",
                                 width="950",
                                 alt="Picture for the result page"
                               )
                             ),
                             p(strong("'Explore Results' page"), strong("(A)"), "Controls the study which is displayed.", 
                               strong("(B)"), "Controls the type of conditions to focus on within the selected study.", 
                               strong("(C)"), "Controls threshold for log2 Fold Change and FDR.",
                               strong("(D)"), "Result table which displays the results of the differential expression analysis for each gene in the selected comparison and study. This can also be downloaded in .tsv format.",
                               strong("(E)"), "Summary table which displays the number of differentially expressed genes (differentiating between protein-coding and lncRNA genes) in the selected comparison and study.",
                               strong("(F)"), "Volcano plot which displays the results of the DGE analysis. Selecting a row in the 'Results table' (D) will cause the corresponding gene to be highlighted in the volcano plot." , style="width: 950px;",
                               
                               
                               tags$figure(
                                 align="center",
                                 tags$img(
                                   src="heatmapPage.png",
                                   width="950",
                                   alt="Picture for the heatmap page"
                                 )
                               ),
                               
                               p(strong("DGE Heatmap."), strong("(A)"), "Controls the expression pattern of the displayed DEGs on (B).",
                                 strong("(B)"), "Heatmap of the differentially expressed genes in the selected comparison and study.", style="width: 950px;"),
                               
                               
                               tags$figure(
                                 align="center",
                                 tags$img(
                                   src="GOanalysisPage.png",
                                   width="950",
                                   alt="Picture for the GO page"
                                 )
                               ),
                               
                               p(strong("Gene Ontology analysis."), strong("(A)"), "Controls the expression pattern of the DEGs used for the analysis on (B)", 
                                 strong("(B)"), "Gene Ontology analysis results displayed as Manhattan plot, showing the significantly enriched GO terms associated with the list of up- or down-regulated genes in the selected comparison and study",
                                 strong("(C)"), "Table displaying the results of the Gene Ontology analysis shown on (B)" , style="width: 950px;"),
                               
                               tags$figure(
                                 align="center",
                                 tags$img(
                                   src="KEGGanalysisPage.png",
                                   width="950",
                                   alt="Picture for the Kegg analysis page"
                                 )
                               ),
                               
                               p(strong("Pathway Analysis"), strong("(A)"), "Controls the expression pattern of the displayed DEGs on (B).",
                                 strong("(B)"), "KEGG Pathway overepresentation analysis results displayed as dotplot, showing the significantly enriched KEGG pathways associated with the list of up- or down-regulated genes in the selected comparison and study." , style="width: 950px;"),
                               
                               
                               tags$figure(
                                 align="center",
                                 tags$img(
                                   src="comparisonsPage.png",
                                   width="950",
                                   alt="Picture for the comparison page"
                                 )
                               ),
                               
                               p(strong("Comparisons Intersection."), strong("(A)"), "Controls the expression pattern of the DEGs used on (B).", 
                                 strong("(B)"), "This interface displays the DEGs shared among the different comparisons of the selected study as a Venn Diagram" , style="width: 950px;")),
                             
                             tags$figure(
                               align="center",
                               tags$img(
                                 src="lncRNAPage.png",
                                 width="950",
                                 alt="Picture for the lncRNAs page"
                               )
                             ),
                             
                             p(strong("lncRNAs Page."), strong("(A)"), "Controls the study which is displayed.",
                               strong("(B)"), "Controls the comparison within the study which is displayed.",
                               strong("(C)"), "'lncRNA Table' which displays the differentially expressed lncRNAs identified in the selected comparison and study with an FDR < 0.05 and logFC > abs(1).",
                               strong("(D)"), "List of miRNAs and GWAS terms related to the lncRNA selected in the 'lncRNA Table' " , style="width: 950px;"),
                             
                             tags$figure(
                               align="center",
                               tags$img(
                                 src="downloadPage.png",
                                 width="970",
                                 alt="Picture for the comparison page"
                               )
                             ),
                             
                             p(strong("Download Page."), strong("(A)"), "Controls the study which will be displayed and subsequently downloaded.", 
                               strong("(B)"), "Controls the type of file used to download the desired data set (either comma-separated-values (CSV) file or tab-separated-values (TSV) file)",
                               strong("(C)"), "Preview of the data of the selected study which will be downloaded." , style="width: 950px;"),
                             
                    ),# end tabPanel ("DoxoDB Interfaces")
                    
                    tabPanel("Terminology",
                             
                             h4("Terminology"),
                             tags$ul(
                               tags$li(em("lncRNA:"), "long non-coding RNA"),
                               tags$li(em("DEG:"), "Differentially Expressed Gene"),
                               tags$ul(
                                 tags$li("Differentially expressed genes refer to genes that are expressed at significantly different levels between two or more conditions. In this study, we calculated DEGs using the", tags$a(href="https://bioconductor.org/packages/release/bioc/html/edgeR.html", "edgeR"), "R/Bioconductor package.")
                               ),
                               tags$li(em("DGE:"), "Differential Gene Expression"),
                               tags$ul(
                                 tags$li("Differential gene expression refers to a significant difference in the expression of a gene between two conditions of interest.")
                               ),
                               tags$li(em("FDR:"), "False Discovery Rate"),
                               tags$ul(
                                 tags$li("The false discovery rate is a metric used to correct for multiple testing, restricting the total number of false positives (type I errors).")
                               ),
                               tags$li(em("FC:"), "Fold Change"),
                               tags$ul(
                                 tags$li("The fold chage measures how much the expression of a gene has changed between one condition relative to the other. It is calculated by taking the ratio of the normalised gene count values (counts per million (CPM) in this case)")
                               ),
                               tags$li(em("CPM:"), "Counts per Million"),
                               tags$ul(
                                 tags$li("Counts per million is a gene count normalzation metric where the count of reads mapped to a gene is divided by the total number of reads mapped and multiplied by a million")
                               ),
                               tags$li(em("DOX"),"-", em("Doxo:"), "Doxorubicin"),
                               tags$li(em("DoxoR:"), "Doxorobucin-resistant"),
                               tags$li(em("KEGG:"), "Kyoto Encyclopedia of Genes and Genomes"),
                               tags$li(em("GO:BP:"), "Gene Ontology: Biological Processes"),
                               tags$li(em("GO:MF:"), "Gene Ontology: Molecular Functions"),
                               tags$li(em("GO:CC:"), "Gene Ontology: Cellular Components"),
                               tags$li(em("csv:"), "comma-separated-values file"),
                               tags$li(em("tsv:"), "tab-separated-values file"),
                             ),
                    ), # end tabPanel("Terminology")
                    
                    tabPanel("Bugs",
                             h4("Bugs"),
                             p(strong("DoxoDB"), "is a new database, and as such, bugs may occasionally occur. If you encounter any bugs or unexpected behaviours please open an issue on the", tags$a(href="https://github.com/Reb08/DoxoDB/issues", "RLBase GitHub repo"), "and describe, in as much as possible, the following:"),
                             tags$ul(
                               tags$li("What you expected", strong("DoxoDB"), "to do."),
                               tags$li("What", strong("DoxoDB"), "did and why it was unexpected."),
                               tags$li("Any error messages you received (along with screenshots).")
                             )
                    ),
                    
                    tabPanel("License and attribution",
                             h4("License and Attribution"),
                             p(strong("DoxoDB"), "is licensed under an MIT license and we ask that you please cite", strong("DoxoDB"), "in any published work like so:"),
                             h5(em("'Distefano"), "et. al.,", em("DoxoDB: one-stop-shop for expression analysis of doxorubicin-induced lncRNAs, 2023"))
                             
                    ) # end tabPanel
                    
                  ) # navlistPanel
           )# column
         ) # fluidRow
         
)