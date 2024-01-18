use zomato;

update loyal_users set money=50000 where user_id=1;

select * from loyal_users;

set autocommit=0;

insert into loyal_users (name) values ('rishabh');
select * from loyal_users;

select * from loyal_users;


start transaction;
update loyal_users set money=40000  where user_id=1;

update loyal_users set money=25000 where user_id=4;
commit;


start transaction;
update loyal_users set money=30000  where user_id=1;

update loyal_users set money=35000 where user_id2=4;
commit;

start transaction;
update loyal_users set money=30000  where user_id=1;
commit;
update loyal_users set money=35000 where user_id2=4;
rollback;

select * from loyal_users;

start transaction;
savepoint A;
update loyal_users set money=40000  where user_id=1;
savepoint B;
update loyal_users set money=35000 where user_id=4;
rollback to A;













