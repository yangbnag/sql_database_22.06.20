
-- 9번 문제
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
    
DELETE FROM T;  -- T는 당연히 삭제  

SELECT * FROM S; -- S 테이블에 C 칼럼에 CASCADE T(C)가 걸려 있어서 삭제

SELECT * FROM R;
ROLLBACK;    