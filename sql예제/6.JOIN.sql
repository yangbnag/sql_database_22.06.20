
 -- ������� ���, �̸�, �ּ�, �μ���
 
 SELECT
  F.emp_no, F.emp_nm, F.addr, G.dept_nm
 FROM tb_emp F
 JOIN tb_dept G
 ON F.dept_cd = G.dept_cd
 ;
 
 -- ==================================== --
 -- ���� ���� �׽�Ʈ ������
CREATE TABLE TEST_A ( -- ��Ī �Խ��� ���̺�
    id NUMBER(10) PRIMARY KEY -- �Խ��� �۹�ȣ
    , content VARCHAR2(200) -- �Խù� ����
);

CREATE TABLE TEST_B ( -- ��Ī ��� ���̺�
    b_id NUMBER(10) PRIMARY KEY -- ��� ��ȣ
    , reply VARCHAR2(100)-- ��۹�ȣ
    , a_id NUMBER(10) -- FK ���� // ���� �� ��ȣ
);

INSERT INTO TEST_A  VALUES (1, 'aaa');
INSERT INTO TEST_A  VALUES (2, 'bbb');
INSERT INTO TEST_A  VALUES (3, 'ccc');

INSERT INTO TEST_B  VALUES (1, '������', 1);
INSERT INTO TEST_B  VALUES (2, '������', 1);
INSERT INTO TEST_B  VALUES (3, '������', 2);
INSERT INTO TEST_B  VALUES (4, '������', 3);
COMMIT;

SELECT * FROM test_a;
SELECT * FROM test_b;

-- ���� �ϱ�
-- # �⺻ ���� [Cartesion product / CROSS JOIN]
SELECT
*
FROM test_a, test_b 
-- ���� 12�� / �÷��� 5��
-- ���� ������ �������� ������ test_a �� test_b�� ��� ���� ���յȴ�.
-- Cartesion product / CROSS JOIN a�� 3���� �� / b�� 4���� �� 3*4 = 12���� ��ȸ�ȴ�.
;

-- # INNER JOIN [EQUI JOIN�� �� ����]  
-- �������ǿ� ���� ��Ī�Ǵ� �� ���� //[WHERE �������� JOIN]
SELECT
*
FROM test_a, test_b 
WHERE test_a.id = test_b.a_id 
-- test_a �� id��ȣ�� test_b�� a_id�� ��ȣ�� ��ġ�ϴ°Ÿ� ��ȸ �Ϸ��� �Ѵ�.
;


-- 5�� �÷��� �� ���� ���� �ʴ�.
SELECT
 A.id, test_A.content, B.reply 
 -- �Ҽ� ���̺���� ����ؾ� �Ѵ�.
 -- ���� �����̴�. �� ���̺��� �Ȱ��� �÷��� ���� ������ �������� ���� �ƴ� ����.
 
FROM test_a A, test_b B -- ���̺� ��Ī�� �༭ ������ ���ϰ� �Ҽ� �ִ�.
WHERE test_a.id = test_b.a_id 

;

-- �ڰ��� ���� ���̺�
SELECT * FROM tb_emp_certi; -- 123�� = EMP_NO | CERTI_SN | CERTI_CD | ACQU_DE 
SELECT * FROM tb_certi; -- 20�� = CERTI_CD | CDERTI_NM | |ISSUE_INSTI_NM

-- ����� ��� ��ȣ�� ��� �ڰ��� ���� ��ȸ�ϰ� �ʹ�.
-- tb_emp_certi ���̺����� ��� �̸��� ���Ѵ�.
-- tb_certi ���̺����� �ڰ��� �̸��� ���Ѵ�.

SELECT
 A.emp_no, B.certi_nm
FROM tb_emp_certi A, tb_certi B 
WHERE A.certi_cd = B.certi_cd -- where���� certi_cd ��ġ�ϴ� �ڷḸ ����
ORDER BY A.emp_no, B.certi_cd
-- CROSS JOIN �� �Ǿ 123�� * 20�� = 2460���� ��ȸ�Ǿ���.
;

-- ����� �����ȣ�� ����̸��� ��� �ڰ������� ��ȸ�ϰ� ����
SELECT * FROM tb_emp_certi; -- 123�� = EMP_NO | CERTI_SN | CERTI_CD | ACQU_DE 
SELECT * FROM tb_certi; -- 20�� = CERTI_CD | CDERTI_NM | |ISSUE_INSTI_NM
SELECT * FROM tb_emp; -- 41�� = 
-- EMP_NO | EMP_NM | BIRTH_DE | LUNAR_YN | SEX_CD | ADDR 
-- | TEL_NO | FINAL_EDU_SE_CD | SAL_TRANS_BANK_CD | DIRECT_MANAGER_EMP_NO | DEPT_CD
-- .. �ڰ��� ���õ� ������ �÷��� ����

SELECT
 A.emp_no, c.emp_nm, B.certi_nm
FROM tb_emp_certi A, tb_certi B, tb_emp C
WHERE A.certi_cd = B.certi_cd 
 AND A.emp_no = C.emp_no -- certi_cd �� �����ȣ�� tb_emp�� �����ȣ ��ġ ���� �߰�
ORDER BY A.emp_no, B.certi_cd
;

-- ����� �����ȣ�� ����̸��� �μ��̸��� ��� �ڰ������� ��ȸ�ϰ� ����.

SELECT
 A.emp_no, c.emp_nm, D.dept_nm, B.certi_nm
FROM tb_emp_certi A, tb_certi B, tb_emp C, tb_dept D -- �μ����̺� �����߰�
WHERE A.certi_cd = B.certi_cd 
 AND A.emp_no = C.emp_no 
 AND C.dept_cd = D.dept_cd -- �μ��ڵ� ��ġ ���� �߰�
ORDER BY A.emp_no, B.certi_cd
;

-- �μ��� �� �ڰ��� ��� ���� ��ȸ
SELECT
 B.dept_cd, C.dept_nm, COUNT(A.certi_cd) "�μ��� �ڰ��� ��"
FROM tb_emp_certi A, tb_emp B, tb_dept C
WHERE A.emp_no = B.emp_no
AND B.dept_cd = C.dept_cd
GROUP BY b.dept_cd, c.dept_nm
ORDER BY b.dept_cd
;

-- # INNER JOIN 
-- 1. 2�� �̻��� ���̺��� ����� �÷��� ���� �������� ���յǴ� ���α���Դϴ�.
-- 2. WHERE���� ���� �÷����� �������(=)�� ���� ���ε˴ϴ�.

-- (���νÿ� ���) ����� �����ȣ, �����, �ּ�, �μ��ڵ�, �μ����� ��ȸ�ϰ� �ʹ�.
SELECT 
  A.emp_no
  , A.emp_nm
  , A.addr
  , A.dept_cd
  , B.dept_nm
FROM tb_emp A, tb_dept B
WHERE A.addr LIKE '%����%' -- ����Ŭ ���� ����
 AND A.dept_cd = B.dept_cd
 AND A.emp_nm LIKE '��%' -- �达�� ����� ����
ORDER BY A.emp_no
;
-- �� ������ �������� ���� ���̺��� ���������� ���� ������ ��������.
-- ���� ������ ���̺�(N) �϶� N-1 �̴�. 


--============= ������� 

-- === ���⼭ ���� [�����ͺ��̽�_SQL�⺻(JOIN)_����2_ 22.06.24(day05)]


-- JOIN ON (ANSI ǥ�� ����)
-- 1. FROM�� ��, WHERE�� ��
-- 2. JOIN Ű���� �ڿ��� ������ ���̺���� ���
-- 3. ON Ű���� �ڿ��� ���� ������ ���
-- 4. ���� ���� ������(ON��) �Ϲ� ���� ������(WHERE)�� �и��ؼ� �ۼ��ϴ� ���
-- 5. ON���� �̿��ϸ� JOIN ������ �������̳� ���������� ���� �߰� ������ ����

SELECT 
  A.emp_no  , A.emp_nm  , A.addr  , A.dept_cd  , B.dept_nm
FROM tb_emp A 
JOIN tb_dept B -- 1�� 2��
ON A.dept_cd = B.dept_cd -- 3�� -- ON���� JOIN ������ �ٸ� WHERE ���ǰ� ���� �Ҽ� �ִ�.
WHERE A.addr LIKE '%����%' 
 AND A.emp_nm LIKE '��%' 
ORDER BY A.emp_no
;

-- 1980���� ������� ���, �����, �μ���, �ڰ�����, ������ڸ� ��ȸ
SELECT * FROM tb_emp; -- ���, �����
SELECT * FROM tb_dept; -- �μ���
SELECT * FROM tb_certi; -- �ڰ�����
SELECT * FROM tb_emp_certi; -- �������

SELECT 
 E.emp_no, E.emp_nm, D.dept_nm, C.certi, ec.acqu_de
-- FROM tb_emp E, tb_dept D, tb_emp_certi EC, tb_certi C
FROM tb_emp E, tb_dept D, tb_emp_certi EC, tb_certi C
WHERE E.dept_cd = D.tb_dept_cd
AND EC.certi_cd = C.certi_cd
AND E.emp_no = EC.emp_no
AND E.birth_de BETWEEN '19800101' AND '19891231'
;

-- 1980���� ������� ���, �����, �μ���, �ڰ�����, ������ڸ� ��ȸ
SELECT
    E.emp_no, E.emp_nm, D.dept_nm, C.certi_nm, EC.acqu_de
FROM tb_emp E
JOIN tb_dept D
ON E.dept_cd = D.dept_cd
JOIN tb_emp_certi EC
ON E.emp_no = EC.emp_no
JOIN tb_certi C
ON  EC.certi_cd = C.certi_cd

WHERE E.birth_de BETWEEN '19800101' AND '19891231'
;

-- JOIN ON �������� ī�׽þ� �� �����
SELECT
*
FROM  test_a A, test_b B
;

SELECT
*
FROM  test_a A 
CROSS JOIN test_b B
;

-- # NATURAL JOIN
-- 1.NATURAL JOIN�� ������ �̸��� ���� �÷��鿡 ���� �ڵ����� ���������� �����ϴ� ����Դϴ�.
-- 2.��, �ڵ����� 2�� �̻��� ���̺��� �����̸��� ���� �÷��� ã�� INNER������ �����մϴ�.
-- 3.�� �� ���εǴ� ���� �̸��� �÷��� ������ Ÿ���� ���ƾ� �ϸ�,
-- ALIAS�� ���̺���� �ڵ� ���� �÷� �տ� ǥ���ϸ� �ȵ˴ϴ�.
-- 4.SELECT * ������ ����ϸ�, ���� �÷��� ���տ��� �ѹ��� ǥ��˴ϴ�.
-- 5. ���� �÷��� n�� �̻��̸� ���� ������ n���� ó���˴ϴ�.

-- ��� ���̺�� �μ� ���̺��� ���� (���, �����, �μ��ڵ�, �μ���)
SELECT

 a.emp_no, a.emp_nm, 
  dept_cd, --b.dept_cd, : natural join�� 3�� ��Ģ 
 b.dept_nm

FROM tb_emp A
NATURAL JOIN tb_dept B;
--ON A.dept_cd = B.dept_cd 
-- pk�� fk�� �̸��� �Ȱ��� ������ �ڵ嵵 �Ȱ���. (natural join ���� ����)


-- # USING�� ����
--  [natural ���ο��� �Ҽ� ���� ���� ���� ����]
-- 1. NATURAL ���ο����� �ڵ����� �̸��� Ÿ���� ��ġ�ϴ� ��� �÷��� ����
--    ������ �Ͼ���� USING�� ����ϸ� ���ϴ� �÷��� ���ؼ��� ������ ������
--    �ο��� �� �ֽ��ϴ�.
-- 2. USING�������� ���� �÷��� ���� ALIAS�� ���̺���� ǥ���Ͻø� �ȵ˴ϴ�.

SELECT

 a.emp_no, a.emp_nm, 
  dept_cd, --b.dept_cd, : natural join�� 3�� ��Ģ�� �����ϰ� using������ ����ȴ�.
 b.dept_nm

FROM tb_emp A
INNER JOIN tb_dept B
USING (dept_cd);

-- # INNER JOIN�� SELECT * �� ��� 
-- �� �ߺ� ���� ���� . DEPT_CD �� DEPT_CD1 �÷� ����
-- 15���� �÷� ����

SELECT
*
FROM tb_emp A
INNER JOIN tb_dept B
ON A.dept_cd = B.dept_cd;

-- # NATURAL JOIN�� SELECT * �� ���
-- 14���� �÷� ���� �ߺ� �Ǵ� dept_cd�� �ϳ��� ����.
SELECT
 *
FROM tb_emp A
NATURAL JOIN tb_dept B;

-- # USING�� JOIN�� SELECT * �� ���
-- 14���� �÷� ���� �ߺ� �Ǵ� dept_cd�� �ϳ��� ����.
SELECT
*
FROM tb_emp A
INNER JOIN tb_dept B
USING (dept_cd);



 
