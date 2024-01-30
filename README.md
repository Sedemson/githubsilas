# Plato's Pizza Project

## Project  Overview
This data analysis project aims to provide insights into the sales performamce of a pizza restaurant called (PLATO'S PIZZA) by analysing the data they collected over a three years period. Acting as the BI consultant i analyzed various aspect of the sales data and seek to idenify trends, make data driven recommendations and gain a deeper understanding of the performance of Plato's Pizza.

### Source of Data
Data: The primary data used for this nalysis is the "Data Model - Pizza Sales.xlsx" file from Kaggle which contain detailed information about sales made by Plato's Pizza

### Tools Used for the project

- Excel ( I used Excel for data cleaning)
- Mysql  ( Data Analysis)
- PowerBI (Creating Reports for the project)

### Data Cleaning and Prepartion Process
1. Data Loading and Inspection
2. Handling missing values
3. Data cleaning and formating
4. Dividing my data into  seperate cvs files namely;
   - Item
   - Pizza order
   - Ingredient
before exporting them individual into MySQL workbench to create my tables

### Data Exploration and Analysis (EDA)
With regards to the EDA the Plato's Pizza wants to get answers to this questions 
 1. What days and times do we tend to be busiest?
 2. How many pizzas are we making during peak periods?
 3. What are our best and worst-selling pizzas?
 4. What's our average order value?
- ### Data Analysis
During the analysis i used the various sql clauses, joins, subqueries etc

1. Code for First Question
```sql
SELECT (order_date) AS Busiest_days,
  CONCAT(order_time)AS Time,
  sum(Quantity) AS Quantity_ordered
FROM
  Pizza_order
GROUP BY
  Busiest_days, Time
ORDER BY
  Quantity_ordered DESC;

### Results
These are the results from my analysis
A. The busiest days and times are
    -  Friday, 2015-07-03  at '12:28:14 PM' 
    -  Tuesday, 2015-12-08 at'1:44:28 PM'
    -  Tuesday,2017-06-21  at '2:02:18 PM'
B. The total quantity of pizzas made during this times were 3 pizzas each

2. Code for second Question
```sql
  SELECT 
      SUM(Quantity) AS Total_Pizzas, 
	  CONCAT(HOUR(order_time), ':00 -', HOUR(order_time) +2, ':00PM') AS Peak_Period 
    FROM 
        pizza_order
	GROUP BY 
		Peak_Period 
	ORDER BY
        Total_Pizzas DESC
	LIMIT 1;

### Results
These are the results from my analysis
A. The peak period were from the hours 1:00 to 3:00
B. The total number of pizzas they were making during this period is 138 pizzas

3. Code for second Question
```sql
SELECT  
     SUM(total_price) AS Total_Revenue,
      Item_id,
      pizza_name,
      pizza_category
FROM  item 
GROUP BY
      pizza_name
ORDER BY 
      Total_Revenue DESC
LIMIT 5;

      SELECT  
     SUM(total_price) AS Total_Revenue,
      Item_id,
      pizza_name,
      pizza_category
FROM  item 
GROUP BY
      pizza_name
ORDER BY 
      Total_Revenue ASC
LIMIT 5;

### Results
These are the results from my analysis
- The five best selling pizzas are
A. The Thai Chicken Pizza with totl revenue of $1017.25
B. The Barbecue Chicken Pizza with totl revenue of $914.25
C. The Italian Supreme Pizzawith totl revenue of  $885.5
D. The Classic Deluxe Pizza with totl revenue of $846.5
E. The California Chicken Pizza with totl revenue of$ 805.75

- The five worse selling pizzas are
A. The Green Garden Pizza with totl revenue of 288.2
B. The Mediterranean Pizza with totl revenue of 270
C. The Soppressata Pizza with totl revenue of    236.2
D. The Brie Carre Pizza with totl revenue of 189.2
E. The Calabrese Pizza with totl revenue of 166.5

4. Code for First Question
```sql

SELECT AVG(Order_Value) AS Average_Order_Value
FROM ( SELECT 
		   SUM(total_price) AS Order_Value
      FROM pizza_order po
      JOIN item i
      ON po.Item_id = i.Item_id
GROUP BY order_id) AS Order_Values;

### Results
These are the results from my analysis
A. The average order value is $38.5


## Reports ( Dashboards)
For my report i used Power BI and with the help of DAX to create a calutated table called the (Date Table)
and calculated column to populate my table with various columns table and Calculate measure  to calculate my KPI.
I also made use of power query at this stage 
A. Calculated table
  - Date
`` DAX
Date= Calender "1/1/2015", "9/15/2017"
B. Calculate column

C. KPI

A. Total Orders
``DAX
Total_Orders =Total_Orders = DISTINCTCOUNT(Pizza_order[order_id])
B. Total pizza sold
``DAX
Total_Pizza_Sold = SUM(Pizza_order[Quantity])
c. Total Revenue
``DAX
Total Revenue = SUM('Item' [total_price])
D. Average order_Value
`` Dax
Average_Order_Value = [Total Revenue]/[Total_Orders]

## Reccommenations
Based on the analysis, i reccommend the following:
- Plato's must invest in marketing and promotion during peak periods and also increase the number of seats during this peake periods
- Plato's should Focus on slowing introduce worse selling pizza to customers. This can be done by using these pizzas as promotional sales strtegies.

 















