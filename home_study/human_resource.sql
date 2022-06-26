
-- 1. employees ���̺�� departments ���̺��� inner join�Ͽ�
-- ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.
select

a.first_name, a.last_name, a.department_id, b.department_name

from employees a
inner join departments b
on a.department_id = b.department_id
;


SELECT * FROM employees;

-- 2. employees���̺�� departments���̺��� natural join�Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.

select

a.first_name, a.last_name, department_id, b.department_name, manager_id

from employees a
natural join departments b
order by department_id
;


-- 3. employees���̺�� departments���̺��� using���� ����Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.

select * from departments order by department_id;
select * from employees order by department_id, manager_id;

select

a.first_name, a.last_name, department_id, b.department_name

from employees a
inner join departments b
USING(department_id)
;


-- 4. employees���̺�� departments���̺�� locations ���̺��� 
--    join�Ͽ� employee_id, first_name, department_name, city�� ��ȸ�ϼ���
select * from locations;

select

a.first_name, a.last_name, a.department_id, b.department_name ,c.city
from employees a
inner join departments b
on a.department_id = b.department_id
inner join locations c
on c.location_id = b.location_id
;

