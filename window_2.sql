use zomato;


SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

select date,month(date),monthname(date) from orders;

select * from (select monthname(date) as 'month',user_id,sum(amount) as 'total',
rank() over(partition by monthname(date) order by sum(amount) desc ) as 'month_rank'
from orders
group by monthname(date),user_id
order by month(date)) t
where t.month_rank<3
order by month desc,month_rank asc;


use window_function;

-- first_value
select * from marks;

select *,
first_value(marks) over(order by marks desc)
from marks;

-- last value
select *,
last_value(marks) over(partition by branch order by  marks desc
rows between unbounded preceding and unbounded following)
from marks;

-- nth value
select *,
nth_value(name,2) over(partition by branch order by  marks desc
rows between unbounded preceding and unbounded following)
from marks;

-- 
select * from (select *,
first_value(name) over(partition by branch order  by marks desc
) as 'topper_name',
first_value(marks) over(partition by branch order  by marks desc) as 'topper_marks'
from marks) t
where t.name=t.topper_name and t.marks=t.topper_marks;

select * from (select *,
last_value(name) over(partition by branch order  by marks desc
rows between unbounded  preceding and unbounded following) as 'topper_name',
last_value(marks) over(partition by branch order  by marks desc
rows between unbounded  preceding and unbounded following) as 'topper_marks'
from marks) t
where t.name=t.topper_name and t.marks=t.topper_marks;


-- lead & lag

select * ,
lag(marks) over(order by student_id),
lead(marks) over(order by student_id)
from marks;


select * ,
lag(marks) over(partition by branch order by student_id),
lead(marks) over(partition by branch order by student_id)
from marks;


use zomato;

select monthname(date),sum(amount),
((sum(amount) - lag(sum(amount)) over(order by month(date)))/lag(sum(amount)) over(order by month(date))) *100 as 'growth'
from orders
group by monthname(date)
order by month(date) asc;






