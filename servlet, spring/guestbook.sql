use webdb;
insert
into guestbook
values(null, '둘리', '1234', '호이~', now());
insert
into guestbook
values(null, '마이콜', '4567', '맛좋은라면', now());

show tables;

select no, name, contents, date_format(reg_date, '%Y-%m-%d %H:%i:%s')
from guestbook
order by reg_date desc;

select * from guestbook;

desc user;

select no, name from user where email='email@email.com' and password='1234' order by no asc;

update user
set name = '양승진', email = 'email@email.com', password = '1234', gender = 'male'
where no = 1;

select * from user;

select name, email, password, gender from user where no = 1;

select exists(
		select *
		from user
        where email = 'email@email23.com');