
create table dt_demo(
user_id tinyint,
course_id tinyint unsigned
);

select * from dt_demo;
-- insertion is not happen
insert into dt_demo values(200,200);

-- decimal
alter table dt_demo add column price decimal(5,2);
insert into dt_demo values(100,200,436.38);

-- insertion is not happen
insert into dt_demo values(100,200,4365.38);

-- double and float

alter table dt_demo add column height float ;
alter table dt_demo add column weight double ;


select * from dt_demo;

insert into dt_demo (height,weight) values(172.3456678956,60.4586958494395848843568709467);

-- enum
alter table dt_demo add column gender enum('male','female','others') ;

update dt_demo
set gender='male';

update dt_demo
set gender='delhi';

-- set
alter table dt_demo add column hobby set('sports','gaming');

insert into dt_demo (hobby)values
('sports'),('gaming'),('sports,gaming'),('gaming');


-- medium blob
alter table dt_demo add column dp mediumblob;

select * from dt_demo;

insert into dt_demo (dp) values (load_file('C:/Users/sandeepkumar/OneDrive/Desktop/mu1.png'));

-- latlong

alter table dt_demo add column latlong geometry;
insert into dt_demo (latlong) values(point(62.4567,89.1234));


select st_astext(latlong) from dt_demo;

select st_astext(latlong),st_x(latlong),st_y(latlong) from dt_demo;

-- json
alter table dt_demo add column descr json;

select * from dt_demo;

insert into dt_demo (descr) values('{"os":"android","type":"smartphone"}');

select descr from dt_demo;

select json_extract(descr,'$.type') from dt_demo;

select json_extract(descr,'$.os') from dt_demo









