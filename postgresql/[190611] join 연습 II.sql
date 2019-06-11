-- 예제10: employees 테이블과 titles 테이블를 join하여 직원의 이름과 직책을 출력하되 여성 엔지니어만 출력하세요. 
select concat(e.first_name, ' ', e.last_name) as "이름",
	t.title as "직책", 
	e.gender as "성별"
from employees e, titles as t
where e.emp_no = t.emp_no
	and e.gender = 'F';


-- 예제6: 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요.
/*
select de.dept_no, d.dept_name, t.title, avg(s.salary)
from salaries s, titles t, dept_emp de, departments d
where s.emp_no = t.emp_no 
	and t.emp_no = de.emp_no
    and de.dept_no = d.dept_no
	and s.to_date = '9999-01-01'
    and t.to_date = '9999-01-01'
    and t.title = 'Engineer'
group by de.dept_no;
*/
-- 동작 제대로 안함. 고쳐야함
select f.dept_no, f.avg_salary, b.dept_name
from (
	select  t.emp_no, de.dept_no, avg(s.salary) as "avg_salary"
	from salaries s, titles t, dept_emp de
	where s.emp_no = t.emp_no 
		and t.emp_no = de.emp_no
    	and s.to_date = '9999-01-01'
    	and t.to_date = '9999-01-01'
    	and t.title = 'Engineer'
	group by de.dept_no) f,
departments b
where f.emp_no = b.emp_no;


-- ANSI/ISO SQL 1999 join 문법
select concat(e.first_name, ' ', e.last_name) as "이름", t.title as "직책", e.gender as "성별"
from employees e
	join titles t on e.emp_no = t.emp_no
where e.gender = 'F';


-- natural join (반드시 명시해줘야 함)
select concat(e.first_name, ' ', e.last_name) as "이름", t.title as "직책", e.gender as "성별"
from employees e
	natural join titles t
where e.gender = 'F';


-- join ~ using
select concat(e.first_name, ' ', e.last_name) as "이름", t.title as "직책", e.gender as "성별"
from employees e
	join titles t 
    using (emp_no)
where e.gender = 'F';




-- limit
-- = select * from employees order by hire_date limit 10, 5;
select * from employees order by hire_datelimit 5 offset 10;

select emp_no
from employees
order by hire_date
limit 5
offset 0;