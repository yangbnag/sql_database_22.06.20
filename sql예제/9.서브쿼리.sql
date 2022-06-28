
-- ��ȯ���¿� ���� �������� �з�
-- # ���� �� ���� ����
-- ���������� �������� �׻� 1�� ������ ���������� �ǹ��Ѵ�.

-- �μ��ڵ尡 100004���� �μ��� ������� ��ȸ
SELECT
emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
;

-- ����̸��� �̳����� ����� ���� �ִ� �μ��� ������� ��ȸ
-- 1. �̳��� ���� �ִ� �μ��� �ڵ� Ȯ��
SELECT
dept_cd
FROM tb_emp
WHERE emp_nm = '�̳���';

-- 2.�̳��� ���� �ִ� �μ� �ڵ�� �μ� ��� ���� ��ȸ
SELECT
emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
;

-- ���� ������ �̿��� 1, 2�� ������ �ϳ��� 
-- �������� ���� ��ų �� �ִ�.

-- ������ �񱳿����ڴ� ������ ���������� ���ؾ� ��.
-- (=, <>, >, >=, <, <=)
SELECT
emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd FROM tb_emp WHERE emp_nm = '�̳���')
;

-- 20200525�� ���� �޿��� 
-- ȸ����ü�� 20200525�� ��ü ��� �޿����� ���� 
-- ������� ���� ��ȸ (���, �̸�, �޿�������, �����޿��׼�)

-- [ 20200525 ��¥�� ��ü��� �޿��� ���ϰ�,��պ��� ���� ������� ������ ��ȸ]

SELECT
 A.emp_no, A.emp_nm, B.pay_de, B.pay_amt  
FROM tb_emp A , tb_sal_his B
WHERE A.emp_no = B.emp_no
AND B.pay_de = '20200525'
AND B.pay_amt >= (SELECT AVG(pay_amt) 
                  FROM tb_sal_his 
                  WHERE pay_de = '20200525')
ORDER BY A.emp_no, B.pay_de
;

SELECT
 A.emp_no, A.emp_nm, B.pay_de, B.pay_amt
FROM tb_emp A
JOIN tb_sal_his B
ON A.emp_no = B.emp_no
WHERE B.pay_de = '20200525'
 AND B.pay_amt >= (SELECT AVG(pay_amt)
                   FROM tb_sal_his
                   WHERE pay_de = '20200525')
ORDER BY A.emp_no, B.pay_de
;
-- ������ ��������
-- �� ���� ���� ���� �̴�.
-- ���������� Į���� �����ٴ� �Ŵ� ������ 
-- FROM tb_sal_his => B.tb_sal_his ó�� ���ο� �ִ� B�� A�� ���� ���� ���Ѵ�.

-- ȸ�� ��ü 20200525 �޿����
SELECT AVG(pay_amt)
FROM tb_sal_his
WHERE pay_de = '20200525'
;

-- # ������ ��������
-- ���������� ��ȸ �Ǽ��� 0�� �̻��� ��

-- ## ������ ������
-- 1. IN : ���������� �������� ���������� ����߿� �ϳ��� ��ġ�ϸ� ��
-- ex) salary > IN (200, 300, 400)  
    --          250  -> 200, ,300, 400 �߿� �����Ƿ� false
    
-- 2. ANY, SUM : ���������� �������� ���������� �˻���� �� �ϳ� �̻� ��ġ�ϸ� ��
--        ex) salary > ANY (200, 300, 400) = 200 �ʰ� 400 �̸� �� ��� ��    
    --          250  -> 200 ���� ũ�Ƿ� true 
    
-- 3. ALL : ���������� �������� ���������� �˻������ ��� ��ġ�ϸ� ��
--        ex) salary > ALL (200, 300, 400) 
        --     250    -> 200���ٴ� ũ���� 300, 400 ���ٴ� ũ�� �����Ƿ� false
        
-- 4. EXISTS : ���������� �������� ���������� ��� �� �����ϴ� ���� �ϳ��� �����ϸ� ��

-- �����༭������ ����) ������ ��ȸ �䱸����
-- �ѱ������ͺ��̽� ��������� �߱��� �ڰ����� ������ �ִ� 
-- ����� �����ȣ�� ����̸��� �ڰ��� ������ ��ȸ

SELECT
  A.emp_no, A.emp_nm, COUNT(b.certi_cd)
FROM tb_emp A, tb_emp_certi B
WHERE A.emp_no = B.emp_no 
AND B.certi_cd IN 
( 
SELECT certi_cd  
FROM tb_certi
WHERE tb_certi.issue_insti_nm = '�ѱ������ͺ��̽������')
GROUP BY A.emp_no, A.emp_nm
ORDER BY A.emp_no
;
    


SELECT
A.emp_no, A.emp_nm, COUNT(B.certi_cd) "�ڰ��� ����"
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
WHERE B.certi_cd 
= ANY-- ������ ���������� �ѱ������ͺ��̽�������� �ڰ��� �ڵ带 ���
(
SELECT certi_cd FROM tb_certi WHERE tb_certi.issue_insti_nm = '�ѱ������ͺ��̽������')
GROUP BY A.emp_no, A.emp_nm -- *�׷�������� ������� ���� �÷��� select ���� ���ü� ����.
ORDER BY A.emp_no
;

-- EXISTS�� : ���������� �������� ���������� ��� �� �����ϴ� ���� �ϳ��� �����ϸ� ��

-- �ּҰ� ������ �������� �ٹ��ϰ� �ִ� �μ������� ��ȸ (�μ��ڵ�, �μ���)

SELECT emp_no, emp_nm, addr, dept_cd FROM tb_emp WHERE addr LIKE '%����%';

SELECT dept_cd, dept_nm 
FROM tb_dept
WHERE dept_cd IN('100009', '100010');

-- ===
SELECT dept_cd, dept_nm 
FROM tb_dept
WHERE dept_cd IN(
SELECT dept_cd FROM tb_emp WHERE addr LIKE '%����%');

-- ===

SELECT dept_cd, dept_nm 
FROM tb_dept
WHERE EXISTS(
SELECT dept_cd FROM tb_emp WHERE addr LIKE '%����%');
-- ��Ī�Ǵ� ����� �ϳ��� ���� �� true�� ��ȯ�Ͽ� 
-- SELECT dept_cd, dept_nm �� ��� ��ȸ�� �Ѵ�.

SELECT A.dept_cd, A.dept_nm 
FROM tb_dept A
WHERE EXISTS(
             SELECT B.dept_cd 
             FROM tb_emp B 
             WHERE addr LIKE '%����%'
               AND A.dept_cd = B.dept_cd);

-- # ���� Į�� ���� ����
-- : ���������� �÷��� 2�� �̻��� ��������

-- �μ����� 2�� �̻��� �μ��߿��� �� �μ��� ���� �������� ����� �̸�
-- ������ϰ� �μ��ڵ带 ��ȸ

SELECT 
 A.emp_no, A.emp_nm, A.birth_de, A.dept_cd, b.dept_nm 
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = b.dept_cd
WHERE (A.dept_cd, A.Birth_de) IN (
           SELECT
           dept_cd, MIN(birth_de)
           FROM tb_emp
           GROUP BY dept_cd
           HAVING COUNT(*) >= 2 -- ����� 2�� �̻��� �μ� ��󳻱�
             )
ORDER BY A.emp_no
;

-- �ζ��� �� �������� (FROM���� ���� ��������)

-- �� ����� ����� �̸��� ��� �޿������� ��ȸ�ϰ� �ʹ�.

SELECT 
 A.emp_no, A.emp_nm, B.pay_avg
FROM tb_emp A, (
               SELECT
               emp_no,(AVG(pay_amt)) AS pay_avg
               FROM tb_sal_his
               GROUP BY emp_no) B
WHERE A.emp_no = B.emp_no
;

-- #��Į�� �������� (SELECT���� ���� ��������) 

-- ����� ���, �����, �μ���, �������, �����ڵ带 ��ȸ

SELECT 
  A.emp_no
  , A.emp_nm
  ,(SELECT B.dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm
  ,A.birth_de
  ,A.sex_cd
FROM tb_emp A
;



