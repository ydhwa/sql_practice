use webdb;
show tables;
desc department;
desc employee;

-- outer join
insert into department values (null, '총무팀');
insert into department values (null, '개발팀');
insert into department values (null, '인사팀');
insert into department values (null, '영업팀');

select * from department;

insert into employee values(null, '둘리', 1);
insert into employee values(null, '마이콜', 2);
insert into employee values(null, '또치', 3);
insert into employee values(null, '길동', null);

select * from employee;

-- join ~ on (inner join)
-- 이 경우 팀에 소속되어 있지 않은 길동이는 나오지 않음.
select *
from employee e
	join department d on e.department_no = d.no;
    
-- 해결책: left join (outer join) (길동이가 나옴)
select e.name, ifnull(d.name, '없음')
from employee e
	left join department d on e.department_no = d.no;

-- right join (outer join) (영업팀이 나옴)
select ifnull(e.name, '없음'), d.name
from employee e
	right join department d on e.department_no = d.no;
    
-- full join (outer join) (mysql/mariadb 지원 안함)
/*
select ifnull(e.name, '없음'), d.name
from employee e
	full join department d on e.department_no = d.no;
*/

show tables;