-- select 기본
-- ex) 
select first_name,
	last_name,
    gender,
    hire_date
from employees;

-- concat
select concat(first_name, ' ', last_name),
    gender,
    hire_date
from employees;

-- alias -> as로 생략 가능
select concat(first_name, ' ', last_name) as 이름,
    gender as 성별,
    hire_date as '입사 날짜' 
from employees;

-- 중복 제거 distinct()
select distinct(title) from titles;


-- order by
select concat(first_name, ' ', last_name) as 이름,
    gender as 성별,
    hire_date as '입사 날짜' 
from employees
order by hire_date desc;

-- ex(2)
select *
	from salaries
where from_date like '2001%'
order by salary desc;

-- where (조건절)
-- ex) employee 테이블에서 1991년 이전에 입사한 직원의 이름, 성별, 입사일 출력
select concat(first_name, ' ', last_name) as 이름,
	gender as 성별,
    hire_date as 입사일
	from employees
where hire_date < '1991-01-01'
order by hire_date desc;

-- ex2) employee 테이블에서 1989년 이전에 입사한 여직원의 이름, 성별, 입사일 출력
select concat(first_name, ' ', last_name) as 이름,
	gender as 성별,
    hire_date as 입사일
	from employees
where hire_date < '1989-01-01' and
	gender = 'f'
order by hire_date desc;

-- ex3)dept_emp 테이블에서 부서 번호가 d005나 d009에 속한 사원의 사번, 부서번호 출력
select emp_no, dept_no
	from dept_emp
where dept_no = 'd005'
or dept_no = 'd009';
-- where dept_no in ('d005','d009');

-- ex4)employees 테이블에서 1989년에 입사한 직원의 이름, 입사일을 출력
select concat(first_name, ' ', last_name) as 이름,
    hire_date as 입사일
	from employees
where hire_date like '1989%' 
-- where hire_date <= '1989-12-31'
-- and hire_date >= '1989-01-01'
order by hire_date desc;

 

