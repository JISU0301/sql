-- 1번 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
SELECT 
    COUNT(a.emp_no)
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND b.salary > (SELECT 
            AVG(salary)
        FROM
            salaries
        WHERE
            to_date = '9999-01-01');

-- 2. 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단
-- 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다.
SELECT 
    c.dept_no, a.emp_no, b.first_name, a.max_salary
FROM
    (SELECT 
        ROUND(MAX(a.salary)) AS max_salary, a.emp_no
    FROM
        salaries a, dept_emp b
    WHERE
        a.emp_no = b.emp_no
            AND a.to_date = '9999-01-01'
            AND b.to_date = '9999-01-01'
    GROUP BY b.dept_no) a,
    employees b,
    dept_emp c
WHERE
    b.emp_no = c.emp_no
        AND c.emp_no = a.emp_no
ORDER BY a.max_salary DESC;
        
-- 3. 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요
SELECT 
    a.emp_no, a.first_name, b.salary
FROM
    employees a,
    salaries b,
    dept_emp c,
    (SELECT 
        ROUND(AVG(a.salary)) AS avg_salary, c.dept_no
    FROM
        salaries a, employees b, dept_emp c
    WHERE
        a.emp_no = b.emp_no
            AND b.emp_no = c.emp_no
            AND a.to_date = '9999-01-01'
            AND c.to_date = '9999-01-01'
    GROUP BY c.dept_no) d
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND c.dept_no = d.dept_no
        AND d.avg_salary < b.salary
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01';	
        
-- 4. 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
SELECT 
    a.emp_no, a.last_name, c.ma_name, c.dept_name
FROM
    employees a,
    dept_emp b,
    (SELECT 
        b.last_name AS ma_name, a.emp_no, a.dept_no, c.dept_name
    FROM
        dept_manager a, employees b, departments c
    WHERE
        a.emp_no = b.emp_no
            AND c.dept_no = a.dept_no) c
WHERE
    a.emp_no = b.emp_no
        AND c.dept_no = b.dept_no;
        
SELECT 
    emp.emp_no, dept_m.emp_no, dept.dept_name
FROM
    dept_manager dept_m,
    employees emp,
    departments dept
WHERE
    emp.emp_no = dept_m.emp_no
        AND dept_m.dept_no = dept.dept_no;


            
-- 5. 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로
-- 출력하세요.
SELECT 
    b.emp_no, b.first_name, a.title, c.salary
FROM
    titles a,
    employees b,
    salaries c,
    dept_emp d,
    (SELECT 
        c.dept_no
    FROM
        salaries a, employees b, dept_emp c
    WHERE
        a.emp_no = b.emp_no
            AND b.emp_no = c.emp_no
            AND a.to_date = '9999-01-01'
            AND c.to_date = '9999-01-01'
    GROUP BY c.dept_no
    ORDER BY MAX(a.salary) DESC
    LIMIT 0 , 1) e
WHERE
    b.emp_no = a.emp_no
        AND b.emp_no = c.emp_no
        AND b.emp_no = d.emp_no
        AND d.dept_no = e.dept_no
        AND a.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND d.to_date = '9999-01-01'
ORDER BY c.salary DESC;
    
-- 6. 평균 연봉이 가장 높은 부서는?

SELECT 
    c.dept_no, AVG(a.salary)
FROM
    salaries a,
    employees b,
    dept_emp c
WHERE
    a.emp_no = b.emp_no
        AND b.emp_no = c.emp_no
        AND a.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
GROUP BY c.dept_no
ORDER BY MAX(a.salary) DESC
LIMIT 0 , 1;
    
-- 7. 평균 연봉이 가장 높은 직책?
	SELECT 
    c.title, AVG(a.salary)
FROM
    salaries a,
    employees b,
    titles c
WHERE
    a.emp_no = b.emp_no
        AND b.emp_no = c.emp_no
        AND a.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
GROUP BY c.emp_no
ORDER BY MAX(a.salary) DESC
LIMIT 0 , 1;
    
-- 8. 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
SELECT 
    d.dept_name, a.last_name, b.salary, e.m_n, e.salary
FROM
    employees a,
    salaries b,
    dept_emp c,
    departments d,
    (SELECT 
        a.last_name AS m_n, a.emp_no, e.salary
    FROM
        employees a, titles b, dept_emp c, departments d, salaries e
    WHERE
        a.emp_no = b.emp_no
            AND a.emp_no = c.emp_no
            AND a.emp_no = e.emp_no
            AND c.dept_no = d.dept_no
            AND b.to_date = '9999-01-01'
            AND c.to_date = '9999-01-01'
            AND e.to_date = '9999-01-01'
            AND title = 'manager'
    GROUP BY d.dept_name) e
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND c.dept_no = d.dept_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND b.salary > e.salary
ORDER BY d.dept_name;
        
