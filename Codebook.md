# Codebook for Project

Data Science class *Getting and Cleaning Data*

**The Original Codebook *README.txt* has been put as an appendix at the end of this document under the heading 'Original Codebook'**

## data transformations

Units of [standard gravity](http://en.wikipedia.org/wiki/Standard_gravity) and angular velocity (radians/sec). The measurements were made for body acceleration, rate of change of acceleration (Jerk), and angular acceleration

Of the sampled data (see list below), all was retained. The idea was to keep all data and to make use of dimensionality reduction techniques during processing and analysis (such as PCA/SVD).

1. mean: Mean value
1. std: Standard deviation
1. mad: Median absolute deviation 
1. max: Largest value in array
1. min: Smallest value in array
1. sma: Signal magnitude area
1. energy: Energy measure. Sum of the squares divided by the number of values. 
1. iqr: Interquartile range 
1. entropy: Signal entropy
1. arCoeff: Autoregresion coefficients with Burg order equal to 4
1. correlation: correlation coefficient between two signals
1. maxInds: index of the frequency component with largest magnitude
1. meanFreq: Weighted average of the frequency components to obtain a mean frequency
1. skewness: skewness of the frequency domain signal 
1. kurtosis: kurtosis of the frequency domain signal 
1. bandsEnergy: Energy of a frequency interval within the 64 bins of the FFT of each window.
1. angle: Angle between to vectors.

## Processing of raw data to derive the tidy data set

The following processing was performed:

1. uncompress the raw data from [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
1. load the activity labels (with associated activity id's)
1. load the feature labels (with associated feature column numbers)
1. load the test data
    1. subject data containing the subject ID per record
    1. the raw recorded data for each feature
    1. the activity performed for each record and replace the activity id with its corresponding label
1. load the training data
    1. subject data containing the subject ID per record
    1. the raw recorded data for each feature
    1. the activity performed for each record and replace the activity id with its corresponding label
1. Verify there is no missing data
1. merge the test data, training data, then finally merge both sets together
1. assign labels to each column where the subject id is named SubjectID, the activity column is named Activity and the feature columns are labeled via the features table (to be explained in a step below)
1. collapse the rows by forming a mean of the measured feature data for a given subject ID and specific activity
1. expand the feature names to a more human readable form (see section 'Column name changes')


## multiple sample taken for a given subject and activity

Each subject (of 30) were all measured multiple times for each activity (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING)

## Column name changes

The feature names were expanded and [CamelCase or Pascal case](http://en.wikipedia.org/wiki/CamelCase). I also decided to separate the words with '.' since I found it more readable (but unfortunately makes the names long). The following name transformations were made:

- 't' was changed to 'Time'
- 'f' was changed to 'Frequency'
- 'Acc' was changed to 'Acceleration'
- 'mean()' was changed to 'Mean'
- 'std()' was changed to 'StdDev'
- the names were separated by '.'

and example would be 'fBodyAccJerk-mean()-Z' changes to 'Frequency.Body.Acceleration.Jerk.Mean.Z'

finally, it was decided to run the column names through the make.names() function to handle a few issues with white-space in the names.

### Processing Environment

The data was processed using the following environment (dump using sessionInfo())

R version 3.2.3 (2015-12-10)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 7 x64 (build 7601) Service Pack 1

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252    LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                           LC_TIME=English_United States.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] caret_6.0-62    ggplot2_2.0.0   lattice_0.20-33 reshape2_1.4.1 

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.2        magrittr_1.5       splines_3.2.3      MASS_7.3-45        munsell_0.4.2      colorspace_1.2-6   foreach_1.4.3     
 [8] minqa_1.2.4        stringr_1.0.0      car_2.1-1          plyr_1.8.3         tools_3.2.3        parallel_3.2.3     nnet_7.3-11       
[15] pbkrtest_0.4-4     grid_3.2.3         gtable_0.1.2       nlme_3.1-122       mgcv_1.8-10        quantreg_5.19      MatrixModels_0.4-1
[22] htmltools_0.2.6    iterators_1.0.8    lme4_1.1-10        digest_0.6.8       Matrix_1.2-3       nloptr_1.0.4       codetools_0.2-14  
[29] rsconnect_0.4.1.9  rmarkdown_0.9      stringi_1.0-1      scales_0.3.0       stats4_3.2.3       SparseM_1.7      

## Original Codebook Appendix

==================================================================

Human Activity Recognition Using Smartphones Dataset
Version 1.0

==================================================================

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
