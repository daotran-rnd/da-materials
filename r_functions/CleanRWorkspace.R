#' @title Cleanup R workspace (environment)
#'
#' @description
#' Cleans up specific types of objects (data frames, functions, or simple values) 
#' or wipes the entire environment if no input is provided.
#'      - No input: removes ALL objects from the R Environment.
#'      - Input "data": removes only 'data.frame' or 'tibble' objects.
#'      - Input "function": removes only 'function' objects.
#'      - Input "value": removes vectors (numeric, character, etc.).
#' @author daotq    
#'   
#' @param to_clean A character string: "data", "function", "value", 
#' or NULL (default) to clean everything.
#' @export

CleanRWorkspace <- function(to_clean = NULL) {
  
  # Get all object names in the environment
  all_objs <- ls(envir = .GlobalEnv)
  
  if (length(all_objs) == 0) {
    message(">>> Environment is already empty.")
    return(invisible(NULL))
  }
  
  # No input provided - Clean everything
  if (is.null(to_clean)) {
    rm(list = all_objs, envir = .GlobalEnv)
    gc(verbose = FALSE)
    message(">>> Entire environment cleared and memory reclaimed.")
    return(invisible(NULL))
  }
  
  # Selective cleanup
  ## Identify types
  is_df <- sapply(all_objs, function(x) {
    obj <- get(x, envir = .GlobalEnv)
    is.data.frame(obj) || tibble::is_tibble(obj)
  })
  
  is_func <- sapply(all_objs, function(x) {
    is.function(get(x, envir = .GlobalEnv))
  })
  
  is_val <- !is_df & !is_func
  
  ## Select objects based on input
  to_rm <- switch(tolower(to_clean),
                  "data"     = all_objs[is_df],
                  "function" = all_objs[is_func],
                  "value"    = all_objs[is_val],
                  stop("Invalid input! Use 'data', 'function', 'value', or leave empty for total clean.")
  )
  
  if (length(to_rm) > 0) {
    rm(list = to_rm, envir = .GlobalEnv)
    gc(verbose = FALSE)
    message(">>> Removed ", length(to_rm), " ", to_clean, "(s) from environment.")
  } else {
    message(">>> No ", to_clean, " objects found to clean.")
  }
  
  return(invisible(NULL))
}
