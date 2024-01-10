use zomato;
-- create backup for  your table
create table laptop_backup1 like laptopdata;
insert into laptop_backup1
select * from laptopdata;

select data_length/1024 from information_schema.tables
where table_schema='zomato'
and table_name='laptopdata';


select * from laptop;

select data_length/1024 from information_schema.tables
where table_schema='zomato'
and table_name='laptop';

-- delete unnamed column
alter table laptop drop column `Unnamed: 0`;

select * from laptop;


delete from laptop
where Company is Null and TypeName is null
and Inches is null and ScreenResolution is null and
Cpu is null and Ram is null and
Memory is null and Gpu is null and OpSys is null and
Weight is null and Price is null;

alter table laptop modify column Inches decimal(10,1);

select * from laptop;

-- updating ram memory column
update laptop
set ram=replace(Ram,'GB','');

select * from laptop;

alter table laptop modify column Ram Integer;

SELECT DATA_LENGTH/1024 FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'zomato'
AND TABLE_NAME = 'laptop';


select * from laptop;

-- weight Update
update laptop
set Weight=Replace(Weight,'kg','');

select * from laptop;

-- price update
update laptop
set price=round(price);

select * from laptop;

alter table laptop modify column Price integer;

select distinct OpSys from laptop;
-- mac
-- window
-- linux
-- no os
-- Android chrome(others)

select OpSys,
case
   when OpSys like '%mac%' then 'macos'
   when  OpSys like 'window%' then 'window'
   when OpSys like '%linux%' then 'linux'
   when OpSys  ='No OS' then 'N/A'
   else 'other'
end as 'os_brand'
from laptop;

Update laptop
set OpSys=
case
     when OpSys like '%mac%' then 'macos'
     when OpSys like 'window%' then 'window'
     when OpSys like  '%linux' then 'linux'
     when OpSys='No OS' then 'N/A'
     else 'other'
end;

select * from laptop;


alter table laptop
add column gpu_brand varchar(255) after Gpu,
add column gpu_name varchar(255) after gpu_brand;


select * from laptop;

-- gpu_brand
 UPDATE laptop
     SET gpu_brand = SUBSTRING_INDEX(Gpu, ' ', 1);
     
select gpu_brand from laptop;

-- updateing gpu name
update laptop
set gpu_name=replace(Gpu,gpu_brand,'');

select * from laptop;

alter table laptop drop column Gpu;

alter table laptop
add column cpu_brand varchar(255) after Cpu,
add column cpu_name varchar(255) after cpu_brand,
add column cpu_speed decimal(10,1) after cpu_name;


select * from laptop;

-- cpu_brand
update laptop
set cpu_brand=substring_index(Cpu,' ',1);

select cpu_brand from laptop;

-- cpu_speed
update laptop
set cpu_speed=cast(replace(substring_index(Cpu,' ',-1),'GHz','') as decimal(10,2));

select * from laptop;

-- cpu_name
update laptop
set cpu_name=replace(replace(Cpu,cpu_brand,''),
substring_index(replace(Cpu,cpu_brand,''),' ',-1),'');

select * from laptop;

alter table laptop drop column Cpu;

select ScreenResolution,
substring_index(substring_index(ScreenResolution,' ',-1),'x',1),
substring_index(substring_index(ScreenResolution,' ',-1),'x',-1)
from laptop;

alter table laptop
add column resolution_width integer after ScreenResolution,
add column resolution_height integer after resolution_width;

select * from laptop;

update laptop
set resolution_width=substring_index(substring_index(ScreenResolution,' ',-1),'x',1),
resolution_height=substring_index(substring_index(ScreenResolution,' ',-1),'x',-1);

select * from laptop;

alter table laptop
add column touchscreen integer after resolution_height;

select ScreenResolution like '%Touch%' from laptop;

update laptop
set touchscreen=ScreenResolution like '%Touch%';

select * from laptop;

alter table laptop
drop column ScreenResolution;

select * from laptop;

select cpu_name,
substring_index(trim(cpu_name),' ',2)
from laptop;

update laptop
set cpu_name=substring_index(trim(cpu_name),' ',2);

select * from laptop;

select distinct cpu_name from laptop;

alter table laptop
add column memory_type varchar(255) after Memory,
add column primary_storage integer after memory_type,
add column secondary_storage integer after primary_storage;


select Memory,
case
    when Memory like '%SSD%' and Memory like '%HDD%' then 'Hybrid'
    when Memory like '%SSD%' then 'SSD'
    when Memory like '%HDD%' then 'HDD'
    when Memory like '%Flash Storage%' then 'Flash Storage'
    when Memory like '%Hybrid%' then 'Hybrid'
    when Memory like '%Flash Storage%' and Memory like '%HDD%' then 'Hybrid'
    else null
end as 'memory_type'
from laptop;


update laptop
set memory_type=case
    when Memory like '%SSD%' and Memory like '%HDD%' then 'Hybrid'
    when Memory like '%SSD%' then 'SSD'
    when Memory like '%HDD%' then 'HDD'
    when Memory like '%Flash Storage%' then 'Flash Storage'
    when Memory like '%Hybrid%' then 'Hybrid'
    when Memory like '%Flash Storage%' and Memory like '%HDD%' then 'Hybrid'
    else null
end;

select * from laptop;

select Memory,
regexp_substr(substring_index(Memory,'+',1),'[0-9]+'),
case when Memory like '%+%' then
regexp_substr(substring_index(Memory,'+',-1),'[0-9]+') else 0 end
from laptop;

update laptop
set primary_storage=regexp_substr(substring_index(Memory,'+',1),'[0-9]+'),
secondary_storage=case when Memory like '%+%' then
regexp_substr(substring_index(Memory,'+',-1),'[0-9]+') else 0 end;

select * from laptop;


-- secondary storage

SELECT 
primary_storage,
CASE WHEN primary_storage <= 2 THEN primary_storage*1024 ELSE primary_storage END,
secondary_storage,
CASE WHEN secondary_storage <= 2 THEN secondary_storage*1024 ELSE secondary_storage END
FROM laptop;

UPDATE laptop
SET primary_storage = CASE WHEN primary_storage <= 2 THEN primary_storage*1024 ELSE primary_storage END,
secondary_storage = CASE WHEN secondary_storage <= 2 THEN secondary_storage*1024 ELSE secondary_storage END;



select * from laptop;

alter table laptop drop column gpu_name;

select * from laptop;














































