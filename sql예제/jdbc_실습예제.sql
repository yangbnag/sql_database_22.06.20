CREATE TABLE score (
    stu_num NUMBER(10),
    stu_name VARCHAR2(20) NOT NULL,
    kor NUMBER(3) NOT NULL,
    eng NUMBER(3) NOT NULL,
    math NUMBER(3) NOT NULL,
    total NUMBER(3),
    average NUMBER(5,2),
    CONSTRAINT pk_score PRIMARY KEY (stu_num)
);

-- ���ӵ� ���� ���� // �ߺ��� ���� �Ϸù�ȣ�� ���鶧 sequence ���
-- sequence ���̺��� ��������� nextval �Ҷ� �ϳ��� ���ڰ� ����.
CREATE SEQUENCE seq_score;

SELECT * FROM score;

INSERT INTO score VALUES (seq_score.nextval,  'ȫ�浿', 90, 90, 90, 270, 90);
INSERT INTO score VALUES (seq_score.nextval,  '��ö��', 80, 80, 80, 240, 80);
INSERT INTO score VALUES (seq_score.nextval,  '�ڿ���', 100, 100, 100, 300, 100);
COMMIT;

SELECT AVG(average) avg_cls
FROM score;


-- ============================ �����

CREATE TABLE income (
in_serial_nm CHAR(5) PRIMARY KEY,
in_date DATE NOT NULL,
in_detail VARCHAR2(30),
in_amt number NOT NULL,
category_num CHAR(5) NOT NULL);

ALTER TABLE income ADD CONSTRAINT fk_�з�_ī�װ� FOREIGN KEY(category_num) REFERENCES income_category(in_ca_serial_nm);
ALTER TABLE income MODIFY(in_date DATE DEFAULT SYSDATE);

CREATE TABLE expense (
out_serial_nm CHAR(5) PRIMARY KEY,
out_date DATE NOT NULL ,
out_detail VARCHAR2(30),
out_amt number NOT NULL,
category_num CHAR(5) NOT NULL);

ALTER TABLE expense ADD CONSTRAINT fk_�з�_ī�װ�_out FOREIGN KEY(category_num) REFERENCES expense_category(out_ca_serial_nm);
ALTER TABLE expense MODIFY(out_date DATE DEFAULT SYSDATE);


CREATE TABLE income_category (
in_ca_serial_nm CHAR(5) PRIMARY KEY,
in_ca_detail VARCHAR2(30),
in_category_num CHAR(5) NOT NULL);

ALTER TABLE income_category MODIFY(in_category_num CHAR(5) null);


CREATE TABLE expense_category (
out_ca_serial_nm CHAR(5) PRIMARY KEY,
out_ca_detail VARCHAR2(30),
out_category_num CHAR(5) NOT NULL);

ALTER TABLE expense_category MODIFY(out_category_num CHAR(5) null);

CREATE SEQUENCE seq_income;
CREATE SEQUENCE seq_expense;

INSERT INTO income_category(in_ca_serial_nm, in_ca_detail) VALUES('001', '����');
INSERT INTO income_category(in_ca_serial_nm, in_ca_detail) VALUES('002', '��Ÿ�ҵ�');

INSERT INTO income(in_serial_nm, in_date, in_detail, in_amt, category_num) 
VALUES(seq_income.nextval,'22-06-24','���������������',500000,'002');

INSERT INTO income(in_serial_nm, in_date, in_detail, in_amt, category_num) 
VALUES(seq_income.nextval,'22-06-25','�Ǻ���� ȯ��',100000,'002');

INSERT INTO income(in_serial_nm, in_date, in_detail, in_amt, category_num) 
VALUES(seq_income.nextval,'22-06-30','6�� ����',2500000,'001');



INSERT INTO expense_category(out_ca_serial_nm, out_ca_detail) VALUES('001', '�ĺ�');
INSERT INTO expense_category(out_ca_serial_nm, out_ca_detail, out_category_num) VALUES('002', '�����', '001');
INSERT INTO expense_category(out_ca_serial_nm, out_ca_detail, out_category_num) VALUES('003', '�ܽĺ�', '001');
INSERT INTO expense_category(out_ca_serial_nm, out_ca_detail) VALUES('004', '������');
INSERT INTO expense_category(out_ca_serial_nm, out_ca_detail) VALUES('005', '����');


-- DELETE FROM expense_category;

INSERT INTO expense(out_serial_nm, out_date, out_detail, out_amt, category_num) VALUES(SEQ_EXPENSE.nextval, '22-06-24', '�庸��', 5000, '002');
INSERT INTO expense(out_serial_nm, out_date, out_detail, out_amt, category_num) VALUES(SEQ_EXPENSE.nextval, '22-06-24', '���õ��', 6000, '003');
INSERT INTO expense(out_serial_nm, out_date, out_detail, out_amt, category_num) VALUES(SEQ_EXPENSE.nextval, '22-06-25', '«������', 8000, '003');
INSERT INTO expense(out_serial_nm, out_date, out_detail, out_amt, category_num) VALUES(SEQ_EXPENSE.nextval, '22-06-26', '�����Ĵ�', 6000, '003');
INSERT INTO expense(out_serial_nm, out_date, out_detail, out_amt, category_num) VALUES(SEQ_EXPENSE.nextval, '22-06-24', '��γ׼��κ�', 8000, '003');
INSERT INTO expense(out_serial_nm, out_date, out_detail, out_amt, category_num) VALUES(SEQ_EXPENSE.nextval, '22-06-25', '���⼼', 12000, '005');

commit;

-- ���⳻�� ��ü ��ȸ  
SELECT * FROM expense;
SELECT * FROM expense_category;

  -- �ĺ� ��ü ��ȸ
  SELECT 
    A.out_serial_nm, A.out_date, A.out_detail, A.out_amt , A.category_num, b.out_category_num, b.out_ca_detail
FROM expense A, expense_category B
WHERE a.category_num = b.out_ca_serial_nm
    AND b.out_category_num = '001' --?
;
  
  -- ������ ��ü ��ȸ
  
SELECT 
    A.out_serial_nm, A.out_date, A.out_detail, A.out_amt , A.category_num, b.out_category_num, b.out_ca_detail
FROM expense A, expense_category B
WHERE a.category_num = b.out_ca_serial_nm
    AND b.out_ca_serial_nm = '002' --?
;
  
  -- �ܽĺ� ��ü ��ȸ
  SELECT 
    A.out_serial_nm, A.out_date, A.out_detail, A.out_amt , A.category_num, b.out_category_num, b.out_ca_detail
FROM expense A, expense_category B
WHERE a.category_num = b.out_ca_serial_nm
    AND b.out_ca_serial_nm = '003' --?
;
  
-- ���Գ��� ��ü ��ȸ
SELECT * FROM income;

-- ���� ��ü ��ȸ
 SELECT * 
 FROM income A
 WHERE A.category_num = '001';
    
-- ��Ÿ �ҵ� ��ü ��ȸ

 SELECT * 
 FROM income A
 WHERE A.category_num = '002';
 
SELECT * FROM income;
SELECT * FROM expense_category;
SELECT * FROM income_category;
SELECT * FROM expense;

commit;

  
  





