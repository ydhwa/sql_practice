/* 실습문제 04. 서브쿼리 */
-- 문제1. 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
-- subquery
select count(*) as '현재 평균 연봉보다 많은 월급을 받는 직원의 수'
from employees e, salaries s
where e.emp_no = s.emp_no
	and s.to_date = '9999-01-01'
    and s.salary > (
					select avg(salary)
					from salaries
                    where to_date = '9999-01-01');


-- 문제2. 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
select e.emp_no as '사번', concat(e.first_name, ' ', e.last_name) as '이름', d.dept_name as '부서', s.salary as '연봉'
from employees e, dept_emp de, departments d, salaries s
where e.emp_no = de.emp_no
	and e.emp_no = s.emp_no
	and de.dept_no = d.dept_no
    and de.to_date = '9999-01-01'
    and s.to_date = '9999-01-01'
    and (de.dept_no, s.salary) =any (
									select de.dept_no, max(s.salary)
                                    from dept_emp de, salaries s, employees e
                                    where e.emp_no = s.emp_no
										and s.emp_no = de.emp_no
										and de.to_date = '9999-01-01'
                                        and s.to_date = '9999-01-01'
									group by de.dept_no)
order by s.salary desc;


-- 문제3. 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
select e.emp_no as '사번', concat(e.first_name, ' ', e.last_name) as '이름', s.salary as '연봉'
from employees e,
	dept_emp de,
    salaries s,
	(
    select de.dept_no as dept_no, avg(s.salary) as avg_salary
	from dept_emp de, salaries s, employees e
    where e.emp_no = s.emp_no
		and s.emp_no = de.emp_no
		and de.to_date = '9999-01-01'
        and s.to_date = '9999-01-01'
	group by de.dept_no) ds
where e.emp_no = de.emp_no
	and e.emp_no = s.emp_no
    and de.to_date = '9999-01-01'
    and s.to_date = '9999-01-01'
    and de.dept_no = ds.dept_no
    and s.salary > ds.avg_salary;


-- 문제4. 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select e.emp_no as '사번', concat(e.first_name, ' ', e.last_name) as '이름', me.manager_name as '매니저 이름', d.dept_name as '부서 이름'
from employees e,
	dept_emp de,
    departments d,
    (
    select dm.dept_no as dept_no, concat(e.first_name, ' ', e.last_name) as manager_name 
    from dept_manager dm, employees e
    where dm.emp_no = e.emp_no
		and dm.to_date = '9999-01-01') me
where e.emp_no = de.emp_no
	and de.dept_no = d.dept_no
    and de.dept_no = me.dept_no;


-- 문제5. 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
-- 연봉 순: 많이 받는 순으로 해석함
select e.emp_no as '사번', concat(e.first_name, ' ', e.last_name) as '이름', t.title as '직책', s.salary as '연봉'
from employees e, 
	salaries s, 
	titles t, 
    dept_emp de
where e.emp_no = s.emp_no
	and e.emp_no = t.emp_no
    and e.emp_no = de.emp_no
    and s.to_date = '9999-01-01'
    and t.to_date = '9999-01-01'
    and de.to_date = '9999-01-01'
    and de.dept_no = (
						select de.dept_no
                        from dept_emp de, employees e, salaries s
                        where e.emp_no = de.emp_no
							and e.emp_no = s.emp_no
                            and de.to_date = '9999-01-01'
                            and s.to_date = '9999-01-01'
						group by de.dept_no
                        order by avg(s.salary) desc
                        limit 0, 1)
order by s.salary desc;


-- 문제6. 평균 연봉이 가장 높은 부서는? 
-- subquery 없이 푸는 방법
select de.dept_no as '부서 번호', d.dept_name as '부서명', avg(s.salary) as '평균 연봉'
from dept_emp de, employees e, salaries s, departments d
where e.emp_no = de.emp_no
	and e.emp_no = s.emp_no
    and de.dept_no = d.dept_no
	and de.to_date = '9999-01-01'
	and s.to_date = '9999-01-01'
group by de.dept_no
order by avg(s.salary) desc
limit 0, 1;

-- subquery 사용 (쿼리 너무 지저분하다.)
select ds.dept_no as '부서 번호', d.dept_name as '부서명', ds.avg_salary as '평균 연봉'
from (
	select de.dept_no as dept_no, avg(s.salary) as avg_salary
	from dept_emp de, employees e, salaries s
	where e.emp_no = de.emp_no
		and e.emp_no = s.emp_no
		and de.to_date = '9999-01-01'
		and s.to_date = '9999-01-01'
	group by de.dept_no) ds,
    departments d
where ds.dept_no = d.dept_no
	and ds.avg_salary = (
						select max(avg_salary)
						from (
							select de.dept_no as dept_no, avg(s.salary) as avg_salary
							from dept_emp de, employees e, salaries s
							where e.emp_no = de.emp_no
								and e.emp_no = s.emp_no
								and de.to_date = '9999-01-01'
							and s.to_date = '9999-01-01'
							group by de.dept_no) ds);


-- 문제7. 평균 연봉이 가장 높은 직책?
-- subquery 없이 푸는 방법
select t.title as '직책', avg(s.salary) as '평균 연봉'
from employees e, salaries s, titles t
where e.emp_no = s.emp_no
	and e.emp_no = t.emp_no
    and s.to_date = '9999-01-01'
    and t.to_date = '9999-01-01'
group by t.title
order by avg(s.salary) desc
limit 0, 1;

-- subquery 사용 (쿼리 지저분함)
select distinct t.title, ts.avg_salary
from titles t,
	(
    select t.title as title, avg(s.salary) as avg_salary
	from employees e, salaries s, titles t
	where e.emp_no = s.emp_no
		and e.emp_no = t.emp_no
		and s.to_date = '9999-01-01'
		and t.to_date = '9999-01-01'
	group by t.title) ts
where t.title = ts.title
	and ts.avg_salary = (
							select max(avg_salary)
							from (
								select avg(s.salary) as avg_salary
								from employees e, salaries s, titles t
								where e.emp_no = s.emp_no
									and e.emp_no = t.emp_no
									and s.to_date = '9999-01-01'
									and t.to_date = '9999-01-01'
								group by t.title) ts);
	

-- 문제8. 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은? 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
-- 풀이과정 1) 매니저들의 연봉
select e.emp_no as emp_no, s.salary as salary, dm.dept_no as dept_no
	from dept_manager dm, employees e, salaries s
    where dm.emp_no = e.emp_no
		and e.emp_no = s.emp_no
        and dm.to_date = '9999-01-01'
        and s.to_date = '9999-01-01';

-- 풀이과정 2) 일반 사원들의 연봉
select e.emp_no as emp_no, s.salary as salary, de.dept_no as dept_no
	from dept_manager dm, employees e, salaries s, dept_emp de
    where e.emp_no = s.emp_no
		and e.emp_no = de.emp_no
        and s.to_date = '9999-01-01'
        and de.to_date = '9999-01-01';

-- 해답) 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원들
select d.dept_name as '부서이름', es.fullname as '사원이름', es.salary as '연봉', ms.fullname as '매니저 이름', ms.salary as '매니저 연봉'
from (
	select e.emp_no as emp_no, s.salary as salary, dm.dept_no as dept_no, concat(e.first_name, ' ', e.last_name) as fullname
	from dept_manager dm, employees e, salaries s
	where dm.emp_no = e.emp_no
		and e.emp_no = s.emp_no
		and dm.to_date = '9999-01-01'
		and s.to_date = '9999-01-01') ms,
	(
	select e.emp_no as emp_no, s.salary as salary, de.dept_no as dept_no, concat(e.first_name, ' ', e.last_name) as fullname
	from dept_manager dm, employees e, salaries s, dept_emp de
	where e.emp_no = s.emp_no
		and e.emp_no = de.emp_no
		and s.to_date = '9999-01-01'
		and de.to_date = '9999-01-01') es,
	departments d
where d.dept_no = ms.dept_no
	and d.dept_no = es.dept_no
    and ms.salary < es.salary;

