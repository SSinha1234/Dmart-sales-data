-----------------------GENERIC-----------------------------------
-- How many unique cities does the data have?
SELECT DISTINCT city FROM sales;
-- In which city is each branch?
SELECT DISTINCT city,branch FROM sales
-----------------------------------------------------------------------------------------------------------------------------------------
-------	------------------PRODUCT--------------------------------------------------------------
-- How many unique product lines does the data have?
SELECT DISTINCT productline FROM sales;
--What is the most selling product line?
select productline, count(*) as selling_product from sales
group by productline 
order by selling_product desc
--What is the total revenue by month?
select extract (month from date), sum(unit_price*quantity) from sales
group by date
--What month had the largest COGS?
select extract(month from date), sum(cogs) as total_cogs from sales 
group by extract(month from date)
order by total_cogs desc
--What product line had the largest revenue?
select productline, sum(unit_price*quantity) as total_revenue from sales 
group by productline 
order by total_revenue desc
--What is the city with the largest revenue?
select branch, city, sum(unit_price*quantity) as total_revenue from sales 
group by branch,city 
order by total_revenue desc
--What product line had the largest VAT?
select productline, avg(tax) as VAT from sales 
group by productline 
order by VAT desc
--Fetch each product line and add a column to those product line showing "Good", "Bad". 
--Good if its greater than average sales
select avg(quantity) as avg_quant from sales
select productline, 
case
when avg(quantity) > 6 then 'Good'
ELSE 'Bad'
end as remark
	from sales
group by productline
--Which branch sold more products than average product sold?
select branch, sum(quantity) as quant from sales
group by branch 
having sum(quantity) > (select avg(quantity) from sales)
--What is the most common product line by gender
select Gender, productline, count(gender) as total_quant from sales 
group by gender,productline
order by total_quant desc
--What is the average rating of each product line
select  round(cast(avg(rating)as numeric), 2) as avg_rating, productline from sales 
group by productline
order by avg_rating desc
------------------------------------------------------------------------------------------
------------------------CUSTOMERS---------------------------------------------------------
--How many unique customer types does the data have?
select distinct(customer) from sales
--How many unique payment methods does the data have?
select distinct(payment) from sales
-- What is the most common customer type?
select customer, count(*) as commom_customer from sales 
group by customer 
order by commom_customer desc
-- Which customer type buys the most?
select customer, count(quantity) as most_buy from sales 
group by customer
order by most_buy desc
-- What is the gender of most of the customers?
select customer, gender, count(gender) as most_customer from sales 
group by customer, gender 
order by most_customer desc
-- What is the gender distribution per branch?
select branch, gender, count(gender) as per_branch from sales
group by branch, gender
order by per_branch desc
-- Which time of the day do customers give most ratings?
select time, avg(rating) as most_rating from sales 
group by time
order by most_rating desc
-- Which time of the day do customers give most ratings per branch?
select branch, time, avg(rating) as most_rating from sales 
group by time, branch
order by most_rating desc
-------------------------------------------------------------------------------------------------------
-------------------------SALES----------------------------------
-- Which of the customer types brings the most revenue?
select customer, sum(unit_price*quantity) as most_revenue from sales 
group by customer 
order by most_revenue desc
-- Which city has the largest tax/VAT percent?
select city, round(cast(avg(tax) as numeric),2) as tax_percent from sales 
group by city 
order by tax_percent desc
-- Which customer type pays the most in VAT?
select customer,payment, round(cast(avg(tax) as numeric),2) as tax_percent from sales 
group by payment, customer
order by tax_percent desc

