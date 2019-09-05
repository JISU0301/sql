-- 단일 행 연산

SELECT 
    b.emp_no, a.dept_no
FROM
    dept_emp a,
    employees b
WHERE
    a.emp_no = b.emp_no
        AND to_date = '9999-01-01'
        AND CONCAT(b.first_name, ' ', b.last_name) = 'Fai Bale';

-- sol1-2)
SELECT 
    b.emp_no, CONCAT(b.first_name, ' ', b.last_name) AS '이름'
FROM
    dept_emp a,
    employees b
WHERE
    a.emp_no = b.emp_no
        AND to_date = '9999-01-01'
        AND a.dept_no = 'd004';
    
-- sol sub)
SELECT 
    b.emp_no, CONCAT(b.first_name, ' ', b.last_name)
FROM
    dept_emp a,
    employees b
WHERE
    a.emp_no = b.emp_no
        AND a.dept_no = (SELECT 
            a.dept_no
        FROM
            dept_emp a,
            employees b
        WHERE
            a.emp_no = b.emp_no
                AND a.to_date = '9999-01-01'
                AND CONCAT(b.first_name, ' ', b.last_name) = 'Fai Bale')
        AND a.to_date = '9999-01-01'
        AND a.dept_no = 'd004';
    
    
--  서브쿼리는 괄호로 묶기
--  서브쿼리 내에 order by 금지
--  group by 절에 외에 거의 모든 절에서 사용 가능 (특히 from, where에 많이 사용)
--  where 절인 경우,
--  1) 단일 행 연산자 =, >, <, >=, <=... 
    
    
SELECT 
    CONCAT(a.first_name, ' ', a.last_name), b.salary
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND b.salary < (SELECT 
            AVG(salary)
        FROM
            salaries
        WHERE
            to_date = '9999-01-01');
                
-- 실습 2 현재 가장적은 평균 급여를 받고 있는 직책에해서 평균 급여를
-- 구하세요
SELECT 
    b.title, AVG(a.salary)
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
ORDER BY AVG(a.salary) ASC
LIMIT 0 , 1;-- top과 동일

SELECT 
    b.title, AVG(a.salary)
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
HAVING ROUND(AVG(a.salary)) = (SELECT 
        ROUND(AVG(a.salary))
    FROM
        salaries a,
        titles b
    WHERE
        a.emp_no = b.emp_no
            AND a.to_date = '9999-01-01'
            AND b.to_date = '9999-01-01'
    GROUP BY b.title
    ORDER BY AVG(a.salary) ASC
    LIMIT 0 , 1);-- top과 동일


SELECT 
    MIN(a.avg_salary)
FROM
    (SELECT 
        ROUND(AVG(a.salary)) AS avg_salary
    FROM
        salaries a, titles b
    WHERE
        a.emp_no = b.emp_no
            AND a.to_date = '9999-01-01'
            AND b.to_date = '9999-01-01'
    GROUP BY b.title) a;


-- 3. join으로만

SELECT 
    ROUND(AVG(a.salary))
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
ORDER BY AVG(a.salary) ASC
LIMIT 0 , 1;
    
    
--  where 절인 경우,
--  2) 복수 행 연산자 in , any , all , not in
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS '이름'
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND salary > 50000;

-- 2) 서브쿼리 (in)
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS '이름'
FROM
    employees a
WHERE
    a.emp_no IN (SELECT 
            emp_no, salary
        FROM
            salaries
        WHERE
            to_date = '9999-01-01'
                AND salary > 50000);
                    
-- 3) =any
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS '이름'
FROM
    employees a
WHERE
    a.emp_no = ANY (SELECT 
            emp_no, salary
        FROM
            salaries
        WHERE
            to_date = '9999-01-01'
                AND salary > 50000);
                    
                    
-- 2) 각 부서별로 최고 월급을 받는 직원의 이름과 월급
-- dept_no, first_name, last_name
SELECT 
    c.dept_no, b.first_name, a.max_salary
FROM
    (SELECT 
        MAX(a.salary) AS max_salary, a.emp_no
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
        AND c.emp_no = a.emp_no;


-- --------------------------------------
SELECT 
    a.first_name, c.dept_no, b.salary
FROM
    employees a,
    salaries b,
    dept_emp c
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        and (c.dept_no, b.salary) =any (SELECT 
    a.first_name, c.dept_no, b.salary
FROM
    employees a,
    salaries b,
    dept_emp c
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
GROUP BY c.dept_no);


-- where절 서브쿼리
SELECT 
    a.first_name, c.dept_no, b.salary
FROM
    employees a,
    salaries b,
    dept_emp c
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
GROUP BY c.dept_no;



-- 방법 2
SELECT 
    a.first_name, c.dept_no, d.max_salary
FROM
    employees a,
    salaries b,
    dept_emp c,
    (SELECT 
		c.dept_no, max(b.salary) as max_salary
FROM
    employees a,
    salaries b,
    dept_emp c
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
GROUP BY c.dept_no) d
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        and c.dept_no = d.dept_no
        and b.salary = d.max_salary
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01';
        


select *,(select now()) from employees;




-- DML


