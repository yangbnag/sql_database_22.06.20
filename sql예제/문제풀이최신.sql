
-- ���̺� ����
CREATE TABLE tb_emp_copy
AS
SELECT emp_no, emp_nm, addr
FROM tb_emp;

SELECT
    * FROM tb_emp_copy; -- ���� ���̺��� ���ϴ� �縸ŭ�� ����
    
    
-- �� ����
CREATE VIEW tb_emp_view
AS
SELECT emp_no, emp_nm, addr, dept_cd
FROM tb_emp;

SELECT * FROM tb_emp_view; -- ���̺�� �ٸ��� ������ ���� �ʴ� ��