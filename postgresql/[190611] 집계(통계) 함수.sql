select avg(salary), emp_no
--select avg(salary)
from salaries 
where to_char(from_date, 'yyyy') = '1985' 
group by emp_no 
having avg(salary) > 1000;
