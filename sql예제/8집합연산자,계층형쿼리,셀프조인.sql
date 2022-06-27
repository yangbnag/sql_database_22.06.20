
-- ���� ������
-- ## UNION
-- 1. ������ ������ �ǹ��Դϴ�.
-- 2. ù��° ������ �ι�° ������ �ߺ������� �ѹ��� �����ݴϴ�.
-- 3. ù��° ������ ���� ������ Ÿ���� �ι�° ������ ������ Ÿ�԰� �����ؾ� ��.
-- 4. �ڵ����� ������ �Ͼ (ù��° �÷� �������� �⺻��)

SELECT
  emp_no,emp_nm, birth_de 
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT
  emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '1970101' AND '19791231'
;

-- ======

SELECT
  emp_nm, birth_de 
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT
  emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '1970101' AND '19791231'
-- 70��� ��� �� �̰����� �ߺ��� �Ǿ��ִ�.
-- �����ȣ�� �и� �ϴٰ� �����ȣ�� ���� UNION �����ϴ� �ߺ��� �̰��� �ϳ��� ������.
-- ������ ù��° �÷� �������� �Ǿ���.
;

SELECT
  emp_nm EN, birth_de BD -- ��Ī�� ���� UNION �ϸ�?
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT
  emp_nm EN2, birth_de BD2
FROM tb_emp
WHERE birth_de BETWEEN '1970101' AND '19791231'
ORDER BY BD DESC -- �ڵ����� : ù���� ������ / �ٸ��� �����ϰ� ������ UNION ������ ������ �ۼ�
;

-- ��Ī�� ���� ������ �÷������� �����µ� ��Ī�� �ִ� ��� ���� �ִ� ��Ī�� ����.


-- ## UNION ALL
-- 1. UNION�� ���� �� ���̺�� �������� ���ļ� �����ݴϴ�.
-- 2. UNION���� �޸� �ߺ��� �����͵� �ѹ� �� �����ݴϴ�.
-- 3. �ڵ� ���� ����� �������� �ʾ� ���ɻ� �����մϴ�.

SELECT
  emp_no,emp_nm, birth_de 
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL -- UNION�� �޸� ������ ���� �ʾҴ�.
SELECT
  emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '1970101' AND '19791231'
;

SELECT
  emp_nm, birth_de 
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL -- �ߺ� ���Ű� ���� �ʾҰ�, ���ĵ� ���� �ʾҴ�.
SELECT
  emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '1970101' AND '19791231'
;

-- ===

-- ## INTERSECT
-- 1. ù��° ������ �ι�° �������� �ߺ��� �ุ�� ����մϴ�.
-- 2. �������� �ǹ��Դϴ�.

SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE C.certi_nm = 'SQLD'
INTERSECT
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%����%';


SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%����%'
    AND C.certi_nm = 'SQLD'
;

-- ## MINUS(EXCEPT) 
-- 1. �ι�° �������� ���� ù��° �������� �ִ� �����͸� �����ݴϴ�.
-- 2. �������� �����Դϴ�.

SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100001'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100004'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE sex_cd = '1'
;

-- ========
-- ������ ����
-- START WITH : ������ ù �ܰ踦 ��� ������ ������ ���� ����
-- CONNECT BY : ��������� ���� © ���ΰ�
  -- [ �θ𿡼� �ڽ����� ���� : ������ Ž�� // �ڽĿ��� �θ�� : ������ Ž�� ]
  -- CONNECT BY PRIOR �ڽ� = �θ� -> ������ Ž��
  -- CNONECT BY �ڽ� = PRIOOR �θ� -> ������ Ž��
  
  -- ORDER SILBINGS BY : ���� ���������� ������ ����.
  -- EX) ������ ������ ��� �������� �����ϰ� �ʹ�.

SELECT 
    LEVEL AS LVL,
    LPAD(' ', 44*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no
ORDER SIBLINGS BY A.emp_no DESC;




SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    a.direct_manager_emp_no
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.emp_no = '1000000037'
CONNECT BY A.emp_no = PRIOR A.direct_manager_emp_no;

 -- # SELF JOIN
 -- 1. �ϳ��� ���̺��� �ڱ� �ڽ��� ���̺��� �����ϴ� ����Դϴ�.
 -- 2. �ڱ� �ڽ� ���̺��� pk�� fk�� �������� �մϴ�.
 
 SELECT 
    A.emp_no 
  , A.emp_nm "��� �̸�"
  , A.addr "��� �ּ�"
  , A.direct_manager_emp_no
  , B.emp_nm "���� ��� �����"
  , B.addr "���� ����� �ּ�"
 FROM tb_emp A
 LEFT JOIN tb_emp B
 ON A.direct_manager_emp_no = b.emp_no
 ORDER BY emp_no 
;
   -- �̰���� ������ ��ȣ�� ���´�. 
   -- �������� ��ȣ�� �Բ� ����� �̸��� �ּҵ� �˰� ������.
SELECT 
    A.emp_no, A.emp_nm, A.direct_manager_emp_no
FROM tb_emp A
ORDER BY A.emp_no
;

SELECT 
    B.emp_no, B.emp_nm, B.direct_manager_emp_no
FROM tb_emp B
ORDER BY B.emp_no
;

-- ���� fk �����ϱ�
ALTER TABLE tb_emp
ADD CONSTRAINT fk_direct_emp_no
FOREIGN KEY (direct_manager_emp_no)
REFERENCES tb_emp (emp_no);


