# Final_project: 
Presidential Elections in the US (2000-2020): the ideology behind the citizen vote.

# Abstract: 
What makes a citizen vote for a democrat party?


# Selection of topic: 
People with similar ideas usually belong to the same political party, the two main parties in the US are Republican, and Deomocrat, so which ideas make people to stay in one party? What cultural, economic, social and political indicators lead to vote for a certain political party? In this project we will dive into these features.

# Hypothesis: 
The electorate votes according to their convictions (in theory), but certain indicators show that this is not always the case. And we are going to demonstrate which ones do and which ones do not have an influence on the vote. We strongly think that people with more debt and less income and also in the places where migration percentage is high are inclined to vote for the Democratic party.

* What makes a citizen vote for a democrat party?
* Counties with more white population will vote for republicans?
* Counties with more debt will vote for Democrats?
* Counties with more migration population will vote for Democrats?
* Counties with more income will vote for Republicans?

# Description of the  data
The political system of the US is based on a series of relatively simple electoral rules, based on the logic of the majority (winners takes it all), with highly decentralized electoral management and very little post-election litigation; which has led the US to have one of the most stable electoral systems in the world. Therefore, several institutions and government agencies keep records of the presidential elections since they started. Like exit polls, panel studies, but also they keep track of social issues such as racial indicators, partisanship, perception of security, economy, to name a few.

In this project, we will use as variables for our analysis, all of them at county level: 
- number of votes per party
- population
- migration
- average income
- debt


 ### 1. Harvard Dataverse
 Harvard's open online repository for sharing, preserving, citing, exploring and analyzing research data.

Harvard Dataverse is an online data repository for share, preserve, cite, explore, and analyze research data. It is open to all researchers, both inside and out of the Harvard community.The Harvard Dataverse repository runs on the open-source web application Dataverse, developed at the Institute for Quantitative Social Science. Dataverse helps make data available to others, and allows to replicate others' work more easily.

#### For this project we are going to use:
- *County Presidential Election Returns 2000-2020*
- Data citation:
MIT Election Data and Science Lab, 2018, "County Presidential Election Returns 2000-2020", https://doi.org/10.7910/DVN/VOQCHQ, Harvard Dataverse, V11, UNF:6:HaZ8GWG8D2abLleXN3uEig== [fileUNF]

- Web site: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/VOQCHQ

![image](https://user-images.githubusercontent.com/43974872/201570335-137d6081-f642-47cb-baeb-f71d5f9e6816.png)

### 2. Urban Data Catalog, Urban Institute

The Urban Institute Data Catalog is a place to discover and download open data provided by Urban Institute researchers and data scientists. From here, we are using *Debt in America 2022*  the dataset contains information derived from a random sample of deidentified, consumer-level records from a major credit bureau. The credit bureau data are from February 2022 and contain more than five million records.

#### For this project we are going to use:
- *Debt in America: County-Level Auto Debt*: 
- Data citation: 
Alexander Carther, Kassandra Martinchek, Breno Braga, Signe-Mary McKernan, and Caleb
Quakenbush. 2022. Debt in America February 2022. Accessible
from https://datacatalog.urban.org/dataset/debt-america-2022 .

- Web site: https://datacatalog.urban.org/dataset/debt-america-2022

![image](https://user-images.githubusercontent.com/43974872/201573665-8612674b-3873-46ca-b8dc-98282cc2ef50.png)


### 3. The Census Bureau, official website of the Unted Srates government

The Census Bureau´s mission is measuring America´s people, places and economy. 

We know the importance of having reliable databases, that is why we adopt the idea that our sources of information come from official and secure sources. Therefore, we extracted the infrmotion we requiered form the Census Bureau datasets.

#### For this project we are going to use:
- *County Population Totals: 2010-2021*
- Web site: https://www.census.gov/data/datasets/time-series/demo/popest/2020s-counties-total.html

![image](https://user-images.githubusercontent.com/43974872/201572032-82c557cd-134c-4eea-b0ba-f9fb22c75c67.png)

# Final Database structure
Sample data that mimics the expected final database structure or schema.

![Schema](https://user-images.githubusercontent.com/104656920/203893214-7b7a2fc8-2921-44bd-8dd6-c4339eac9cd4.png)



Machine learning module is connected to our database stored in AWS RDS.

# Machine Learning Model
### Random Forest Model

We chose a Random forest model because of its high accuracy and interpretability. It can easily handle non-linear data and outliers. The input will be in the form of tabular data (no images or natural language). In addition, a random forest model with a sufficient number of estimators and tree depth should be able to perform at a similar capacity to most deep learning models but with fewer resources.

Since we have everything in numerical values, we will only need to standardize the data. 

The data have 1619 rows, 14 features, and 1 target column. The target will be numerical, 1 for the counties where the Democrat party won and 0 for counties where other parties won. The model will be able to predict if the county will win Democrat according to the features (population, income, debt, etc.) that were considered.

**1. Read the final CSV file with the merged data**

The code reads the file locally but we will adjust it to read it directly from AWS.

**2. Creating a DataFrame and preprocessing the data**

<u>Preprocessing</u>

We had a value that needed to be changed for the three debt columns. We used the replace pandas method for that. 

![preprocessing](https://github.com/SamuelAlvarezmx/Final_project/blob/main/MLModel/Resources/preprocessing.png)

Nothing else needs to be changed since we already cleaned the data before merging it with Postgres. In addition, we used an inner join to ensure that we wouldn't have missing values in other columns. 

<u>Feature selection</u>

We started with 14 columns. We dropped the "county_name" since it is not in a number format and it is a key value. After trying out the model, we noticed that there were features that were part of the target, so we decided to drop them too.

We ended with eight main features: "popestimate2019", "internationalmig2019", "debt_all","debt_communities_color", "debt_majorities_white", "avg_household_income_all", "avg_non_white_income" and "avrg_non_hispanic"

<u>Define the target</u>

The target column is called "winner" and as mentioned before, the number 1 represents when the democrat won and 0 when any other party won for each county. 

**3. Use sklearn to split datasets for train and test**

Because our data frame is larger than wider, we kept the default percentage of training and testing data (75% for training and 25% for testing).

**4. Create scaler instance**

Even though all our features have numerical values, it is important to create the scaler instance because the proportion among them is different. There are some decimals that represent the percentages and there are some values in thousands. 

**5. Fit the scaler**
Before we fit the random forest model to our X_train_scaled and y_train training data, we'll create a random forest instance using the random forest classifier.

The n_estimators will allow us to set the number of trees that will be created by the algorithm. Generally, the higher number makes the predictions stronger and more stable, but can slow down the output because of the higher training time allocated. The best practice is to use between 64 and 128 random forests, though higher numbers are quite common despite the higher training time.

**6. Scale the data**
To scale the data in this DataFrame, we'll first import the StandardScaler module and create an instance of it. Then The next step is to train the scaler and transform the data.

**7. Create a random forest classifier, fit the model and evaluate it**

For the random forest classifier, we decided to try three different numbers of estimators: 80, 128, and 200. After running the three of them, we noticed that 128 got the best value. Neither increasing nor decreasing that number improved the accuracy. 

![random_forest_accuracy](https://github.com/SamuelAlvarezmx/Final_project/blob/main/MLModel/Resources/random_forest_accuracy.png)



### Logistic Regression Model (Alternative)

We decided to use the logistic regression model because, with a combination of input variables, it can predict the probability of the input data belonging to one of two groups. We used the parameter "lbfgs" which is an algorithm for learning and optimization.  

We didn´t consider a neural network because the dataset has less than 2000 values and we have few numerical features. 

![logistic_accuracy](https://github.com/SamuelAlvarezmx/Final_project/blob/main/MLModel/Resources/logistic_accuracy.png)

    
 # Executive Presentation
 
 ### GoogleSlides:
  **https://docs.google.com/presentation/d/13e7vDX2GU76RK9Her7Cd2wXU1dyC0MMxA1HDaJyE5vA/edit?usp=sharing**
  
 # Dashboard
 
 ### Tableu Public:
 
 https://public.tableau.com/app/profile/samuel6259/viz/finalproject_16697764879210/Story1?publish=yes
 
 
 
