#' @title View Function Documentation from GitHub
#'
#' @description This helper function retrieves and displays the Roxygen2 comments
#' (documentation) of a function stored in a GitHub repository.
#' @author daotq
#'
#' @param function_name Character string. The name of the function file
#'   (without the `.R` extension) to fetch from GitHub.
#' @param path Character string. The base URL path to the folder
#'   containing the `.R` files in your GitHub repository.
#' @example To view document of function JoinData in RCraftToolbox, type as follows
#' FunctionHelp("JoinData",
#'              "https://raw.githubusercontent.com/daotran-rnd/da-materials/main/r_functions/")

FunctionHelp <- function(function_name, path) {

  url <- paste0(path, function_name, ".R")

  lines <- readLines(url)

  roxy <- grep("^#'", lines, value = TRUE)

  cat(roxy, sep = "\n")
}
