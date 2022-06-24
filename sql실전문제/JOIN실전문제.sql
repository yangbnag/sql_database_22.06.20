
-- 1. employees 테이블과 departments 테이블을 inner join하여
-- 사번, first_name, last_name, department_id, department_name을 조회하세요.

SELECT
 a.employee_id, a.first_name, a.last_name, a.department_id, b.department_name
FROM employees A --department_id
INNER JOIN departments B -- department_id
ON a.department_id = b.department_id
;
SELECT * FROM employees;

-- 2. employees테이블과 departments테이블을 natural join하여
--    사번, first_name, last_name, department_id, department_name을 조회하세요.

SELECT
 a.employee_id, a.first_name, a.last_name, department_id, b.department_name
FROM employees A --department_id
NATURAL JOIN departments B -- department_id // 
-- employees와 department 이름과 데이터 타입이 같은 칼럼이 2개 이다. 매칭 조건이 추가되어서
-- 106건이 아니라 32건이 조회된다.

;

SELECT * FROM departments;

-- 3. employees테이블과 departments테이블을 using절을 사용하여
--    사번, first_name, last_name, department_id, department_name을 조회하세요.

SELECT
 a.employee_id, a.first_name, a.last_name, department_id, b.department_name
FROM employees A --department_id
INNer JOIN departments B -- department_id
USING(department_id)
;


-- 4. employees테이블과 departments테이블과 locations 테이블을 
--    join하여 employee_id, first_name, department_name, city를 조회하세요

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