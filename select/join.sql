-- join

select * from employee;
select * from department;

-- 1. 데이터 넣기
insert into department values(null, '총무팀');
insert into department values(null, '영업팀');
insert into department values(null, '인사팀');
insert into department values(null, '개발팀');

insert into employee values(null, '둘리',1);
insert into employee values(null, '마이콜',2);
insert into employee values(null, '또치',3);
insert into employee values(null, '진국',null);


-- inner join

-- 1. 조심 : cartisian product(m x n)
select * 
from employee,department;

-- 2. equi join
select a.no, a.name , b.name
	from employee a,department b
where a.department_no = b.no;

-- 3.join ~ on
select a.no, a.name , b.name
	from employee a
    join department b
    on a.department_no = b.no;
    
    
-- 4. natural join
select  * 
from employee    
    
    
    
    
-- outer join
-- 1.left join
select a.no, a.name , ifnull(b.name, '사장님') 
	from employee a 
left join department b
    on a.department_no = b.no;

-- 2.right join
select a.no, ifnull(a.name,'채용요망'), b.name 
	from employee a 
left join department b
    on a.department_no = b.no;
    
-- 3.full join
-- mysql / mariadb지원 안함
-- select a.no, a.name, b.name 
-- 	from employee a 
-- left join department b
--     on a.department_no = b.no;





