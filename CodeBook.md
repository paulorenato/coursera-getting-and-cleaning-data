# CodeBook
## tidy dataset

This is the Code Book for the dataset contained in the *tidy.txt* file. This dataset summarizes the *Human Activity Recognition Using Smartphones Dataset* which was originally made avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The original data represents information collected from the accelerometers of a smartphone. A full description is available at the site linked above.

The *tidy.txt* dataset contains one row for each distinct "Subject", the "Activity" the subject was performing, along with the associated average mean and average standard deviation for each of the variables. For more information on the data transformations performed on the original data, please see the README.md file.

### Dataset Structure  
The *tidy.txt* file is space separated (default write.table() settings). The first row contains the variable names. To read the data into R, the user should call: read.table("tidy.txt", header = TRUE). The file is an aggregation of the average mean and average standard deviation, grouped by the subject and activity.  

Here is a sample of the dataset.  Note that, for clarity, only the first 6 rows and 6 columns are shown:

```
  Subject           Activity tBodyAcc.std...X tBodyAcc.std...Y tBodyAcc.std...Z tGravityAcc.std...X
1       1             LAYING      -0.92805647     -0.836827406      -0.82606140          -0.8968300
2       1            SITTING      -0.97722901     -0.922618642      -0.93958629          -0.9684571
3       1           STANDING      -0.99575990     -0.973190056      -0.97977588          -0.9937630
4       1            WALKING      -0.28374026      0.114461337      -0.26002790          -0.9766096
5       1 WALKING_DOWNSTAIRS       0.03003534     -0.031935943      -0.23043421          -0.9505598
6       1   WALKING_UPSTAIRS      -0.35470803     -0.002320265      -0.01947924          -0.9563670
```

The dataset **tidy.txt** contains 180 rows and 68 columns. The first two columns correspond to the Subject and Actvity, whereas the remaining 66 contain average of the *mean* and *std* (standard deviation) for variables in the original data set (i.e 33 for means and 33 for stds). There are 30 subjects an 6 activities in the dataset resulting in a total of 30x6 = 180 rows.

### Variable Definitions
**Subject**  
A number between 1 and 30 identifying one of the thirty participants in the study. 

**Activity**  
A string specifying one of the six activities being performed by the subject when the measurement was taken. Possible values:
* WALKING  
* WALKING_UPSTAIRS  
* WALKING_DOWNSTAIRS  
* SITTING  
* STANDING  
* LAYING  

**Averaged Variables**  
The 66 variables that were measured with the accelerometer averaged for the group defined in each row. A prefix of **t** means a time domain measurement whereas a prefix of **f** corresponds to a frequency domain measurement. For details on the definition of each variable, please refer to the study website at:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.  

## End
