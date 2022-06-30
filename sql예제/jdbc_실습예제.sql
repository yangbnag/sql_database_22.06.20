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

-- 연속된 숫자 생성 // 중복이 없는 일련번호를 만들때 sequence 사용
-- sequence 테이블이 만들어지고 nextval 할때 하나씩 숫자가 증가.
CREATE SEQUENCE seq_score;

SELECT * FROM score;

INSERT INTO score VALUES (seq_score.nextval,  '홍길동', 90, 90, 90, 270, 90);
INSERT INTO score VALUES (seq_score.nextval,  '김철수', 80, 80, 80, 240, 80);
INSERT INTO score VALUES (seq_score.nextval,  '박영희', 100, 100, 100, 300, 100);
COMMIT;

SELECT AVG(average) avg_cls
FROM score;


-- ============================ 가계부

CREATE TABLE income (
in_serial_nm CHAR(5) PRIMARY KEY,
in_date DATE NOT NULL,
in_detail VARCHAR2(30),
in_amt number NOT NULL,
category_num CHAR(5) NOT NULL);

ALTER TABLE income ADD CONSTRAINT fk_분류_카테고리 FOREIGN KEY(category_num) REFERENCES income_category(in_ca_serial_nm);
ALTER TABLE income MODIFY(in_date DATE DEFAULT SYSDATE);

CREATE TABLE expense (
out_serial_nm CHAR(5) PRIMARY KEY,
out_date DATE NOT NULL ,
out_detail VARCHAR2(30),
out_amt number NOT NULL,
category_num CHAR(5) NOT NULL);

ALTER TABLE expense ADD CONSTRAINT fk_분류_카테고리_out FOREIGN KEY(category_num) REFERENCES expense_category(out_ca_serial_nm);
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

INSERT INTO income_category(in_ca_serial_nm, in_ca_detail) VALUES('001', '월급');
INSERT INTO income_category(in_ca_serial_nm, in_ca_detail) VALUES('002', '기타소득');

INSERT INTO income(in_serial_nm, in_date, in_detail, in_amt, category_num) 
VALUES(seq_income.nextval,'22-06-24','국민취업지원제도',500000,'002');

INSERT INTO income(in_serial_nm, in_date, in_detail, in_amt, category_num) 
VALUES(seq_income.nextval,'22-06-25','실비보험료 환급',100000,'002');

INSERT INTO income(in_serial_nm, in_date, in_detail, in_amt, category_num) 
VALUES(seq_income.nextval,'22-06-30','6월 월급',2500000,'001');



INSERT INTO expense_category(out_ca_serial_nm, out_ca_detail) VALUES('001', '식비');
INSERT INTO expense_category(out_ca_serial_nm, out_ca_detail, out_category_num) VALUES('002', '식재료', '001');
INSERT INTO expense_category(out_ca_serial_nm, out_ca_detail, out_category_num) VALUES('003', '외식비', '001');
INSERT INTO expense_category(out_ca_serial_nm, out_ca_detail) VALUES('004', '공과금');
INSERT INTO expense_category(out_ca_serial_nm, out_ca_detail) VALUES('005', '쇼핑');


-- DELETE FROM expense_category;

INSERT INTO expense(out_serial_nm, out_date, out_detail, out_amt, category_num) VALUES(SEQ_EXPENSE.nextval, '22-06-24', '장보기', 5000, '002');
INSERT INTO expense(out_serial_nm, out_date, out_detail, out_amt, category_num) VALUES(SEQ_EXPENSE.nextval, '22-06-24', '김밥천구', 6000, '003');
INSERT INTO expense(out_serial_nm, out_date, out_detail, out_amt, category_num) VALUES(SEQ_EXPENSE.nextval, '22-06-25', '짬뽕지존', 8000, '003');
INSERT INTO expense(out_serial_nm, out_date, out_detail, out_amt, category_num) VALUES(SEQ_EXPENSE.nextval, '22-06-26', '구내식당', 6000, '003');
INSERT INTO expense(out_serial_nm, out_date, out_detail, out_amt, category_num) VALUES(SEQ_EXPENSE.nextval, '22-06-24', '대두네순두부', 8000, '003');
INSERT INTO expense(out_serial_nm, out_date, out_detail, out_amt, category_num) VALUES(SEQ_EXPENSE.nextval, '22-06-25', '전기세', 12000, '005');

commit;

-- 지출내역 전체 조회  
SELECT * FROM expense;
SELECT * FROM expense_category;

  -- 식비 전체 조회
  SELECT 
    A.out_serial_nm, A.out_date, A.out_detail, A.out_amt , A.category_num, b.out_category_num, b.out_ca_detail
FROM expense A, expense_category B
WHERE a.category_num = b.out_ca_serial_nm
    AND b.out_category_num = '001' --?
;
  
  -- 식재료비 전체 조회
  
SELECT 
    A.out_serial_nm, A.out_date, A.out_detail, A.out_amt , A.category_num, b.out_category_num, b.out_ca_detail
FROM expense A, expense_category B
WHERE a.category_num = b.out_ca_serial_nm
    AND b.out_ca_serial_nm = '002' --?
;
  
  -- 외식비 전체 조회
  SELECT 
    A.out_serial_nm, A.out_date, A.out_detail, A.out_amt , A.category_num, b.out_category_num, b.out_ca_detail
FROM expense A, expense_category B
WHERE a.category_num = b.out_ca_serial_nm
    AND b.out_ca_serial_nm = '003' --?
;
  
-- 수입내역 전체 조회
SELECT * FROM income;

-- 월급 전체 조회
 SELECT * 
 FROM income A
 WHERE A.category_num = '001';
    
-- 기타 소득 전체 조회

 SELECT * 
 FROM income A
 WHERE A.category_num = '002';
 
SELECT * FROM income;
SELECT * FROM expense_category;
SELECT * FROM income_category;
SELECT * FROM expense;

commit;

  
  





