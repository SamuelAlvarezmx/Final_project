SELECT * FROM debt_clean_vf;
SELECT * FROM elections2020_clean;
select * from pop_clean;

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
FROM elections2020_clean
LEFT JOIN pop_clean
ON elections2020_clean.county_name = pop_clean.county_name;

--check new table
SELECT * FROM election_pop;


--inner join
SELECT election_pop.county_name,
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
	   debt_clean_vf."Avg_Non_White_Income",
	   debt_clean_vf."Avg_Non_Hispanic"
INTO main_database	   
FROM election_pop
INNER JOIN debt_clean_vf
ON election_pop.county_name = debt_clean_vf.county_name;

SELECT * FROM main_database;