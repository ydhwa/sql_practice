-- 예제 1: 각 사원 별로 평균 연봉 출력
select emp_no, avg(salary) 
from salaries 
group by emp_no;

select emp_no, avg(salary) 
from salaries 
group by emp_no 
order by avg(salary) desc;


-- 예제 3:  사원별 몇 번의 직책 변경이 있었는지 조회 
select emp_no, count(title) 
from titles 
group by emp_no;


-- 예제4 : 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
select emp_no, avg(salary) 
from salaries 
group by emp_no 
having avg(salary) > 50000;


-- 예제5: 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력하세요.
select avg(salary) as "평균 연봉" 
from salaries;

select title, count(emp_no) as "인원 수" 
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

