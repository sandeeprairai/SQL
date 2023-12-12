use zomato;
-- how subquery work
select * from zomato.movies
where score=(select max(score) from zomato.movies);

-- 1
select * from movies
where gross-budget=(select max(gross-budget) from movies);
 -- using order by
select * from movies
order by (gross-budget) desc limit 1;

-- 2
select count(*) from movies 
where score>(select avg(score) from movies);

-- 3
select * from movies 
where year=2000 and score =(select max(score) 
                          from movies
                          where year=2000);

-- 4
select * from movies
where score=(select max(score) from movies
               where votes> (select avg(votes) from movies));
               
-- independent subquery
use zomato;

select * from users
where user_id not in 
   (select  distinct(user_id) from zomato.orders);


-- 2 common table expression
with top_directors as  (select director from movies
                    group by director
                    order by sum(gross) desc
                     limit 3)
select * from movies
where director in (select * from top_directors);

-- 3
select * from movies 
where star in (select star from movies
              where votes>25000
               group by star
             having avg(score)>8.5);
             
-- table subquery
-- 1
select * from movies
where (year,gross-budget) in (select year,max(gross-budget) 
                                     from movies
                                     group by year);
                                     
-- 2
select * from movies 
where (genre,score) in (select genre,max(score)
                       from movies
                    where votes>25000
					group by genre)
and votes > 25000;


-- 3
use zomato;
with top_duos as (
select star,director,max(score)
from movies
group by star,director
order by sum(gross) desc limit 5)

select * from movies
where (star,director,gross) in (select * from top_duos);


-- correlated Subquery
select * from movies m1
where score> (select avg(score) from movies m2
					where m2.genre=m1.genre);
                    
                    
                    
-- 2
SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
with fav_food as (
select t2.user_id,name,f_name,count(*) as 'frequency' from users t1
join orders t2 on t1.user_id=t2.user_id
join order_details t3 on t2.order_id=t3.order_id
join food t4 on t3.f_id=t4.f_id
group by t2.user_id,t3.f_id )

select * from fav_food f1
 where frequency =(select max(frequency) from fav_food f2
        where f2.user_id=f1.user_id);
	
-- select
select name,(votes/(select sum(votes) from movies)) * 100 as 'percentage' from movies
;
-- 2

select name,genre,score,(select avg(score) from movies m2 
where m2.genre=m1.genre)
from movies m1;

select r_name,avg_rating
from (select r_id,avg(restaurant_rating) as 'avg_rating'
         from orders
         group by r_id) t1 join restaurants t2
         on t1.r_id=t2.r_id;
         


-- having
select genre,avg(score) from movies
group by genre
having avg(score) > (select avg(score) from movies)







