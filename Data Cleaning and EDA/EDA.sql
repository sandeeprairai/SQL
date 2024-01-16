use zomato;

select * from laptop;

-- head,tail and sample
select *  from laptop
order by `index` limit 5;

select * from laptop
order by `index` desc limit 5;

select * from laptop
order by rand() limit 5;

-- 2 8 number summary

SELECT COUNT(Price) OVER(),
MIN(Price) OVER(),
MAX(Price) OVER(),
AVG(Price) OVER(),
STD(Price) OVER()
FROM laptop;

-- missing values
select count(Price)
from laptop
where Price is null;


select t.buckets,repeat('*',count(*)/5) from (select Price,
 case
   when Price between 0 and 25000 then '0-25k'
   when Price between 25001 and 50000 then '25k-50k'
   when Price between 50001 and 75000 then '50k-75k'
   when Price between 75001 and 100000 then '75k-100k'
   else '>100k'
end as 'buckets'
from laptop)t
group by t.buckets;


select Company,count(Company) from laptop
group by Company;

select cpu_speed,Price from laptop;


select Company,
sum(case when Touchscreen=1 then 1 else 0 end) as 'touchscreen_yes',
sum(case when Touchscreen=0 then 1 else 0 end) as 'Touchscreen_no'
from laptop
group by Company;


select distinct cpu_brand from laptop;

select Company,
sum(case when cpu_brand='intel' then 1 else 0 end) as 'intel',
sum(case when cpu_brand='amd' then 1 else 0 end) as 'amd',
sum(case when cpu_brand='Samsung' then 1 else 0 end) 'samsung'
from laptop
group by Company;

-- categorical Numerical Bivariate Analysis
select Company,min(Price),
max(Price),avg(Price),std(Price)
from laptop
group by Company;

select * from laptop
where Price is null;

-- replace missing values with mean of price
update laptop
set price=(select avg(Price) from laptop)
where Price is null;

-- 
SELECT * FROM zomato.laptopdata;
-- Feature Engineering
alter table laptop add column ppi integer;
select * from laptop;

update laptop
set ppi=round(sqrt(resolution_width*resolution_width+resolution_height*resolution_height)/Inches);

select * from laptop;

alter table laptop add column screen_size varchar(255) after Inches;

select * from laptop;

update laptop
set screen_size=
case 
 when Inches<14.0 then 'small'
 when Inches>=14.0 and Inches<17.0 then 'medium'
 else 'large'
end;

select * from laptop;

select screen_size,avg(Price) from laptop
group by screen_size;

-- One hot Encoding
select gpu_brand,
case when gpu_brand='Intel' then 1 else 0 end as 'intel',
case when gpu_brand='amd' then 1 else 0 end as 'amd',
case when gpu_brand='nvidia' then 1 else 0 end as 'nvidia',
case when gpu_brand='arm' then 1 else 0 end as 'arm'
from laptop;





