#' @title Smart Clean Numeric and Standardize Dataframe
#'
#' @description 
#' Automatically detects data input type (file path or existing dataframe), 
#' standardizes all column names to UpperCamelCase, and intelligently cleans all columns.
#' It removes noisy characters, converts target strings to NA, and safely coerces 
#' valid columns to numeric types without destroying text columns. 
#' The cleaned dataset is also automatically exported to the Global Environment.
#' @author daotq, anh2bao, sangla
#'
#' @param data_input A dataframe/tibble or a valid file path string (.xlsx, .xls, .csv).
#' @param na_strings A character vector of noisy strings to be converted to NA. Defaults to c("ERROR", "UNKNOWN", "N/A", "", "NULL", "-").
#' @return A cleaned dataframe/tibble. As a side effect, assigns 'DataframeCleaned' to the Global Environment.
#' @export
SmartCleanData <- function(data_input, na_strings = c("ERROR", "UNKNOWN", "N/A", "", "NULL", "-")) {
  
  # 1. Input Validation & Reading
  if (is.data.frame(data_input)) {
    df <- data_input
  } else if (is.character(data_input) && length(data_input) == 1) {
    ext <- tolower(tools::file_ext(data_input))
    if (ext %in% c("xlsx", "xls")) {
      df <- read_excel(data_input)
    } else if (ext == "csv") {
      df <- read_csv(data_input, show_col_types = FALSE)
    } else {
      stop("Unsupported file format. Please use .xlsx, .xls, or .csv")
    }
  } else {
    stop("Error: data_input must be a Data Frame/Tibble or a valid file path.")
  }
  
  # 2. Standardize column names to UpperCamelCase
  df <- df |> clean_names(case = "upper_camel")
  
  # 3. Scan and clean all columns intelligently
  df <- df |> 
    mutate(across(everything(), ~ {
      x <- .
      
      if (is.numeric(x)) return(x)
      
      x_char <- trimws(as.character(x))
      na_dict <- toupper(trimws(na_strings))
      
      is_na_string <- toupper(x_char) %in% na_dict
      x_char[is_na_string] <- NA_character_
      
      x_no_comma <- gsub(",", "", x_char)
      x_num <- suppressWarnings(as.numeric(x_no_comma))
      
      if (any(!is.na(x_no_comma) & is.na(x_num))) {
        return(x_char) 
      } else {
        return(x_num)  
      }
    }))
  
  # 4. Automatically push to RStudio Environment
  assign("DatasetCleaned", df, envir = .GlobalEnv)
  
  return(df)
}