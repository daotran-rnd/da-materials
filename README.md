# 📦 RCraftToolbox: R functions for data wrangling

## About this project 🤔
This project is a code library for data wrangling in general. 
<br>
<br>


## Instruction 🔖
You can use function files from this github repo directly in your R environment without manually downloading the files, ensuring you are always working with the most up‑to‑date version of the code. 
This instruction is designed to call functions in folder r_functions separately.

### Step 1️⃣: Run this code in your R script
```R
CallRCraftToolbox <- function(file) {
  source(paste0(
    "https://raw.githubusercontent.com/daotran-rnd/da-materials/main/r_functions/",
    file)) }
```
### Step 2️⃣: Add name of a specific function to call it

For example, you want to use function `CreateDateHierarchy()` from this library to add `YYYY-MM` column, here is how to call this function:

```R
CallRCraftToolbox("CreateDateHierarchy.R")
```
Now the function `CreateDateHierarchy()` is available in your R environment. 

### Step 3️⃣: Use the function for its designated purpose 
Example: We have a dataset `bike_sales` and there is a column called `OrderDate`. 
Here is how to use function `CreateDateHierarchy()`. 
```R
CreateDateHierarchy(data = bike_sales,
                    date_column = OrderDate)
```
Kindly read description in each R function to know parameters to input. 
<br>
<br>

## Recommended order for going through R functions 🏃🏻‍♂️‍➡️
**Batch 1: R working space**
  *	SetupRProjectHere
  *	SetupFolders
  *	SetupRLibraries
  *	CleanRWorkspace
  *	CleanNonFunctions
  *	MemoryProfiler

**Batch 2: Load and save data**
  *	LoadDatasets 
  *	LoadExcelSheets 
  *	ConverExcel2RData
  *	SaveAll2RData
  *	SaveData

**Batch 3: Data wrangling / working with tables**
  *	ViewDataAsTable
  *	QuickDataSummary
  *	CheckMissingData
  *	TransposeData
  *	JoinData
  *	CreateDateHierarchy
  *	RemoveAccents

### Enjoy and stay strong!⚡
