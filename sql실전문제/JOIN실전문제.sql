
-- 1. employees ���̺�� departments ���̺��� inner join�Ͽ�
-- ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.

SELECT
 a.employee_id, a.first_name, a.last_name, a.department_id, b.department_name
FROM employees A --department_id
INNER JOIN departments B -- department_id
ON a.department_id = b.department_id
;
SELECT * FROM employees;

-- 2. employees���̺�� departments���̺��� natural join�Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.

SELECT
 a.employee_id, a.first_name, a.last_name, department_id, b.department_name
FROM employees A --department_id
NATURAL JOIN departments B -- department_id // 
-- employees�� department �̸��� ������ Ÿ���� ���� Į���� 2�� �̴�. ��Ī ������ �߰��Ǿ
-- 106���� �ƴ϶� 32���� ��ȸ�ȴ�.

;

SELECT * FROM departments;

-- 3. employees���̺�� departments���̺��� using���� ����Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.

SELECT
 a.employee_id, a.first_name, a.last_name, department_id, b.department_name
FROM employees A --department_id
INNer JOIN departments B -- department_id
USING(department_id)
;


-- 4. employees���̺�� departments���̺�� locations ���̺��� 
--    join�Ͽ� employee_id, first_name, department_name, city�� ��ȸ�ϼ���

SELECT
 a.employee_id, a.first_name, b.department_name, c.city
FROM employees A --department_id
INNer JOIN departments B -- department_id
USING(department_id)
INNER JOIN locations C
ON b.location_id = c.location_id
;

SELECT * FROM locations;
SELECT * FROM employees;