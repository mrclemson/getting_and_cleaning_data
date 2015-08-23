### Steps taken
* Read in the test and train datasets and combine them using cbind and rbind.
* Add column names using the existing file `features.txt`. R function `grepl` was used to grep the right columns. Note some angle variables have `Mean` in the name, so `ignore.case` was set to `FALSE`.
* 
