-- curdate() 미지원
select current_date;

-- curtime() 미지원
select current_time;

-- sysdate() 미지원
select now(), current_timestamp;

/*
 * now와 sysdate 차이점
 * now는 똑같이 출력된다. - 쿼리가 실행되기 전에 실행된다.
 * now() = current_timestamp
 * 
 * sleep()이 아니라 pg_sleep()을 사용한다.
 */
select now(), pg_sleep(2), now();

select current_timestamp, pg_sleep(2), current_timestamp;

-- clock_timestamp() = sysdate()
select clock_timestamp(), pg_sleep(2), clock_timestamp();

-- date_format() 미지원
-- 좌측 파라미터에 "" 들어가면 오류남
select to_date('2019-06-11', 'yyyy-mm-dd');	-- 월은 %c로도 가능 / %h는 12시간제

select to_timestamp('2015-04-29 01:32:11.321', 'YYYY-MM-DD HH24:MI:SS.MS');


-- 각 직원들에 대해 직원 이름과 근무개월 수 출력
/*
SELECT concat(first_name, ' ', last_name) AS name,
	PERIOD_DIFF( DATE_FORMAT(CURDATE(), '%Y%m'),  
	DATE_FORMAT(hire_date, '%Y%m') )
FROM employees;
*/

-- period_diff
select (date_part('year', now()) - date_part('year', hire_date)) * 12 +
	(date_part('month', now()) - date_part('month', hire_date))
from employees;


-- year, month, day, hour, minute, second, millisecond
select now(), now() + interval '12 hour';
select now(), now() - interval '12 hour';


-- casting
select now(), cast(now() as date); -- datetime형인 now()가 날짜만 출력되는 것 확인

-- unsigned 자체를 지원하지 않음

-- 형변환
select '1'::integer + 1;
select '2019-12-31'::date;
