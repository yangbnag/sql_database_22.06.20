
-- 테이블 복사
CREATE TABLE tb_emp_copy
AS
SELECT emp_no, emp_nm, addr
FROM tb_emp;

SELECT
    * FROM tb_emp_copy; -- 기존 테이블을 원하는 양만큼만 복사
    
    
-- 뷰 생성
CREATE VIEW tb_emp_view
AS
SELECT emp_no, emp_nm, addr, dept_cd
FROM tb_emp;

SELECT * FROM tb_emp_view; -- 테이블과 다르게 수정이 되지 않는 뷰