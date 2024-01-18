use campusx;

create table uber_rides(
ride_id integer primary key auto_increment,
user_id integer,
cab_id integer,
start_time datetime,
end_time datetime );

select * from uber_rides;



insert into uber_rides (user_id,cab_id,start_time,end_time) values
(33,22,'2023-03-11 06:40:30','2024-03-10 06:00:00');

select current_date();

select current_time();

select now();

select *,date(start_time),
time(start_time),
year(start_time),
month(start_time),
monthname(start_time),
dayofweek(start_time),
dayname(start_time),
quarter(start_time),
hour(start_time),
minute(start_time),
second(start_time),
day(start_time),
dayofyear(start_time),
weekofyear(start_time),
last_day(start_time)
from uber_rides;




select start_time,date_format(start_time,'%d %b %y') from uber_rides;

select start_time,end_time,date_format(end_time,'%l:%i %p') from uber_rides;

-- implicit conversion
select '20203-03-11' > '20203-03-09';

select '2023-03-11' >'9 March 2023';
-- explicit

select monthname('9 Mar 2023');
-- here explicit type conversion done
select str_to_date('9 Mar 2023','%e %b %Y');

select dayname(str_to_date('9-Mar hello 2023','%e-%b hello %Y'));

select datediff(current_date(),'2022-11-07');
select datediff(start_time,end_time)
from uber_rides;

select timediff(current_time(),'20:00:00');
select timediff(start_time,end_time)
from uber_rides;

select now(),date_add(now(),interval 10 year);

select now(),date_add(now(),interval 10 month);

select now(),date_add(now(),interval 10 day);

select now(),date_add(now(),interval 10 second);

select now(),date_sub(now(),interval 10 year);

select now(),date_sub(start_time,interval 10 year)
from uber_rides;

create table posts(
  post_id integer primary key auto_increment,
  user_id integer,
  content text,
  created_at timestamp default current_timestamp(),
  updated_at timestamp default current_timestamp on update current_timestamp
  );
  
select * from posts;
insert into posts (user_id, content) values(1,'hello wold');


update posts
set content='No more hello world'
where post_id=1;

select * from posts













