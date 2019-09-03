-- practice 01

-- 문제 1
-- 사번이 10944인 사원의 이름은(전체 이름)
select emp_no, concat(first_name, ' ', last_name) as 이름 
from employees
where emp_no = 10944;

-- 문제 2
-- 전체직원의 다음 정보를 조회하세요. 가장 선임부터 출력이 되도록 하세요. 출력은
-- 이름, 성별, 입사일 순서이고 “이름”, “성별”, “입사일로 컬럼 이름을 대체해
-- 보세요.
select concat(first_name, ' ', last_name) as 이름,
	gender as 성별, 
    hire_date as 입사일
    from employees
order by hire_date;

-- select * from employees;

-- 문제 3
-- 여직원과 남직원은 각 각 몇 명이나 있나요?
select count(case when gender='F' then 'F' end) as 여자,
	count(case when gender='M' then 'M' end) as 남자
	from employees;
    
-- 문제 4
-- 현재 근무하고 있는 직원 수는 몇 명입니까? (salaries 테이블을 사용합니다.)
select count(*) as 직원수
	from salaries
where to_date like '9999%';
 -- select * from salaries;

-- 문제 5
-- 부서는 총 몇 개가 있나요?
select count(dept_name) as 부서
	from departments;
    
-- 문제 6
-- 현재 부서 매니저는 몇 명이나 있나요?(역임 매너저는 제외)
select count(*) as '매니저 수' 
	from dept_manager
where to_date like '9999%';

-- 문제 7
-- 전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세요.
select dept_name, length(dept_name) as '부서 길이'
	from departments;
    

-- 문제 8
-- 현재 급여가 120,000이상 받는 사원은 몇 명이나 있습니까?
select count(emp_no) as '사원 수'
	from salaries
where salary >= 120000;

-- 문제 9
-- 어떤 직책들이 있나요? 중복 없이 이름이 긴 순서대로 출력해 보세요.
select distinct title, length(title) as '직책 길이'
	from titles;

-- 문제 10
-- 현재 Enginner 직책의 사원은 총 몇 명입니까?
select count(emp_no) as '사원 수'
	from titles
where title like 'enginner';

-- 문제 11
-- 사번이 13250(Zeydy)인 지원이 직책 변경 상황을 시간순으로 출력해보세요.
select title, to_date as '변경 시간'
	from titles
where emp_no like '13250'
order by to_date;