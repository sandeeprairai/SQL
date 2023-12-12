SELECT * FROM zomato.loyal_users;


insert into loyal_users
(user_id,name)
select t1.user_id,name
from orders t1
join users t2 on t1.user_id=t2.user_id
group by user_id
having count(*) > 3;



-- delete


delete from users
where user_id in (select user_id from users
where user_id not in (select distinct(user_id) from orders));

-- update

update loyal_users
set money =(select sum(amount)*0.1 from orders
 where orders.user_id=loyal_users.user_id);
 


