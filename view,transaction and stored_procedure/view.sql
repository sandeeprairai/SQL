-- view
use subquery_task;
create view indigo as
select * from flight
where airline='Indigo';

select * from indigo;
show tables;


-- complex
use zomato;
create view joined_order_date as
select order_id,amount,r_name,name,date,delivery_time,
delivery_rating,restaurant_rating
 from orders t1
join users t2
on t1.user_id=t2.user_id
join restaurants t3
on t1.r_id=t3.r_id;

SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

select r_name,sum(amount),monthname(date) from joined_order_date
group by  r_name,month(date);

select * from flight;
update flight
set Airline='Indigo Airline'
where Airline='Indigo';




drop view indigo;

create view indigo as 
select * from  flight
where airline='Indigo Airline';


update indigo
set destination='Delhi'
where destination='New Delhi';

select * from flight;


use zomato;

-- not a updatable view
delete from joined_order_date where orderId=1001;


-- user defined function
select hello_world() as message;


use subquery_task;
select hello_world() from flight;


use zomato;
select calculate_age('2003-07-06');

-- proper name
select proper_name('NiTIsh','F','Y');

select proper_name('Nitish','F','Y');


-- date formatting
use subquery_task;
select *,format_date(date_of_journey) from flight;




-- non deterministic
select flights_between('Banglore','New Delhi') as  num_flights;





















