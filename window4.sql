select YEAR(Date),monthname(Date),sum(views) as 'views',
((sum(views) - lag(sum(views)) over(order by year(Date),month(date)))/lag(sum(views)) over(order by year(Date),month(date))) * 100 as 'percent_change'
from youtube_views
group by year(Date),monthname(Date)
order by year(Date),monthname(Date);


-- 2percent change
select *,
(views - lag(views,7) over(order by Date))/lag(views,7) over(order by Date) * 100 as 'weekly_percent_change'
from youtube_views;

use window_function

-- percentile and quantile
select *,
percentile_disc(0.5) within group(order by marks) over() as 'median_marks'
from marks;


--
select *,
percentile_disc(0.5) within group(order by marks) over(partition by branch) as 'median_marks',
percentile_cont(0.5) within group(order by marks) over(partition by branch) as 'median_marks_cont'
from marks;

-- insert into marks (name,branch,marks) values
-- ('abhi','EEE',1);

select * from marks;

-- outlier delete
select * from (select *,
percentile_cont(0.25) within group(order by) over() as 'Q1',
percentile_cont(0.75) within group(order by) over() as 'Q3'
from marks) t
where t.marks > t.Q1 -(1.5 *(t.Q3 - t.Q1)) and 
t.marks < t.Q3 +(1.5 *(t.Q3 - t.Q1))
order by t.student_id;

-- see outlier
select * from (select *,
percentile_cont(0.25) within group(order by) over() as 'Q1',
percentile_cont(0.75) within group(order by) over() as 'Q3'
from marks) t
where t.marks <= t.Q1 -(1.5 *(t.Q3 - t.Q1)) 
order by t.student_id;


-- segementation
select * ,
ntile(3) over(order by marks desc) as 'buckets'
from marks;

select brand_name,model,price,
case
   when bucket= 1 then 'budget'
   when bucket= 2 then 'mid-range'
   when bucket= 3 then 'premium'
end as 'phone_type'
from (select brand_name,model,price ,
ntile(3) over(partition by brand_name order by price) as 'bucket'
from campusx.smartphones) t;



-- cumulative distribution
select * from (select *,
cume_dist() over(order by marks) as 'percentile_Score'
from marks) t
where  t.percentile_Score > 0.90;

select * from (
select source,Destination,airline,avg(price) as 'avg_fare',
dense_rank() over(partition by source,Destination order by avg(price)) as 'rank'
  from subquery_task.flight
group by source,Destination,airline ) t
where t.rank < 2












 











