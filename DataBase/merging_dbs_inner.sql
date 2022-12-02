-- Creating tables for Final_Project was not neccesary beacuase we export the dataframes of pandas to sql in the jupyter notebook
-- CREATE TABLE Debt (state_name VARCHAR, 
					 county_name VARCHAR,
					Debt_All FLOAT,
					Debt_Communities_Color FLOAT,
					Debt_Majorities_White FLOAT,
					Avg_Household_Income_All FLOAT,
					Avg_Non_White_Income Float,
					Avg_Non_Hispanic FLOAT, 
					PRIMARY KEY (county_name) 
				   );
				   
-- CREATE TABLE election2020 (county_name VARCHAR,
						   DEMOCRAT FLOAT,
						   REPUBLICAN FLOAT,
						   LIBERTARIAN FLOAT,
						   GREEN FLOAT,
						   OTHER FLOAT,
						   WINNER INT,
						   PRIMARY KEY (county_name)
						   );
					
-- CREATE TABLE population (STNAME VARCHAR,
						county_name VARCHAR,
						POPESTIMATE2019 INT,
						INTERNATIONALMIG2019 INT,
						PRIMARY KEY (county_name)
						);		
						
-- Confirm tables
SELECT * FROM debt_clean_vf;
SELECT * FROM elections2020_clean;
SELECT * FROM pop_clean;

--Number of Counties (before 1763 with the new database improved to 1873)
SELECT COUNT (county_name)
From debt_clean_vf;

--Number of Counties (1865)
SELECT COUNT (county_name)
From elections2020_clean;

--Number of Counties (before 1768, now, 1910)
SELECT COUNT (county_name)
From pop_clean;

--Merging election + population = election_pop
SELECT 
       elections2020_clean.county_name,
       elections2020_clean."DEMOCRAT",
	   elections2020_clean."REPUBLICAN",
	   elections2020_clean."LIBERTARIAN",
	   elections2020_clean."GREEN",
	   elections2020_clean."OTHER",
	   elections2020_clean."WINNER",
	   pop_clean."POPESTIMATE2019",
	   pop_clean."INTERNATIONALMIG2019"
INTO election_pop   
FRIM elections2020_clean
INNER JOIN pop_clean
ON elections2020_clean.county_name = pop_clean.county_name;

--check new table
SELECT * FROM election_pop;

-- Check Number of Counties (before 1768, now 1780)
SELECT COUNT (county_name)
From election_pop;

--Merging election_pop + debt = data_complete
SELECT 
       election_pop.county_name,
	   election_pop."POPESTIMATE2019",
	   election_pop."INTERNATIONALMIG2019",
       election_pop."DEMOCRAT",
	   election_pop."REPUBLICAN",
	   election_pop."LIBERTARIAN",
	   election_pop."GREEN",
	   election_pop."OTHER",
	   election_pop."WINNER",
	   debt_clean_vf."Debt_All",
	   debt_clean_vf."Debt_Communities_Color",
	   debt_clean_vf."Debt_Majorities_White",
	   debt_clean_vf."Avg_Household_Income_All",
	   debt_clean_vf."Avg_Non_Hispanic",
	   debt_clean_vf."Avg_Non_White_Income"
INTO main_database	   
FROM election_pop
INNER JOIN debt_clean_vf
ON election_pop.county_name = debt_clean_vf.county_name;

--check new table
SELECT * FROM main_database;

-- Check Number of Counties (before 1768, now 1779)
SELECT COUNT (county_name)
From main_database;
