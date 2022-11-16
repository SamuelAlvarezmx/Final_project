# Final_project

- We chose a Random forest model because of its high accuracy and interpretability. It can easily handle non-linear data and outliers. The input will be in the form of tabular data (no images or natural language). A random forest model with a sufficient number of estimators and tree depth should be able to perform at a similar capacity to most deep learning models.
- We want a classifier that predicts (y) 
- We need to consider if the data classes have an imbalance to apply an oversampling or undersampling technique.

- The data will have over 22000 rows, 9 features, and 1 target column.
- It will require preprocessing with (one Hot Encoder) for the categorical variables. Depending on the length of unique values, we might need to bucket certain data.
- After having everything in numerical values, we will standardize the data.
- We will keep the default percentage of training and testing data (75% for training and 25% for testing)

Draft of a random forest model:

1. Generate dummy dataset
2. Creating a DataFrame with the dummy data
3. Plotting the dummy data
4. Use sklearn to split datasets for train and test
5. Create scaler instance
6. Fit the scaler
7. Scale the data
8. Create a random forest classifier.
9. Fitting the model
10. Evaluate the model