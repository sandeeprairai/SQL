-- ranking example
select * from (
select BattingTeam,batter,sum(batsman_run) as 'total_run',
dense_rank() over(partition by BattingTeam order by sum(batsman_run) desc) as 'rank_within_team'
from ipl_ball_by_ball_2008_2022
group by BattingTeam,batter) t
where t.rank_within_team < 6
order by t.BattingTeam,t.rank_within_team;

-- cumulative sum
select * from (select
concat("Match-",ROW_NUMBER() OVER(Order by ID)) as 'match_no',
sum(batsman_run) as 'run_scored',
sum(sum(batsman_run)) over(rows between unbounded preceding and current row) as 'carrier_run'
from ipl_ball_by_ball_2008_2022
where batter='V Kohli'
group by ID) t
where match_no='Match-5' or match_no='match-3' or match_no='match-2';

-- cumulative average
select * from (select
concat("Match-",ROW_NUMBER() OVER(Order by ID)) as 'match_no',
sum(batsman_run) as 'run_scored',
sum(sum(batsman_run)) over w as 'carrier_run',
avg(sum(batsman_run)) over w as 'carrier avg'
from ipl_ball_by_ball_2008_2022
where batter='V Kohli'
group by ID 
window w as (rows between unbounded preceding and current row)) t;


-- running average
select * from (select
concat("Match-",ROW_NUMBER() OVER(Order by ID)) as 'match_no',
sum(batsman_run) as 'run_scored',
sum(sum(batsman_run)) over w as 'carrier_run',
avg(sum(batsman_run)) over w as 'carrier avg'
from ipl_ball_by_ball_2008_2022
where batter='V Kohli'
group by ID 
window w as (rows between unbounded preceding and current row)) t;


-- running average

select * from (select
concat("Match-",ROW_NUMBER() OVER(Order by ID)) as 'match_no',
sum(batsman_run) as 'run_scored',
sum(sum(batsman_run)) over w as 'carrier_run',
avg(sum(batsman_run)) over w as 'carrier avg',
avg(sum(batsman_run)) over(rows between 9 preceding and current row) as 'rolling_avg'
from ipl_ball_by_ball_2008_2022
where batter='V Kohli'
group by ID 
window w as (rows between unbounded preceding and current row)) t;

-- percent of total
use zomato;


select f_name,
(total_value/sum(total_value) over()) * 100 as 'percent_total'
 from (select f_id,sum(amount) as 'total_value' from orders t1
join order_details t2
on t1.order_id=t2.order_id
where r_id=1
group by f_id) t
join food t3
on t.f_id=t3.f_id
order by 'percent_total' desc





















