Get Clean Data Project 2
===================

Project for the Get and Clean Data Course

*Note: this is my second time taking this class. I passed this class a year ago December 2014 and needed to retake it (with verification) in order to qualify for the capstone. I've made some modifications to my original work from a year ago. You can compare, if you wish, the original work from this link: (https://github.com/pmPartch/GetCleanDataProject2). The reason for the rework is that I was too aggressive with removing columns that I thought were redundant (the mean and std columns)...this time around, I've kept them with the thought that we use PCA/SVD to reduce dimensionality when and if we process this data.*

The following files are available:

- **Codebook.md** a description of the data and transforms from raw input data to the tidy output table  
NOTE: the original codebook.txt has been added as an appendix
- **run_analysis.R** the script that will download, unzip, and create the tidy table.  
To generate the Tidy data set, Run this script and it will
    1. verify that the raw data files are in the current working directory (if not, the script will attempt to download the zip and uncompress it to the current working directory)
    1. merge the data together in to a single data frame
    1. filter out the unwanted columns
    1. replace the activity id's with their labels
    1. melt and then cast the data frame to merge the duplicate activity samples into a single row using mean()
    1. rename the variables by expanding their labels
    1. write the new tidy data frame to the current working directory with the name 'Tidy UCI HAR Dataset.txt'

- **load_and_view_table.R** a small utility script that can load the tidy table  
This script will expect the 'Tidy UCI HAR Dataset.txt' to be in the current working directory and will load it and call View()


