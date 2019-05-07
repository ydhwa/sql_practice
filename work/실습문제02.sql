/* 실습문제 02. 집계 */
-- 1. 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요. 두 임금의 차이는 얼마인가요? 함께 “최고임금 – 최저임금”이란 타이틀로 출력해 보세요.
select max(salary) as '최고임금',
	min(salary) as '최저임금',
	max(salary) - min(salary) as '최고임금 - 최저임금' 
from salaries;

-- 2. 마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
-- 예) 2014년 07월 10일
-- 월 지정을 %c로 하면 07이 아니라 7 이렇게 뜨므로 %m을 사용함
select date_format(hire_date, '%Y년 %m월 %d일') as '마지막으로 신입사원이 들어온 날' 
from employees 
order by hire_date desc limit 1;

-- 3. 가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
-- 예) 2014년 07월 10일
-- 가장 오래 근속한 직원의 입사일을 찾기 위해 salaries에서 근속일수의 합을 계산하였다.
-- 가장 오래 근속한 직원들의 수가 많기 때문에, 그 중 하나만 출력시키도록 하였다.
select date_format(hire_date, '%Y년 %m월 %d일') as '가장 오래 근속한 직원의 입사일' 
from employees
where emp_no = (
	select emp_no 
    from salaries 
    group by emp_no 
    order by sum(to_date - from_date) desc 
    limit 1);

-- 4. 현재 이 회사의 평균 연봉은 얼마입니까?
select avg(salary) as '현재 회사의 평균 연봉' 
from salaries 
where to_date = '9999-01-01';

-- 5. 현재 이 회사의 최고/최저 연봉은 얼마입니까?
select max(salary) as '현재 회사의 최고 연봉', min(salary) as '현재 회사의 최저 연봉' 
from salaries 
where to_date = '9999-01-01';

-- 6. 최고 어린 사원의 나이와 최 연장자의 나이는?
-- 외국 기업인 것 같으니 외국식으로 나이 계산
select format(min(datediff(sysdate(), birth_date)) / 365, '%d') as '최고 어린 사원의 나이',
	format(max(datediff(sysdate(), birth_date)) / 365, '%d') as '최 연장자 사원의 나이' 
from employees;
