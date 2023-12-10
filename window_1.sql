SELECT * FROM window_function.marks;

select branch,avg(marks)
from marks
group by branch;

select *,
avg(marks) over(partition by branch)
from marks;


select *,avg(marks)  over() from marks;

select *,avg(marks) over(partition by branch) from marks;

select *,
avg(marks) over() as 'overall_avg',
min(marks) over(),
max(marks) over(),
min(marks) over(partition by branch),
max(marks) over(partition by branch)
from marks
order by student_id;


--
select * from (select *,
avg(marks) over(partition by branch) as 'branch_avg'
from marks) t
where t.marks>t.branch_avg;

-- rank/dense/row_number
select *,
rank() over(order by marks desc)
from marks;
-- branch
select *,
rank() over(partition by branch order by  marks desc)
from marks;

-- dense rank

select *,
rank() over (partition by branch order by marks desc) as 'rank',
dense_rank() over(partition by branch order by marks desc) as 'dense_rank'
from marks;

-- row number
select *,
row_number() over()
from marks;


-- 
select *,
concat(branch,'-',row_number() over (partition by branch))
from marks
order by student_id;












