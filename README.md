# "Getting and Cleaning Data" Course Project
This repo is my submission for the "Getting and Cleaning Data" Course Project.

The course project asks to clean up a data-set from a motion related experiment, and to perform a basic mean analysis on the clean up data-set grouped by subject and activity.

## run_analysis.R
R script that downloads the original data-set, cleans it up, and performs the basic analysis required by the course. It depends on the "data table" package. It can be executed by sourcing.

## CodeBook.md
Code book describing the transformation done on the original data-set and the final analysis output.

## README.md
This file.

## tidy_data_mean.txt
Data table generated by the run_analysis script. 

Data can be read by sample code below.
    tidy_data_mean <- read.table("tidy_data_mean.txt", header=TRUE)
    View(tidy_data_mean)