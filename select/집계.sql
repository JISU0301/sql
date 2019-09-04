select avg(salary), sum(salary)
	from salaries
where emp_no='10060';

select emp_no, avg(salary), sum(salary)
	from salaries
where to_date='9999-01-01' 
group by emp_no
having avg(salary) > 40000
order by avg(salary);

-- 예제1 : 각 사원별로 평균연봉 출력
select emp_no, avg(salary)
from salaries
group by emp_no;

-- [과제] 예제 2: 각 현재 Manager 직책 사원에 대한 평균 연봉은?
select t.title, avg(s.salary)
 from salaries s, titles t
 where s.emp_no = t.emp_no -- 조인 조건 1
	and s.to_date = '9999-01-01' -- row 선택조건 1
    and t.to_date = '9999-01-01' -- row 선택조건  2
	and t.title = 'Manager'; -- row 선택조건 3
    
    
-- [과제] 예제 2-1 : 각 현재 직책별 평균 연봉은?
 select t.title, avg(s.salary)
 from salaries s, titles t
 where s.emp_no = t.emp_no -- 조인 조건 1
	and s.to_date = '9999-01-01' -- row 선택조건 1
    and t.to_date = '9999-01-01' -- row 선택조건  2
group by t.title;
    
    
 -- 사원별 몇 번의 직책 변경이 있었는지 조회
 select emp_no, count(title) 
 from titles
 group by emp_no
 order by count(title) desc;
 
 select * from titles where emp_no='204120';
 
 -- 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
select emp_no, avg(salary) 
 from salaries
group by emp_no
having avg(salary) >= 50000
order by emp_no;

-- ex 5[과제] 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이
-- 100명 이상인 직책만 출력하세요.

select a.title, avg(b.salary), count(a.emp_no)
	from titles a, salaries b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by a.title
having count(a.emp_no) >= 100
order by count(a.emp_no);

-- ex 6[과제] 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만
-- 평균급여를 구하세요.

select 
	b.dept_no as '부서', 
	-- a.title as '직책',
	avg(c.salary) as '평균 급여'
	from titles a, dept_emp b, salaries c
where a.emp_no = b.emp_no
	and b.emp_no = c.emp_no
	and a.title = 'Engineer'
	and a.to_date = '9999-01-01'
    and b.to_date = '9999-01-01'
    and c.to_date = '9999-01-01'
group by b.dept_no
order by avg(c.salary);


-- ex 7[과제] 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요
select a.title, sum(b.salary)
	from titles a, salaries b
where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
	and a.title != 'Engineer'
group by a.title
	having sum(b.salary) > '2000000000'
    order by sum(b.salary) desc;


