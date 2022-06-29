
-- 9�� ����
DROP TABLE T;
DROP TABLE S;
DROP TABLE R;

CREATE TABLE T
(C INTEGER PRIMARY KEY,
D INTEGER);

INSERT INTO T VALUES(1,1);
INSERT INTO T VALUES(2,1);

SELECT
    * FROM
    T;
    
CREATE TABLE S
(B INTEGER PRIMARY KEY,
C INTEGER REFERENCES T(C)ON DELETE CASCADE);

INSERT INTO S VALUES(1,1);
INSERT INTO S VALUES(2,1);

SELECT
    * FROM
    S;
    
CREATE TABLE R
(A INTEGER PRIMARY KEY,
 B INTEGER REFERENCES S(B)ON DELETE SET NULL);

INSERT INTO R VALUES(1,1);
INSERT INTO R VALUES(2,2);

SELECT
    * FROM
    R;
    
DELETE FROM T;  -- T�� �翬�� ����  

SELECT * FROM S; -- S ���̺� C Į���� CASCADE T(C)�� �ɷ� �־ ����

SELECT * FROM R;
ROLLBACK;    

-- 13��

CREATE TABLE  �л�(
�й� CHAR(8) PRIMARY KEY 
, ���б� INTEGER
);
INSERT INTO �л� VALUES ('1',1234);
INSERT INTO �л� VALUES ('2',1344);
INSERT INTO �л� VALUES ('3',1554);

SELECT * FROM �л�;

SELECT COUNT(*) FROM �л�;
SELECT COUNT(�й�) FROM �л� ; 

--17 �� 

CREATE TABLE �μ� (
�μ���ȣ CHAR(10) 
,�μ��� CHAR(10)
);

ALTER TABLE �μ� ADD CONSTRAINT PK_�μ�_�μ���ȣ PRIMARY KEY (�μ���ȣ);
COMMIT;

CREATE TABLE ���� (
������ȣ CHAR(10) ,
�ҼӺμ� CHAR(10)
);

ALTER TABLE ���� ADD CONSTRAINT PK_����_������ȣ PRIMARY KEY (������ȣ);
ALTER TABLE ���� ADD CONSTRAINT FK_����_�ҼӺμ� FOREIGN KEY (�ҼӺμ�) REFERENCES �μ�(�μ���ȣ) ON DELETE CASCADE;

INSERT INTO �μ�  VALUES ('10' , '������');
INSERT INTO �μ�  VALUES ('20' , '��ȹ��');

INSERT INTO ����  VALUES ('1000' , '10');
INSERT INTO ����  VALUES ('2000' , '20');
INSERT INTO ����  VALUES ('3000' , '20');
COMMIT; 

SELECT * FROM �μ� ;
SELECT * FROM ���� ;


SELECT COUNT(������ȣ) FROM ���� ;
SELECT * FROM ���� ;

DELETE FROM �μ� WHERE �μ���ȣ = '20';
SELECT * FROM �μ� ;

SELECT COUNT(������ȣ) FROM ���� ;
SELECT * FROM ���� ;

COMMIT; 

 -- 22�� 
CREATE TABLE �� (
    ��ID VARCHAR2(20) NOT NULL 
    , ���� VARCHAR(20) NULL 
    , �����Ͻ� DATE NOT NULL 
);
ALTER TABLE �� ADD CONSTRAINT PK_��ID PRIMARY KEY (��ID);

CREATE TABLE �ֹ� (
�ֹ���ȣ VARCHAR(20) NOT NULL  
, ��ID VARCHAR(20) NOT NULL
, �ֹ��Ͻ� DATE NOT NULL 
);

ALTER TABLE �ֹ� ADD CONSTRAINT FK_��ID FOREIGN KEY (��ID) REFERENCES ��(��ID) ON DELETE SET NULL;

INSERT INTO �� VALUES('C001','ȫ�浿','2013-12-12');
INSERT INTO �� VALUES('C002','�̼���','2013-12-12');

COMMIT;

INSERT INTO �ֹ� VALUES('0001','C001','2013-12-24');
INSERT INTO �ֹ� VALUES('0002','C001','2013-12-25');
INSERT INTO �ֹ� VALUES('0003','C002','2013-12-26');
INSERT INTO �ֹ� VALUES('0004','C002','2013-12-27');

SELECT * FROM �� ; 
SELECT * FROM �ֹ� ; 
DROP TABLE �� ;
DROP TABLE �ֹ� ;
-- ���� ���� ���������� ����Ǵ� SQL �� ���ÿ� 
-- 1.��
INSERT INTO �� VALUES ('C003','������' , '2014-01-01'); -- ����
-- 2.��
INSERT INTO �ֹ� VALUES ('0005', 'C003' , '2013-12-28'); 
-- �������Ϳ� C003 �̶�� �����Ͱ� ��� �ֹ� ����� �ȵ�
-- 3�� 
DELETE FROM �ֹ� WHERE �ֹ���ȣ IN ('0001' ,'0002'); --����

-- 4�� 
DELETE FROM �� WHERE ��ID = 'C002';
-- �ֹ����̺� ��ID�� NOT NULL �� �ɷ��־ �浹��    

91��- ���� ���� �� �ۼ��߽��ϴ�.

-- #91��
DROP TABLE �μ�_91;

-- ���̺� �ۼ�
-- �μ����̺�
CREATE TABLE �μ�_91 (
 �μ��ڵ� VARCHAR2(20),
 �μ��� VARCHAR2(100),
 �����μ��ڵ� VARCHAR2(20),
 CONSTRAINT pk_�μ�_91 PRIMARY KEY(�μ��ڵ�)
);

-- fk ����
ALTER TABLE �μ�_91 
ADD CONSTRAINT fk_�����μ��ڵ�_91 
FOREIGN KEY (�����μ��ڵ�)
REFERENCES �μ�_91 (�μ��ڵ�);

INSERT INTO �μ�_91 VALUES(100, '�ƽþƺ�', NULL);
INSERT INTO �μ�_91 VALUES(110, '�ѱ�����', 100);
INSERT INTO �μ�_91 VALUES(111, '��������', 110);
INSERT INTO �μ�_91 VALUES(112, '�λ�����', 110);
INSERT INTO �μ�_91 VALUES(120, '�Ϻ�����', 100);
INSERT INTO �μ�_91 VALUES(121, '��������', 120);
INSERT INTO �μ�_91 VALUES(122, '����ī����', 120);
INSERT INTO �μ�_91 VALUES(130, '�߱�����', 100);
INSERT INTO �μ�_91 VALUES(131, '����¡����', 130);
INSERT INTO �μ�_91 VALUES(132, '����������', 130);
INSERT INTO �μ�_91 VALUES(200, '����������', NULL);
INSERT INTO �μ�_91 VALUES(210, '����������', 200);
INSERT INTO �μ�_91 VALUES(211, '���帮������', 210);
INSERT INTO �μ�_91 VALUES(212, '�׶󳪴�����', 210);
INSERT INTO �μ�_91 VALUES(220, '������������', 200);
INSERT INTO �μ�_91 VALUES(221, '����������', 220);
INSERT INTO �μ�_91 VALUES(222, '�׶󳪴�����', 220);

COMMIT;

-- ���� ���̺�
DROP TABLE ����_91;
CREATE TABLE ����_91(
�μ��ڵ� VARCHAR2(20),
����� NUMBER(20));

INSERT INTO ����_91 VALUES(111,1000);
INSERT INTO ����_91 VALUES(112,2000);
INSERT INTO ����_91 VALUES(121,1500);
INSERT INTO ����_91 VALUES(122,1000);
INSERT INTO ����_91 VALUES(131,1500);
INSERT INTO ����_91 VALUES(132,2000);
INSERT INTO ����_91 VALUES(211,2000);
INSERT INTO ����_91 VALUES(212,1500);
INSERT INTO ����_91 VALUES(221,1000);
INSERT INTO ����_91 VALUES(222,2000);
COMMIT;

SELECT * FROM �μ�_91;
SELECT * FROM ����_91;

-- ���� 1��
SELECT A.�μ��ڵ�, A.�μ���, A.�����μ��ڵ�, B.�����, LVL
FROM (
    SELECT �μ��ڵ�, �μ���, �����μ��ڵ�, LEVEL AS LVL
    FROM �μ�_91
    START WITH �μ��ڵ� = '120'
    CONNECT BY PRIOR �����μ��ڵ� = �μ��ڵ�
    UNION
    SELECT �μ��ڵ�, �μ���, �����μ��ڵ�, LEVEL AS LVL
    FROM �μ�_91
    START WITH �μ��ڵ� = '120'
    CONNECT BY �����μ��ڵ� = PRIOR �μ��ڵ�) 
    A LEFT OUTER JOIN ����_91 B
ON (A.�μ��ڵ� = B.�μ��ڵ�)
ORDER BY A.�μ��ڵ�;

-- ���� 2��
SELECT A.�μ��ڵ�, A.�μ���, A.�����μ��ڵ�, B.�����, LVL
FROM (
    SELECT �μ��ڵ�, �μ���, �����μ��ڵ�, LEVEL AS LVL
    FROM �μ�_91
    START WITH �μ��ڵ� = '100'
    CONNECT BY �����μ��ڵ� = PRIOR �μ��ڵ�
    )
    A LEFT OUTER JOIN ����_91 B
ON (A.�μ��ڵ� = B.�μ��ڵ�)
ORDER BY A.�μ��ڵ�;

-- ���� 3��
SELECT A.�μ��ڵ�, A.�μ���, A.�����μ��ڵ�, B.�����, LVL
FROM (
    SELECT �μ��ڵ�, �μ���, �����μ��ڵ�, LEVEL AS LVL
    FROM �μ�_91
    START WITH �μ��ڵ� = '121'
    CONNECT BY PRIOR �����μ��ڵ� = �μ��ڵ�)
    A LEFT OUTER JOIN ����_91 B
ON (A.�μ��ڵ� = B.�μ��ڵ�)
ORDER BY A.�μ��ڵ�;

-- ���� 4��

SELECT A.�μ��ڵ�, A.�μ���, A.�����μ��ڵ�, B.�����, LVL
FROM (
    SELECT �μ��ڵ�, �μ���, �����μ��ڵ�, LEVEL AS LVL
    FROM �μ�_91
    
    START WITH �μ��ڵ� =
    
    (SELECT �μ��ڵ� FROM �μ�_91
    WHERE �����μ��ڵ� IS NULL 
    START WITH �μ��ڵ� = '120'
    CONNECT BY PRIOR �����μ��ڵ� = �μ��ڵ�)
    
    CONNECT BY �����μ��ڵ� = PRIOR �μ��ڵ�)
    A LEFT OUTER JOIN ����_91 B
    ON (A.�μ��ڵ� = B.�μ��ڵ�)
    ORDER BY A.�μ��ڵ�;
    
    
    
-- # 101�� ����
CREATE TABLE ǰ�����׸�_101 (
    ���׸�ID CHAR(7)
    , ���׸�� VARCHAR2(50)
    , CONSTRAINT ǰ�����׸�_101_PK PRIMARY KEY (���׸�ID)
);

CREATE TABLE �򰡴���ǰ_101 (
    ��ǰID CHAR(7)
    , ��ǰ�� VARCHAR2(50)
    , CONSTRAINT �򰡴���ǰ_101_PK PRIMARY KEY (��ǰID)
);

CREATE TABLE �򰡰��_101 (
    ��ǰID CHAR(7)
    , ��ȸ�� NUMBER
    , ���׸�ID CHAR(7)
    , �򰡵�� CHAR(1)
    , ������ CHAR(8)
    , CONSTRAINT �򰡰��_101_PK PRIMARY KEY (��ǰID, ��ȸ��, ���׸�ID)
);

INSERT INTO ǰ�����׸�_101 VALUES ('101', '�����ڷ�');
INSERT INTO ǰ�����׸�_101 VALUES ('102', '����ü�');

INSERT INTO �򰡴���ǰ_101 VALUES ('101', '�ڹټ���');
INSERT INTO �򰡴���ǰ_101 VALUES ('102', '���̽����');

INSERT INTO �򰡰��_101 VALUES ('101', 1, '101', 'S', '20220629');
INSERT INTO �򰡰��_101 VALUES ('101', 2, '101', 'A', '20220629');
INSERT INTO �򰡰��_101 VALUES ('101', 3, '101', 'B', '20220629');

INSERT INTO �򰡰��_101 VALUES ('101', 1, '102', 'B', '20220629');
INSERT INTO �򰡰��_101 VALUES ('101', 2, '102', 'A', '20220629');
INSERT INTO �򰡰��_101 VALUES ('101', 3, '102', 'S', '20220629');

INSERT INTO �򰡰��_101 VALUES ('102', 1, '101', 'S', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 2, '101', 'A', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 3, '101', 'B', '20220629');

INSERT INTO �򰡰��_101 VALUES ('102', 1, '102', 'B', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 2, '102', 'A', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 3, '102', 'S', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 4, '102', 'C', '20220629');

COMMIT;

SELECT* FROM "�򰡴���ǰ_101";
SELECT* FROM "ǰ�����׸�_101";
SELECT* FROM "�򰡰��_101";

-- # 101�� ����1
SELECT B.��ǰID, B.��ǰ��, C.���׸�ID, C.���׸��, A,��ȸ��, A.�򰡵��, A.������
FROM �򰡰��_101 A, �򰡴���ǰ_101 B, ǰ�����׸�_101 C, 
(SELECT MAX(��ȸ��) AS ��ȸ�� FROM �򰡰��_101) D
WHERE A.��ǰID = B.��ǰID
AND A.���׸�ID = C.���׸�ID
AND A.��ȸ�� = D.��ȸ��;

-- # 105��

CREATE TABLE ����_101 (
    ����ID CHAR(7)PRIMARY KEY
    , ���񽺸� CHAR(7)
);

CREATE TABLE ���񽺰���_101 (
    ȸ����ȣ CHAR(7)PRIMARY KEY
    , ����ID CHAR(7)
    , �������� DATE
);





    

