-- webdb에서 outer 조인 연습
insert into department values (default, '총무팀');
insert into department values (default, '개발팀');
insert into department values (default, '인사팀');
insert into department values (default, '영업팀');

select * from department;

insert into employee values(default, '둘리', 1);
insert into employee values(default, '마이콜', 2);
insert into employee values(default, '또치', 3);
insert into employee values(default, '길동', null);

select * from employee;

-- join ~ on (inner join)
-- 이 경우 팀에 소속되어 있지 않은 길동이는 나오지 않음.
select *
from employee e
	join department d on e.department_no = d.no;
    
-- 해결책: left join (outer join) (길동이가 나옴)
select e.name, coalesce(d.name, '없음')
from employee e
	left join department d on e.department_no = d.no;

-- right join (outer join) (영업팀이 나옴)
select coalesce(e.name, '없음'), d.name
from employee e
	right join department d on e.department_no = d.no;
    
-- full join (outer join) (mysql/mariadb 지원 안함)
-- postgres에서는 지원함
select coalesce(e.name, '없음'), coalesce(d.name, '없음')
from employee e
	full join department d on e.department_no = d.no;

