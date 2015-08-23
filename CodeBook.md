### Steps taken
* Read in the test and train datasets and combine them using cbind and rbind.
* Add column names using the existing file `features.txt`. R function `grepl` was used to grep the right columns. Note some angle variables have `Mean` in the name, so `ignore.case` was set to `FALSE`.
* Convert activities to their corresponding descriptions. There are a few ways, I used `merge` as it felt natural to me, other than having to drop off the original Activity column, but that's really easy.
* Label the variable names and make them more descriptive, pretty manual, basically a bunch of substitutes.
* Lastly, create the tidy dataset by aggregating on `Subject` and `Activity`.

### Variable names and attributes
* The first two are very self explaining: they are the group_by columns.
* I was a little lazy, so I just kept the relabel'ed variable names. Probably makes more sense to add something like Avg at the front to indicate they are really the average of the means. Function `paste` may be handy here.
* All variables are numeric with the exception of the first two which are factors. Subject is int from the data type perspective, but it's really categorical.
