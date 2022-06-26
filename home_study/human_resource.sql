
-- 1. employees 테이블과 departments 테이블을 inner join하여
-- 사번, first_name, last_name, department_id, department_name을 조회하세요.
select

a.first_name, a.last_name, a.department_id, b.department_name

from employees a
inner join departments b
on a.department_id = b.department_id
;


SELECT * FROM employees;

-- 2. employees테이블과 departments테이블을 natural join하여
--    사번, first_name, last_name, department_id, department_name을 조회하세요.

select

a.first_name, a.last_name, department_id, b.department_name, manager_id

from employees a
natural join departments b
order by department_id
;


-- 3. employees테이블과 departments테이블을 using절을 사용하여
--    사번, first_name, last_name, department_id, department_name을 조회하세요.

select * from departments order by department_id;
select * from employees order by department_id, manager_id;

select

a.first_name, a.last_name, department_id, b.department_name

from employees a
inner join departments b
USING(department_id)
;


-- 4. employees테이블과 departments테이블과 locations 테이블을 
--    join하여 employee_id, first_name, department_name, city를 조회하세요
select * from locations;

select

a.first_name, a.last_name, a.department_id, b.department_name ,c.city
from employees a
inner join departments b
on a.department_id = b.department_id
inner join locations c
on c.location_id = b.location_id
;

