/** For the Maven Pizza Challenge, you’ll be playing the role of a BI Consultant hired by Plato's Pizza,
 a Greek-inspired pizza place in New Jersey. You've been hired to help the restaurant use data
 to improve operations, and just received the following note:
Welcome aboard, we're glad you're here to help!
Things are going OK here at Plato's, but there's room for improvement. We've been collecting transactional
 data for the past year, but really haven't been able to put it to good use. Hoping you can analyze the
 data and put together a report to help us find opportunities to drive more sales and work more efficiently.
Here are some questions that we'd like to be able to answer:
 1 What days and times do we tend to be busiest?
 2 How many pizzas are we making during peak periods?
 3 What are our best and worst-selling pizzas?
 4 What's our average order value?
That's all I can think of for now, but if you have any other ideas I'd love to hear them – you're the expert!
Thanks in advance,
Mario Maven (Manager, Plato's Pizza) **/




CREATE DATABASE mavenpizza_project;
USE mavenpizza_project;

DESCRIBE pizza_order;
SELECT * FROM pizza_order;

/*  After i cleaned and reuced the data in excel, i imported it to mySQL
    created all my tables using  the wizard Set constraints for the various colum */


-- pizza_order Table--
ALTER TABLE pizza_order ADD PRIMARY KEY ( order_details_id);
ALTER TABLE pizza_order MODIFY COLUMN order_id  INT NOT NULL;
ALTER TABLE pizza_order MODIFY COLUMN order_date DATE NOT NULL;
ALTER TABLE pizza_order MODIFY COLUMN order_time VARCHAR(15) NOT NULL;
ALTER TABLE pizza_order MODIFY COLUMN Item_id  INT NOT NULL;
ALTER TABLE pizza_order MODIFY COLUMN Quantity  INT NOT NULL;
-- Establishing relationships --
ALTER TABLE pizza_order ADD FOREIGN KEY (Item_id)  REFERENCES  item( Item_id) ON DELETE CASCADE;

-- Item Table--
DESCRIBE item;
SELECT * from item;

ALTER TABLE item ADD PRIMARY KEY (Item_id);
ALTER TABLE item MODIFY COLUMN Pizza_size VARCHAR(5) NOT NULL;
ALTER TABLE item MODIFY COLUMN unit_price DOUBLE NOT NULL;
ALTER TABLE item MODIFY COLUMN total_price DOUBLE NOT NULL;
ALTER TABLE item MODIFY COLUMN pizza_category VARCHAR(15) NOT NULL;
ALTER TABLE item MODIFY COLUMN pizza_name VARCHAR(50) NOT NULL;


-- Ingredient Table --
DESCRIBE ingredient;
SELECT* FROM ingredient;

ALTER TABLE ingredient ADD PRIMARY KEY ( Ingr_id );
ALTER TABLE ingredient MODIFY COLUMN pizza_size VARCHAR(5) NOT NULL;
ALTER TABLE ingredient MODIFY COLUMN Ingr1 VARCHAR(30);
ALTER TABLE ingredient MODIFY COLUMN Ingr2 VARCHAR(30);
ALTER TABLE ingredient MODIFY COLUMN Ingr3 VARCHAR(30);
ALTER TABLE ingredient MODIFY COLUMN Ingr4 VARCHAR(30);
ALTER TABLE ingredient MODIFY COLUMN Ingr5 VARCHAR(30);
ALTER TABLE ingredient MODIFY COLUMN Ingr6 VARCHAR(30);
ALTER TABLE ingredient MODIFY COLUMN Ingr7 VARCHAR(30);
ALTER TABLE ingredient MODIFY COLUMN Ingr8 VARCHAR(30);
ALTER TABLE ingredient MODIFY COLUMN Item_id  INT NOT NULL;
-- Establishing relationships --
ALTER TABLE ingredient ADD FOREIGN KEY (Item_id) REFERENCES item(Item_id) ON DELETE CASCADE;



-- QUERIES --
--  1 What days and times do we tend to be busiest?--

SELECT (order_date) AS Busiest_days,
  CONCAT(order_time)AS Time,
  sum(Quantity) AS Quantity_ordered
FROM
  Pizza_order
GROUP BY
  Busiest_days, Time
ORDER BY
  Quantity_ordered DESC;
  
  -- 2 How many pizzas are we making during peak periods?--
	 /* With regards to this question the company want to find out how many pizzas they making
      within a peak period.
      I calculated all the periods within which they make the most pizzas by using a two our range
      on  a derrived column with the Alias 'Peak Period". The outcome of this code will generate all
      the hour range within which they make the most pizzas. However, you can narrow the result
      to the topmost period by using the LIMIT clause*/
  
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
    
   -- 3 What are our best and worse selling pizzas ?
   -- With regards to this question the company simply want to know their best and worse selling pizzas.
   -- You can do this by finding the total quantity of pizzas sold and group this result 
   -- in according to their respective pizza names and the unique identifyer and order them in DESC and ASC
   -- to find the best and worse respectively
   
   -- BEST SELLING PIZZAS --
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
LIMIT 5;  --  5 pizzas make the best selling pizzas
   
   -- WORSE SELLING PIZZAS
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

-- 4 What's our average order value? --
 /* The question simply means the average monetory value of orders--
    I will first find the sum  the total monetory value ALIAS(Total_Order Value) 
    which is sum(total_price) and the then find the average of this value
    This can be done using subquery
     Also I will be dealing with two tables so i will introduce join in my code */
 
 SELECT AVG(Order_Value) AS Average_Order_Value
FROM ( SELECT 
		   SUM(total_price) AS Order_Value
      FROM pizza_order po
      JOIN item i
      ON po.Item_id = i.Item_id
GROUP BY order_id) AS Order_Values;
       
	 -- ALTERNATIVELY --
SELECT
 SUM(total_price) /
count(distinct order_id) AS  Average_order_Value
 from pizza_order po
JOIN item i
ON po.Item_id = i.Item_id;
           