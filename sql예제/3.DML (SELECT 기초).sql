
-- SELECT �⺻
SELECT 
    emp_no, emp_nm
FROM tb_emp;

SELECT 
    certi_cd, certi_nm
FROM tb_certi;

SELECT 
    *
FROM tb_dept;

SELECT 
    emp_nm, emp_no
FROM tb_emp;

-- DISTINCT : �ߺ����� �����ϰ� ��ȸ
SELECT ALL 
    issue_insti_nm
FROM tb_certi;

SELECT DISTINCT 
    issue_insti_nm
FROM tb_certi;

SELECT DISTINCT 
    certi_nm, issue_insti_nm
FROM tb_certi;

-- �� ��Ī (column alias) ����
SELECT 
    certi_cd AS "�ڰ��� �ڵ�"
    , certi_nm AS �ڰ�����
    , issue_insti_nm �߱ޱ����
FROM tb_certi;


-- ���ڿ� ���� ������ ||
-- ex) SQLD (100002) - �ѱ������������
SELECT 
    certi_nm || '(' || certi_cd || ') - ' || issue_insti_nm AS "�ڰ��� ����"
FROM tb_certi;

-- ���� ���̺� (dual) : �ܼ� �������� ��ȸ�� �� ���
SELECT 
    3 * 7 AS "���� ���"
FROM dual;

SELECT 
    SYSDATE AS "���� ��¥"
FROM dual;