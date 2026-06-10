#' @title Set Working Directory to Script Location
#'
#' @description This helper function sets the current working directory to the folder
#' containing the active R script in RStudio. If the function is run in
#' an interactive session and the script path cannot be determined, it
#' falls back to the current working directory.

SetWD2Script <- function() {

  if (interactive()) {
    wd <- tryCatch(
      dirname(rstudioapi::getSourceEditorContext()$path),
      error = function(e) getwd()
    )

    setwd(wd)

    message("📂 Working directory set to: ", wd)
  }
}
