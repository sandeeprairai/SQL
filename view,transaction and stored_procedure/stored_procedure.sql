use subquery_task;

call hello_world();


use zomato;
select * from users;
-- user already there
call add_user('Ankit','ankit@gmail.com');

call add_user('Ankit','ankit1234@gmail.com');

set @message='';
call add_user('Ankit','ankit1234@gmail.com',@message);

select @message;

set @message='';
call add_user('ramesh','ramesh1234@gmail.com',@message);

select @message;

call user_orders('vartika@gmail.com');


set @total=0;

call place_order(2,2,'3,4',@total);

select @total






