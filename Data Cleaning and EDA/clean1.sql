SELECT * FROM zomato.movies;
use zomato;

select name
from movies
where name like 'B_____';

select name from movies
where name like '%man%';

select name from movies
where name like 'man%';

select name from movies
where name like '%man';

select name,UPPER(name),LOWER(name) from movies;


select concat(name,' ',director,' ',star)
from movies;

select concat_ws('@',name,director,star)
from movies;

select name,substr(name,1,5) from movies;

select name,substr(name,5) from movies;

select name,substr(name,-5,1) from movies;

select replace("Hello world","world","india");

select 5+6;

select name,replace(name,"man","woman") from movies;

-- last 2 character
select substr("Hello",-2);

select reverse("Hello");

select name from movies
where name=reverse(name);

select name,length(name),char_length(name) from movies
where length(name)!=char_length(name);


select insert("hello world",7,0,"india");

select insert("hello world",7,5,"india");

select name,left(name,3),right(name,3) from movies;

select repeat(name,3) from movies;

select trim("      nitish  ");

select trim(both "." from "............nitish........");

select trim(leading "." from "............nitish........");

select trim(trailing"." from "............nitish........");

select length(ltrim("     nitish    "));

select rtrim(" nitish   ");

select substring_index("www.campusx.in",".",1);

select substring_index("www.campusx.in",".",2);

select substring_index("www.campusx.in",".",-2);

select strcmp("Delhi","Mumbai");

select strcmp("Mumbai","Delhi");


select  strcmp("Delhi","DELHI");


select locate("w","hello world",4);

select locate("w","hello world",9);

select lpad('8888888888',13,"+91");

select rpad('8888888888',13,"+91");



