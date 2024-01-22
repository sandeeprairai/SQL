 use zomato;
SELECT * FROM zomato.`walmartsalesdata.csv`;
-- data cleaning
-- 1
select * from zomato.`walmartsalesdata.csv`;

-- 2 add the time_of_day column
select time,
(case when `time` between "00:00:00" and "12:00:00" then "morning"
when `time` between "12:01:00" and "16:00:00" then "afternoon"
else "evening" end) as time_of_day
from zomato.`walmartsalesdata.csv`;


alter table zomato.`walmartsalesdata.csv`  add column time_of_day varchar(20);

select * from zomato.`walmartsalesdata.csv`;


-- 
update zomato.`walmartsalesdata.csv`
set time_of_day=(
case 
   when `time` between "00:00:00" and "12:00:00" then "Morning"
   when `time` between "12:01:00" and "16:00:00" then "Afternoon"
else "Evening"
end
);

select * from `walmartsalesdata.csv`;

-- add day_name column
select date,dayname(date) from `walmartsalesdata.csv`;

alter table `walmartsalesdata.csv` add column day_name varchar(10);

update `walmartsalesdata.csv`
set day_name=dayname(date); 

select * from `walmartsalesdata.csv`;

-- update month_name column
select date,monthname(date) from `walmartsalesdata.csv`;

alter table `walmartsalesdata.csv` add column month_name varchar(10);


select * from `walmartsalesdata.csv`;

update `walmartsalesdata.csv`
set month_name=monthname(date);


-- 1
select distinct(City) from `walmartsalesdata.csv`;

-- 2
select distinct(City),branch from `walmartsalesdata.csv`;

select * from `walmartsalesdata.csv`;
-- Product --
select distinct(`product line`) from `walmartsalesdata.csv`;

-- what is the most  selling product line
select sum(quantity) as qty,
`product line` from `walmartsalesdata.csv`
group by `product line`
order by qty desc;

-- what is the total revenue by month
select month_name as month,
sum(total) as total_revenue
from `walmartsalesdata.csv`
group by month_name
order by total_revenue;

select * from `walmartsalesdata.csv`;

-- what month had the largest cogs?
select month_name as month,
sum(cogs) as cogs
from `walmartsalesdata.csv`
group by month_name
order by cogs;

-- what product line had the largest revenue?
select `product line`,sum(total) as total_revenue
from `walmartsalesdata.csv`
group by `product line`
order by total_revenue desc;

-- what is the city with the largest revenue
select branch,city,sum(total) as total_revenue
from `walmartsalesdata.csv`
group by city,branch
order by total_revenue;

select * from `walmartsalesdata.csv`;

-- what product line had the largest VAT
select `product line`,avg(`Tax 5%`) as avg_tax
from `walmartsalesdata.csv`
group by `product line`
order by avg_tax desc;

-- fetch each prodcut line add a column to those product 
-- line showing "Good","Bad",Good if its grater than average sales
select avg(quantity) as avg_qnty from `walmartsalesdata.csv`;
select `product line`,
case when avg(quantity) > 6 then "Good"
else "Bad"
end as remark
from `walmartsalesdata.csv`
group by `product line`;


-- which branch sold more products than avg product sold?
select branch,sum(quantity) as qnty
from `walmartsalesdata.csv`
group by branch
having sum(quantity) > (select avg(quantity) from `walmartsalesdata.csv`);


-- what is the most common product line by gender
select gender, `product line`,
count(gender) as total_cnt
from `walmartsalesdata.csv`
group by gender,`product line`
order by total_cnt desc;

-- what is the average rating of each product line
select round(avg(rating),2) as avg_rating,
`product line` from `walmartsalesdata.csv`
group by `product line`
order by avg_rating desc;

select * from `walmartsalesdata.csv`;

-- customer
select distinct(`Customer type`)
from `walmartsalesdata.csv`;

-- 2
select distinct payment
from `walmartsalesdata.csv`;

-- 3
select `Customer type`,
count(*) as count
from `walmartsalesdata.csv`
group by `Customer type`
order by count desc;

-- 4
select `Customer type`,
count(*) 
from `walmartsalesdata.csv`
group by `Customer Type`;

-- 5 what is the gender of most of the customers
select gender,count(*) as gender_cnt
from `walmartsalesdata.csv`
group by gender
order by gender_cnt desc;

-- what is the gender distribution per branch
select gender,count(*) as gender_cnt
from `walmartsalesdata.csv`
where branch="C" 
group by gender
order by gender_cnt desc;

-- which time off the day do customers give most ratings?
select time_of_day,avg(rating) as avg_rating
from `walmartsalesdata.csv`
group by time_of_day
order by avg_rating desc;

select time_of_day,branch,
avg(rating) as avg_rating
from `walmartsalesdata.csv`
where branch="A"
group by time_of_day,branch
order by avg_rating desc;

-- which day of the week has the best avg ratings?
select day_name,count(*),
avg(rating) as avg_rating
from `walmartsalesdata.csv`
group by day_name
order by avg_rating desc;

select * from `walmartsalesdata.csv`;

-- which day of the week has the best average ratings per branch?
select day_name,count(day_name) as total_sales
from `walmartsalesdata.csv`
where branch="C"
group by day_name
order by total_sales desc;

-- sales--
select time_of_day,
count(*) as total_sales
from `walmartsalesdata.csv`
where day_name="Sunday"
group by time_of_day
order by total_sales desc;

-- which of the customer types brings the most revenue
select `customer type`,
sum(total) as total_revenue
from `walmartsalesdata.csv`
group by `customer type`
order by total_revenue;

-- which city has the largest tax\vat percent
select city,
round(avg(`Tax 5%`),2) as avg_tax_pct
from `walmartsalesdata.csv`
group by city
order by avg_tax_pct desc;

-- whicg customer type pays the most in vat
select `customer type`,avg(`Tax 5%`) as total_tax
from `walmartsalesdata.csv`
group by `customer type`
order by total_tax;



















