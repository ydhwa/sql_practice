-- 날짜형 함수

select curdate(), current_date;
select curtime(), current_time;
select now(), sysdate(), current_timestamp;
/*
 * now와 sysdate 차이점
 * now는 똑같이 출력된다. - 쿼리가 실행되기 전에 실행된다.
 * sysdate는 2초 차이가 난다. - 쿼리가 실행되면서 실행된다.
 */
select now(), sleep(2), now();
select sysdate(0), sleep(2), sysdate();

select date_format(now(), '%Y년 %m월 %d일 %H시 %i분 %s초');	-- 월은 %c로도 가능 / %h는 12시간제

-- 각 직원들에 대해 직원 이름과 근무개월 수 출력
SELECT concat(first_name, ' ', last_name) AS name,
	PERIOD_DIFF( DATE_FORMAT(CURDATE(), '%Y%m'),  
	DATE_FORMAT(hire_date, '%Y%m') )
FROM employees;

select first_name, hire_date, date_add(hire_date, interval 5 MONTH)
from employees;

select cast(now() as date); -- datetime형인 now()가 날짜만 출력되는 것 확인
select cast(1-2 as unsigned);
select cast(cast(1-2 as unsigned) as signed);

