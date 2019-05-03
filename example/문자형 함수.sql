-- 문자형 함수
select upper('SeouL'), ucase('seoul');
select lower('SeouL'), lcase('SEOUL');
select substring('Happy Day', 3, 2);

select concat(first_name, ' ', last_name) as '이름', gender as '성별'  from employees where substring(hire_date, 1, 4) = '1989';
select upper(first_name) from employees;

select lpad('123456', 10, '-'), rpad('123456', 10, '-');
select lpad(emp_no, 10, '-'), rpad('123456', 10, '-') from salaries where from_date like '2001-%' and salary < 70000;

select concat('---', ltrim(' hello '), '---'),
		concat('---', rtrim(' hello '), '---'),
        concat('---', trim(' hello '), '---'),
        concat('---', trim(both 'x' from 'xxxxhelloxxxxx'), '---');
