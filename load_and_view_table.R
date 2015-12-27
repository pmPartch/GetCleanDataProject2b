#load and view the tidy data set for project "Get and Clean Data"

fileUrl <- "Tidy UCI HAR Dataset.txt"

if (file.exists(fileUrl))
{
    df <- read.table(fileUrl,header=TRUE)
    View(df)
    
} else {
    print(paste("Could not locate file to load:", fileUrl))
}