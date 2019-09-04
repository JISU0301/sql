-- 1. 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
select a.emp_no as '사번',
concat(b.first_name, ' ', b.last_name) as '이름',
a.salary as '연봉'
from salaries a, employees b
where a.emp_no = b.emp_no
and to_date = '9999-01-01'
order by 연봉 desc;

-- 2. 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
select a.emp_no as '사번',
concat(a.first_name, ' ', a.last_name) as '이름', 
b.title as '직책'
from employees a, titles b
where a.emp_no = b.emp_no
and to_date = '9999-01-01'
order by 이름;

-- 3. 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..
select a.emp_no as '사번',
concat(a.first_name, ' ', a.last_name) as '이름',
b.dept_no as '부서'
from employees a, dept_emp b
where a.emp_no = b.emp_no
and to_date = '9999-01-01'
order by 이름;

-- 4. 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
select a.emp_no as '사번',
concat(a.first_name, ' ', a.last_name) as '이름',
b.salary as '연봉',
c.title as '직책',
d.dept_no as '부서'
from employees a, salaries b, titles c, dept_emp d
where a.emp_no = b.emp_no
and b.emp_no = c.emp_no
and c.emp_no = d.emp_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
and d.to_date = '9999-01-01'
order by 이름;

-- 5. ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의
-- 사번과 이름을 출력하세요. (현재 ‘Technique Leader’의 직책(으로 근무하는
-- 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력
-- 합니다.
select a.emp_no as '사번',
concat(b.first_name, ' ', b.last_name) as '이름'
from titles a, employees b
where a.emp_no = b.emp_no
and a.title = 'Technique Leader'
and to_date != '9999-01-01';

-- 6. 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명,
-- 직책을 조회하세요.
select concat(a.first_name, ' ', a.last_name) as '이름',
	b.dept_no as '부서명',
    c.title as '직책'
from employees a, dept_emp b, titles c
where a.emp_no = b.emp_no
and c.emp_no = a.emp_no
and a.last_name like 'S%' ;

-- 7. 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가
-- 큰 순서대로 출력하세요.
select a.title as '직책',
b.salary as '급여'
from titles a, salaries b
where a.emp_no = b.emp_no
and title = 'Engineer'
and b.salary >= 40000
order by b.salary desc;
 
-- 8. 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
select a.title as '직책',
b.salary as '급여'
from titles a, salaries b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
and b.salary > 50000
order by b.salary desc;

-- 9. 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
select a.dept_no as '부서',
avg(b.salary)  as '평균 연봉' 
from dept_emp a, salaries b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by a.dept_no
order by avg(b.salary) desc;
-- order by '평균 연봉' desc;

-- 10. 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
select a.title as '직책', 
avg(b.salary) as '평균 연봉' 
from titles a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
group by a.title
order by avg(b.salary) desc;
