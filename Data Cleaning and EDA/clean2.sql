SELECT count(*) FROM zomato.laptopdata;

--  backup
create table laptop_backup like laptopdata;
insert into laptop_backup
select * from laptopdata;


select DATA_LENGTH/1024 from information_schema.tables
where table_schema='zomato'
and table_name='laptopdata';

alter table laptopdata  drop column `Unnamed: 0`;

select * from laptopdata;

delete from laptop 
where `index` in (select * from laptopdata
where Company is null and TypeName is null and Inches is null
and ScreenResolution is null and Cpu is null and ram is null
and Memory is null and Gpu is null and OpSys is null and
Weight is null and Price is null);

select count(*) from laptopdata;

-- how to deal with duplicaes
select name,gender,age,count(*)
from personal1
group by name,gender,age
having count(*) > 1;

delete from zomato.duplicates
where id not in (select min(id)
from zomato.duplicates
group by name,gender,age);


select distinct Company from laptopdata;

select distinct TypeName from laptopdata;

alter table laptopdata
modify column Inches decimal(10,1);

-- ram
update laptopdata l1
set ram = (select replace(Ram,'GB','') from laptopdata l2
where l2.index=l1.index);

-- correct query
update laptopdata
set ram=replace(Ram,'GB','');

alter table laptopdata modify column Ram Integer;

select DATA_LENGTH/1024 from information_schema.tables
where table_schema='zomato'
and table_name='laptopdata';


-- updated query
update laptopdata
set weight=replace(Weight,'kg','');

select * from laptopdata;

update laptopdata
set price=round(Price);

-- 














