-- upper
-- 1. 자바 uppercase보다 DB의 upper()함수가 훨씬 빠르다.
-- 2. 웬만하면 DB에서 문자열 처리뿐만 아니라 포맷팅 처리등을 다 해주고 
-- 자바에선 출력만 해결한다
-- 3. 자바코드가 간결해서 좋다.

select upper('Seoul'), ucase('seoul');
select upper(first_name) from employees;

-- lower
select lower('SEoul'), lower('SEOUL');

-- subString()
select substring('Happy Day', 3, 2);

select first_name as '이름',
	substring(hire_date, 1, 4) as '입사년도' 
	from employees;
    
-- lpad, rpad : 정렬
select lpad('1234', 10, '-');
select rpad('1234', 10, '-');


-- salaries 테이블에서 2001년 급여가 70000불 이하의 직원만 사번, 급여로 출력하되 급여는 10자리로 부족한 자리수는 *로 표시
select emp_no, lpad(cast(salary as char), 10, '*')
	from salaries
where from_date = '2001%'
	and salary < 70000;
    
-- ltrim, rtrim, trim << 띄어쓰기 지우기
select concat('---', ltrim('      hello          '), '---') as 'LTRIM';
select concat('---', rtrim('      hello          '), '---') as 'RTRIM';
select concat('---', trim('      hello          '), '---') as 'TRIM';
select concat('---', trim(both 'x' from 'xxxxhelloxxxxxx'), '---') as 'TRIM';