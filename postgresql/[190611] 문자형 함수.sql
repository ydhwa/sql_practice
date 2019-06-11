-- ucase는 지원하지 않는다.
select upper('SeouL');

-- lcase는 지원하지 않는다.
select lower('SeouL');

select substring('Happy Day', 3, 2);

-- 날짜형 자료에 문자형 함수를 적용하려면 to_char로 변환 작업을 거쳐줘야 한다. 
select concat(first_name, ' ', last_name) as "이름",
	gender as "성별"
from employees
-- where substring(to_char(hire_date, 'yyyy-mm-dd'), 1, 4) = '1989';
where to_char(hire_date, 'yyyy') = '1989';

select upper(first_name)
from employees;

select lpad('123456', 10, '-'), rpad('123456', 10, '-');

-- lpad의 좌측 파라미터에는 문자형을 넣어줘야 한다.
-- 타입이 엄격하다.
select lpad(cast(emp_no as char), 10, '*'), rpad('123456', 10, '*')
from salaries
where to_char(from_date, 'yyyy-mm-dd') like '2001-%'
	and salary < 70000;

select concat('---', ltrim(' hello '), '---'),
	concat('---', rtrim(' hello '), '---'),
	concat('---', trim(' hello '), '---'),
	concat('---', trim(both 'x' from 'xxxxhelloxxxxx'), '---');

-- leading: 앞에만 지우기
select concat('---', ltrim(' hello '), '---'),
	concat('---', rtrim(' hello '), '---'),
	concat('---', trim(' hello '), '---'),
	concat('---', trim(leading 'x' from 'xxxxhelloxxxxx'), '---');

-- trailing: 뒤에만 지우기
select concat('---', ltrim(' hello '), '---'),
	concat('---', rtrim(' hello '), '---'),
	concat('---', trim(' hello '), '---'),
	concat('---', trim(trailing 'x' from 'xxxxhelloxxxxx'), '---');
