/* [실습 문제] 01. 기본 */
-- 1. 사번이 10944인 사원의 이름은? (전체 이름)
select concat(first_name, ' ', last_name) as '전체 이름' from employees where emp_no = 10944;

-- 2. 전체 직원의 다음 정보를 조회하세요. 가장 선임부터 출력이 되도록 하세요. 출력은 이름, 성별, 입사일 순서이고 "이름", "성별", "입사일"로 컬럼 이름을 대체해보세요.
select concat(first_name, ' ', last_name) as '이름', gender as '성별', hire_date as '입사일' from employees order by hire_date asc; 

-- 3. 여직원과 남직원은 각각 몇 명이나 되나요?
select count(*) as '여직원 수' from employees where gender = 'F'; -- 여직원
select count(*) as '남직원 수' from employees where gender = 'M'; -- 남직원

-- 4. 현재 근무하고 있는 직원 수는 몇 명입니까? (salaries 테이블을 사용합니다.)
select count(*) as '현재 근무하고 있는 직원 수' from salaries where to_date > now();	-- 기간별로 하나씩만 있을 것이므로 distict emp_no를 사용할 필요가 없다고 판단함

-- 5. 부서는 총 몇 개가 있나요?
select count(*) as '총 부서 수' from departments;

-- 6. 현재 부서 매니저는 몇 명이나 있나요? (역임 매니저는 제외)
select distinct count(emp_no) as '현재 부서 매니저 수' from dept_manager where to_date > now();

-- 7. 전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해보세요.
select * from departments order by length(dept_name) desc;

-- 8. 현재 급여가 120,000 이상 받는 사원은 몇 명이나 있습니까?
select count(*) from salaries where to_date > now() && salary >= 120000;

-- 9. 어떤 직책들이 있나요? 중복 없이 이름이 긴 순서대로 출력해 보세요.
select distinct title from titles order by length(title) desc;

-- 10. 현재 Engineer 직책의 사원은 총 몇 명입니까?
-- Assistant Engineer, Senior Engineer는 찾지 않도록 함. 이들도 모두 찾게 하려면 '%Engineer'로 지정하면 된다.
select count(emp_no) 'Engineer 직책의 사원' from titles where title = 'Engineer';

-- 11. 사번이 13250(Zeydy)인 지원이 직책 변경 상황을 시간순으로 출력해보세요. 
select emp_no as '사번', from_date as '직무 시작일', to_date as '직무 종료일' from titles where emp_no = 13250 order by to_date;
