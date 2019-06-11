-- select 기본

select * from departments;

select first_name, gender, hire_date
from employees;

-- alias에 "" 안쓰면 dbeaver에서는 엑박이 뜸.
select concat(first_name, ' ', last_name) as "이름",
	gender as "성별",
	hire_date as "입사일"
from employees;

select distinct title
from titles;

select concat(first_name, ' ', last_name) as "이름",
	gender as "성별",
	hire_date as "입사일"
from employees
order by hire_date desc;

-- date는 문자열 비교를 할 수 없으므로 to_char 함수를 사용한다.
select emp_no, salary, from_date
from salaries
where to_char(from_date, 'yyyy-mm-dd') like '2001%'
order by salary desc;

select concat(first_name, ' ', last_name) as "이름",
	gender as "성별",
	hire_date as "입사일"
from employees
where hire_date <= '1991-01-30'
order by hire_date desc;

-- 'f'는 오류난다. 
select concat(first_name, ' ', last_name) as "이름",
	gender as "성별",
	hire_date as "입사일"
from employees
where hire_date <= '1988-12-31'
	and gender = 'F'
order by hire_date desc;

select emp_no, dept_no
from dept_emp
where dept_no in ('d005', 'd009');
