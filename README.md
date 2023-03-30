# DoxoDB

Shiny app for exploring RNA-seq data of Doxorubicin-treated cells analysed by Distefano et al. 2023.

To generate the data for this app, please see the steps in https://github.com/Reb08/Analysis_of_Doxo_Studies.

## Run the app locally

 1. Start R
 
 2. Load the "Shiny" library package (install if not already available)
 ```
 library(shiny)
 
 install.packages("shiny") # ----- if not already installed
 ```
 
 3. Run App
 
 ```
 runGitHub(repo = "DoxoDB", username = "Reb08", ref = "main")
 ```
 
 ## Visit the app online
 
 You can find the app online at:  https://rebeccadistefano.shinyapps.io/DoxoDB/
