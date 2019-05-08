select * 
from salaries 
where emp_no = 11007;

-- 예제 1: 각 사원 별로 평균 연봉 출력
select emp_no, avg(salary) 
from salaries 
group by emp_no;

select emp_no, avg(salary) 
from salaries 
group by emp_no 
order by avg(salary) desc;

-- 예제 2: 각 현재 Manager 직책 사원에 대한  평균 연봉은?
select avg(salary) 
from salaries;
select emp_no title 
from titles 
where title = 'Manager';

-- 예제 3:  사원별 몇 번의 직책 변경이 있었는지 조회 
select emp_no, count(title) 
from titles 
group by emp_no;

-- 예제4 : 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
select emp_no, avg(salary) as avg_salary 
from salaries 
group by emp_no 
having avg_salary > 50000;

-- 예제5: 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력하세요.
select avg(salary) as '평균 연봉' 
from salaries;
select title, count(emp_no) as '인원 수' 
from titles 
where to_date = '9999-01-01' 
group by title 
having count(emp_no) >= 100;

-- 예제6: 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요.
select emp_no, salary 
from salaries 
where to_date = '9999-01-01';
select emp_no, title 
from titles 
where title = 'Engineer';
/* equijoin */
select * 
from salaries, titles 
where salaries.emp_no = titles.emp_no 
	and salaries.to_date = '9999-01-01' 
    and titles.to_date = '9999-01-01';
-- 이 부분이 진짜 예제 6의 결과가 나오는 쿼리다.
select de.dept_no, d.dept_name, t.title, avg(s.salary)
from salaries s, titles t, dept_emp de, departments d
where s.emp_no = t.emp_no 
	and t.emp_no = de.emp_no
    and de.dept_no = d.dept_no
	and s.to_date = '9999-01-01'
    and t.to_date = '9999-01-01'
    and t.title = 'Engineer'
group by de.dept_no;
 
-- 예제7: 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요. 단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에 대해서 내림차순(DESC)로 정렬하세요.   
select title, sum(salary)
from titles t, salaries s
where t.emp_no = s.emp_no
	and t.to_date = '9999-01-01'
    and s.to_date = '9999-01-01'
group by title
having sum(salary) >= 2000000000
order by sum(salary) desc;

-- 예제10: employees 테이블과 titles 테이블를 join하여 직원의 이름과 직책을 출력하되 여성 엔지니어만 출력하세요. 
select concat(e.first_name, ' ', e.last_name) as '이름', t.title as '직책', e.gender as '성별'
from employees e, titles as t
where e.emp_no = t.emp_no
	and e.gender = 'F';
-- ANSI/ISO SQL 1999 join 문법
select concat(e.first_name, ' ', e.last_name) as '이름', t.title as '직책', e.gender as '성별'
from employees e
	join titles t on e.emp_no = t.emp_no
where e.gender = 'F';
-- natural join
select concat(e.first_name, ' ', e.last_name) as '이름', t.title as '직책', e.gender as '성별'
from employees e
	join titles t
where e.gender = 'F';
-- join ~ using
select concat(e.first_name, ' ', e.last_name) as '이름', t.title as '직책', e.gender as '성별'
from employees e
	join titles t 
    using (emp_no)
where e.gender = 'F';


-- 실습문제 1:  현재 회사 상황을 반영한 직원별 근무부서를 사번, 직원 전체이름, 근무부서 형태로 출력해 보세요.
select e.emp_no as '사번', 
	concat(e.first_name, ' ', e.last_name) as '직원 전체이름', 
    d.dept_name as '근무부서'
from employees e, dept_emp de, departments d
where e.emp_no = de.emp_no
	and de.dept_no = d.dept_no
    and de.to_date = '9999-01-01';

select e.first_name, de.dept_no, d.dept_name
from employees e
	join dept_emp de on e.emp_no = de.emp_no
    join departments d on de.dept_no = d.dept_no
where de.to_date = '9999-01-01'
	and de.dept_no is null;
    
