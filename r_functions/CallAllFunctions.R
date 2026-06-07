#' @title Load All R Functions from GitHub
#' @description Scans a GitHub directory and sources all .R files found.
#' @author daotq
#' 
#' @param repo Character. Format: "username/repo"
#' @param path Character. Path to the folder containing functions.
#' @param branch Character. Default is "main".
#'
#' @export

CallAllFunctions <- function(repo = "daotran-rnd/da-materials", 
                                path = "r_functions", 
                                branch = "main") {
  
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(httr, jsonlite, purrr, dplyr)
  
  # 1. Call GitHub API to fetch file list
  api_url <- paste0("https://api.github.com/repos/", repo, "/contents/", path, "?ref=", branch)
  
  response <- GET(api_url)
  
  if (status_code(response) != 200) {
    stop("Failed to access GitHub API. Please check your repository path, branch, or internet connection.")
  }
  
  # 2. Decode JSON content
  files_data <- fromJSON(content(response, "text", encoding = "UTF-8"))
  
  # 3. Filter for .R files
  r_files <- files_data %>% 
    filter(grepl("\\.[Rr]$|\\.R$", name)) %>% 
    pull(download_url)
  
  if (length(r_files) == 0) {
    message("No .R files found in the specified directory.")
    return(invisible(NULL))
  }
  
  # 4. Source all identified files
  message(paste("Sourcing", length(r_files), "functions from GitHub..."))
  
  walk(r_files, ~ {
    tryCatch({
      source(.x)
      # message(paste("Successfully sourced:", basename(.x)))
    }, error = function(e) {
      warning(paste("Error sourcing file:", basename(.x), "-", e$message))
    })
  })
  
  message("Update complete! All functions are now available in your environment.")
}
