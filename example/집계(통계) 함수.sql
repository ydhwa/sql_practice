-- 집계(통계) 함수

select avg(salary), sum(salary), emp_no from salaries where from_date like '1985%' group by emp_no having avg(salary) > 1000;

