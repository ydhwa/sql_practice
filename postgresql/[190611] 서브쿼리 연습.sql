-- 예제:  현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력해보세요. 
-- 1) 'Fal Bale'의 부서 번호를 찾는다.
select de.dept_no
from employees e, dept_emp de
where e.emp_no = de.emp_no
	and de.to_date = '9999-01-01'
    and concat(e.first_name, ' ', e.last_name) = 'Fai Bale';
-- 2) d004에서 현재 소속되어 있는 사원들의 사번과 성을 찾는다.
select e.emp_no, e.first_name
from employees e, dept_emp de
where e.emp_no = de.emp_no
	and de.to_date = '9999-01-01'
    and de.dept_no = 'd004';
-- subquery. 2)와 같은 결과가 나온다.
select e.emp_no, e.first_name
from employees e, dept_emp de
where e.emp_no = de.emp_no
	and de.to_date = '9999-01-01'
    and de.dept_no = (
						select de.dept_no
						from employees e, dept_emp de
						where e.emp_no = de.emp_no
							and de.to_date = '9999-01-01'
							and concat(e.first_name, ' ', e.last_name) = 'Fai Bale');

-- 단일행인 경우
-- <, >, =, !=, <=, >=
-- 실습문제 1: 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의 이름, 급여를 나타내세요.
select concat(e.first_name, ' ', e.last_name) as "이름", s.salary as "급여"
from employees e, salaries s
where e.emp_no = s.emp_no
	and s.to_date = '9999-01-01'
    and s.salary < (
					select avg(salary)
					from salaries
					where to_date = '9999-01-01')
order by s.salary desc;
-- 서브쿼리 검증
select avg(salary)
from salaries
where to_date = '9999-01-01';

-- 실습문제 2: 현재 가장 적은 평균 급여를 받고 있는 직책에 대해서 평균 급여를 구하세요.
-- 2-1) having 절에 서브쿼리를 넣어서 해보기
-- 소수점 자리가 맞지 않아 결과값이 나오지 않음. -> round() 사용.
select t.title, round(avg(s.salary))
from salaries s, titles t
where s.emp_no = t.emp_no
	and s.to_date = '9999-01-01'
    and t.to_date = '9999-01-01'
group by t.title
having round(avg(s.salary)) = (
					select round(min(avg_salary))
					from (
						select avg(s.salary) as avg_salary
						from salaries s, titles t
						where s.emp_no = t.emp_no
							and s.to_date = '9999-01-01'
							and t.to_date = '9999-01-01'
						group by t.title) avgs);
-- subquery
select min(avg_salary)
from (
		select avg(s.salary) as avg_salary
		from salaries s, titles t
		where s.emp_no = t.emp_no
			and s.to_date = '9999-01-01'
			and t.to_date = '9999-01-01'
		group by t.title) avgs;

-- 2-2) TOP-K(TOP에서 K개를 뺀다.)
select t.title, avg(s.salary) as avg_salary
from titles t, salaries s
where t.emp_no = s.emp_no
	and t.to_date = '9999-01-01'
    and s.to_date = '9999-01-01'
group by t.title
order by avg_salary asc
limit 1
offset 0;

-- 다중행
-- in (not in)

-- any
-- =any(in과 동일), >any, <any, <>any(!=all과 동일), <=any, >=any

-- all
-- =all, >all, <all, <=all, >=all

-- 예제:  현재 급여가 50000 이상인 직원 이름 출력
-- 1) JOIN 해결
select concat(e.first_name, ' ', e.last_name), s.salary
from employees e, salaries s
where e.emp_no = s.emp_no
	and to_date = '9999-01-01'
	and salary >= 50000;

-- 2) subquery 해결 
select emp_no, salary
from salaries
where to_date = '9999-01-01'
	and salary >= 50000;
-- 본 문제풀이 (where 절에 subquery)
select concat(e.first_name, ' ', e.last_name), s.salary
from employees e, salaries s
where e.emp_no = s.emp_no
	and s.to_date = '9999-01-01'
    and (e.emp_no, s.salary) =any (
									select emp_no, salary
									from salaries
									where to_date = '9999-01-01'
										and salary >= 50000);
-- 다른 방법으로 문제풀이 (from절에 subquery)
select concat(e.first_name, ' ', e.last_name), s.salary
from employees e, (
					select emp_no, salary
					from salaries
					where to_date = '9999-01-01'
						and salary >= 50000) s
where e.emp_no = s.emp_no;


-- 각 부서별로 최고 월급을 받는 직원의 이름과 월급을 출력
-- 각 부서 별 최고 월급
select de.dept_no, max(s.salary) as max_salary
from employees e, salaries s, dept_emp de
where e.emp_no = s.emp_no
	and e.emp_no = de.emp_no
	and s.emp_no = de.emp_no
    and s.to_date = '9999-01-01'
    and de.to_date = '9999-01-01'
group by de.dept_no;

-- 1) where 절에 subquery를 사용
select e.first_name, de.dept_no, s.salary
from employees e, salaries s, dept_emp de
where e.emp_no = s.emp_no
	and s.emp_no = de.emp_no
    and s.to_date = '9999-01-01'
    and de.to_date = '9999-01-01'
    and (de.dept_no, s.salary) =any (
									select de.dept_no, max(s.salary) as max_salary
									from employees e, salaries s, dept_emp de
									where e.emp_no = s.emp_no
										and s.emp_no = de.emp_no
										and s.to_date = '9999-01-01'
										and de.to_date = '9999-01-01'
									group by de.dept_no);

-- 2) from 절에 subquery를 사용
select e.first_name, de.dept_no, s.salary
from employees e, salaries s, dept_emp de,
	(
		select de.dept_no, max(s.salary) as max_salary
		from employees e, salaries s, dept_emp de
		where e.emp_no = s.emp_no
			and s.emp_no = de.emp_no
			and s.to_date = '9999-01-01'
			and de.to_date = '9999-01-01'
		group by de.dept_no) d
where e.emp_no = s.emp_no
	and s.emp_no = de.emp_no
    and de.dept_no = d.dept_no
    and s.to_date = '9999-01-01'
    and de.to_date = '9999-01-01'
    and s.salary = d.max_salary;