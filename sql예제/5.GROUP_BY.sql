
SELECT DISTINCT
 SUBSTR(emp_nm,1,1)  ����
FROM tb_emp;

 -- ���� �Լ�(������ �Լ�)
 -- : ���� ���� ��� �Լ��� ����
 
 SELECT * FROM tb_sal_his;

 -- 1�� 2019.02.25�� 5�� ����� 5,620,000 �� �����ߴ�.
 
 -- 5�� ����� ���� ���� ���� Ȯ��
 SELECT * FROM tb_sal_his 
 WHERE emp_no = '1000000005';
 
 -- 5�� ����� �� ���� ���ɾװ� ������ ��վ�, ���� ���� ���ް� ���� ���� ����
 -- �׸��� 5�� ����Ӹ� �ƴ϶� ��ü ����� ���ؼ� ���� �����͵��� �����ϰ� ������..
 
 SELECT
 
    SUM(pay_amt) "���� �Ѿ�" -- ������ �Լ��̴�.
   ,SUM(pay_amt) "��� ���޾�" -- GROUP BY�� �ұ׷�ȭ ���� ������ ���� �Լ��� ��ü����� �������� �����Ѵ�.
   ,COUNT(pay_amt) "���� Ƚ��"
   -- ,emp_no -- ��� ��Ī�� ���� �ʴ´�. 984���� �׷��̴�.
   
 FROM tb_sal_his
 ;
 
SELECT * FROM tb_emp; -- 41��
 
 SELECT
     COUNT(emp_nm) "�� �����" -- �ߺ��� �ǳʶ��� �ʴ´�.
     ,MAX(birth_de) "�ֿ������� ����" -- 41���� ���� �߿� �ּҰ� 1��
     ,MIN(birth_de) "�ֿ������� ����" -- 41���� ���� �߿��� �ִ� 1��
     -- �׷�ȭ ���� ������ ��ü�� �������� �����Լ��� ����ȴ�.
     
     ,COUNT(direct_manager_emp_no) 
     ,COUNT(*) ����
      -- ��� ���� �Լ��� Ư�� �÷��̳� ǥ������ ������ NULL�� ���� �ʴ´�.
      -- ���� COUNT(*)�� NULL�� �� ����. ����!!
 FROM tb_emp;

-- ==========================================================================--

-- GROUP BY : ������ �÷����� �ұ׷�ȭ �� �� �����Լ� ����
-- �μ����� ���� ������ �������, �������� ������� �μ��� �� ��� ���� ��ȸ

SELECT * FROM tb_emp
ORDER BY dept_cd
; -- �׷� �ڵ庰�� ���� �� �Ʒ� ������ ��ȸ �ؾ��� ������ ���ϴ� ��� ��ȸ �Ҽ� �ִ�.

SELECT
 -- emp_nm -- ����� �̸��� 41�� �̹Ƿ� 14���� 
        --�׷����� ��ȸ�� �����Ϳ� ��ġ���� �ʾ� ��ȸ �Ұ���
        
  dept_cd �μ��ڵ� -- �׷� ���̿��� ������ �÷��� ��ȸ ����      
 ,MAX(birth_de) �ֿ�����
 ,MIN(birth_de) �ֿ�����
 ,COUNT(emp_no) ������
FROM tb_emp
GROUP BY dept_cd
ORDER BY dept_cd
;

 -- ����� ���� �޿����ɾ� ��ȸ
SELECT 
  emp_no
  ,SUM(pay_amt) "���� ���ɾ�"

FROM tb_sal_his
GROUP BY emp_no -- group by�� where�� �ڿ� order by ���� ��ġ �ؾ���.
ORDER BY emp_no
;



-- ������� �޿��� ���� ���� �޾��� ��, ���� ���� �޾�����, ��������� �� �޾Ҵ��� ��ȸ
SELECT
  emp_no
  , TO_CHAR(MAX(pay_amt),'L999,999,999') "�ְ� ���ɾ�"
  , TO_CHAR(MIN(pay_amt),'L999,999,999') "���� ���ɾ�"
  , TO_CHAR(ROUND(AVG(pay_amt),2),'L999,999,999.99' )"��� ���ɾ�" 
  -- ��踦 �� �����͸� ����ȭ �Լ��� �����Ű�� ���� ����

FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no;

SELECT * FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
ORDER BY emp_no, pay_de
;


-- 2019�⿡ ������� �޿��� ���� ���� �޾��� ��, ���� ���� �޾�����, ��������� �� �޾Ҵ��� ��ȸ
 -- �׷�ȭ �ϱ����� ������ �������� ���� �ؾ� �Ѵ�.
 -- WHERE�� �׷�ȭ �ϱ����� ������ �����س��´�.
SELECT
  emp_no
  , TO_CHAR(MAX(pay_amt),'L999,999,999') "�ְ� ���ɾ�"
  , TO_CHAR(MIN(pay_amt),'L999,999,999') "���� ���ɾ�"
  , TO_CHAR(ROUND(AVG(pay_amt),2),'L999,999,999.99' )"��� ���ɾ�" 
  , TO_CHAR(SUM(pay_amt),'L999,999,999') "2019�� ����"
  -- ��踦 �� �����͸� ����ȭ �Լ��� �����Ű�� ���� ����

FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
ORDER BY emp_no
;

-- ============================ �������

-- HAVING : �׷�ȭ�� ������� ������ �ɾ� �� ���� ����

-- �μ����� ���� ������ �������, �������� �������, �μ��� �� ��� ���� ��ȸ
-- �׷��� �μ��� ����� 1���� �μ��� ������ ��ȸȭ�� ���� ����.
-- WHERE ���� ORDER BY ������ HAVING�� �ۼ�

SELECT
  dept_cd �μ��ڵ� 
 ,MAX(birth_de) �ֿ�����
 ,MIN(birth_de) �ֿ�����
 ,COUNT(emp_no) ������
FROM tb_emp
GROUP BY dept_cd
HAVING COUNT(emp_no)>1 --������� 1���ٴ� Ŀ�ߵǿ�~
ORDER BY dept_cd
;

-- ������� �޿��� ���� ���� �޾��� ��, ���� ���� �޾�����, ��������� �� �޾Ҵ��� ��ȸ
-- �׷�ȭ ���Ŀ� ��� �޿��� 450���� �̻��� ����� ��ȸ
SELECT
  emp_no "���"
  , TO_CHAR(MAX(pay_amt),'L999,999,999') "�ְ� ���ɾ�"
  , TO_CHAR(MIN(pay_amt),'L999,999,999') "���� ���ɾ�"
  , TO_CHAR(ROUND(AVG(pay_amt),2),'L999,999,999.99' )"��� ���ɾ�" 

FROM tb_sal_his
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no;

-- ������� 2019�� ��� ���ɾ��� 450���� �̻��� ����� 2019�� ���� ��ȸ
SELECT
  emp_no "���"
  , SUM(pay_amt)

FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no;

-- 
-- �׷�ȭ�� �Ҷ� �÷��� 2���̸�?
 SELECT
  emp_no
  ,sex_cd
  ,dept_cd
 FROM tb_emp
 ORDER BY dept_cd
 ;
SELECT
  
    dept_cd
    , COUNT(*)

FROM tb_emp
GROUP BY dept_cd, sex_cd 
ORDER BY dept_cd
;

--============ ���� ����

-- ORDER BY : ����
-- ASC : ������ ���� (�⺻��), DESC ������ ����
-- �׻� SELECT���� �� �������� ��ġ

SELECT
emp_no
,emp_nm
,addr
FROM tb_emp
ORDER BY  emp_nm DESC
;

SELECT
emp_no
,emp_nm
,dept_cd
FROM tb_emp
ORDER BY  dept_cd,emp_nm DESC -- �μ��ڵ�� ���� + �μ������� emp_no�� ����
; 

SELECT
emp_no ��� -- 1 �÷� ��ȣ�� ���������� �� ����.
,emp_nm �̸� -- 2 
,addr �ּ� -- 3
FROM tb_emp
ORDER BY 1 DESC, �̸� -- ���Ľ� ��Ī ��� ����
;


-- ������� 2019�� ��� ���ɾ��� 450���� �̻��� ����� 2019�� ���� ��ȸ
SELECT
  emp_no "���"
  , SUM(pay_amt) ����

FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY ���� DESC
;
 
 