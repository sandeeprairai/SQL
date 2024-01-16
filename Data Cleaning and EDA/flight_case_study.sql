use subquery_task;

select * from flight;
-- 1
select monthname(date_of_journey),count(*)
from flight
group by monthname(date_of_journey)
order by count(*) desc limit 1;
-- 2
select dayname(date_of_journey),avg(price) from flight
group by dayname(date_of_journey)
order by avg(price) desc limit 1;


SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- 3
select monthname(date_of_journey),count(*) from flight
where airline='Indigo'
group by monthname(date_of_journey)
order by month(date_of_journey) asc;

-- 4
select * from  flight
where source='Banglore' and
destination='Delhi' and
dep_time > '10:00:00' and dep_time <'14:00:00';


-- 5
select count(*) from flight
where source='banglore' and
dayname(date_of_journey) in ('saturday','sunday');

-- 6
alter table flight add column departure datetime;
select * from flight;

update flight
set departure= str_to_date(concat(date_of_journey,' ',dep_time),'%Y-%m-%d %H:%i') ;

select * from flight;

alter table flight
add column duration_min integer,
add column arrival datetime;

select Duration,
substring_index(duration,' ',1),
substring_index(duration,' ',-1)
from flight;

select Duration,
substring_index(duration,' ',1),
case 
    when substring_index(duration,' ',-1)=substring_index(duration,' ',1) then 0
    else substring_index(duration,' ',-1)
end as 'mins'
from flight;

update flight
set arrival=date_add(departure,interval Duration minute);


select * from flight;
alter table flight
drop column duration_min;


select time(arrival) from flight;

-- 7
select date(arrival) from flight;


-- 8
select count(*) from flight
where date(departure)!=date(arrival);


-- 9
select source,destination,
time_format(sec_to_time(avg(duration)*60),'%kh %im') as 'avg_duration' from flight
group by source,destination;


-- 10
select * from flight
where total_stops='non-stop' and
date(departure)<date(arrival);


-- 11
select airline,quarter(departure),count(*)
from flight
group by airline,quarter(departure);


-- 13
with temp_table as (select *,
case 
    when total_stops='non-stop' then 'non-stop'
    else 'with stop'
end as 'temp'
from flight)

select temp,
time_format(sec_to_time(avg(Duration)*60),'%kh %im') as 'avg_duration',
avg(price) as 'avg_price'
from temp_table
group by temp;

-- 14 1st March to 10th Mar 2019
select * from flight
where source='Delhi' and
date(departure) between '2019-03-01' and '2019-03-10';

-- 15
select airline,
time_format(sec_to_time(max(duration)*60),'%kh %im') as 'max_duration'
from flight
group by airline
order by max(duration) desc;

-- 16
select source,destination,
time_format(sec_to_time(avg(duration)*60),'%kh %im') as 'avg_duration' from flight
group by source,destination
having avg(duration) > 180;

-- 17
select dayname(departure), 
sum(case when hour(departure) between  0 and 5 then 1 else 0 end) as '12am-6am',
sum(case when hour(departure) between  6 and 11 then 1 else 0 end) as '6am-12pm',
sum(case when hour(departure) between  12 and 17 then 1 else 0 end) as '12pm-6pm',
sum(case when hour(departure) between  18 and 23 then 1 else 0 end) as '6pm-12pm'
from flight
where source='Banglore' and destination='Delhi'
group by dayname(departure)
order by dayofweek(departure) asc;


-- 18
select dayname(departure),
avg(case when hour(departure) between 0 and 5 then price else null end) as '12am-6am',
avg(case when hour(departure) between 6 and 11 then price else null end) as '6am-12pm',
avg(case when hour(departure) between 12 and 17 then price else null end) as '12pm-6pm',
avg(case when hour(departure) between 18 and 23 then price else null end) as '6pm-12pm'
from flight
where source='Banglore' and destination='Delhi'
group by dayname(departure)
order by dayofweek(departure) asc;


























