-- curdate(), current_date => yyyy, MM, dd
select curdate(), current_date();

-- curtime(), current_time => hh, mm, ss
select curtime(), current_time();

-- now(), sysdate(), current_timestamp => yyyy, MM, dd, hh, mm, ss
select now(), sysdate(), current_timestamp;

-- now() vs sysdate() << now는 쿼리 실행하기 전 시간 / sysdate는 쿼리 실행 후 시간
select now(), sleep(2), now();
select now(), sleep(2), sysdate();

-- date_format
select date_format(now(), '%Y년 %m월 %d일 %h시 %i분 %s초');
select date_format(sysdate(), '%Y-%m-%d %h:%i:%s');

-- periond_diff << 날짜 차이
-- : YYMM, YYYYMM으로 표기되는 p1과 p2차이의 개월을 반환한다
select concat(first_name, ' ', last_name) as '이름',
	period_diff(date_format(curdate(), '%Y%m'),
    date_format(hire_date,'%Y%m'))
from employees;

-- date_add = adddate / date_sub = subdate
-- (date, INTERVAL expr type)
-- 날짜 date에 type형식(year, month, day)으로 지정한 expr값을 더하거나 뺀다.
-- ex) 각 직원들은 입사 후 6개월이 지나면 근무평가를 한다.
-- 각직원들에 이름, 입사일, 최초 근무평가일은 언제인지 출력
select concat(first_name, ' ', last_name) as '이름',
	hire_date as 고용일,
    date_add(hire_date, interval 6 month)
from employees;

-- cast
select now(), cast(now() as date), cast(now() as datetime);
select 1-2, cast(1-2 as unsigned);
select 1-2, cast(cast(1-2 as unsigned) as signed);

