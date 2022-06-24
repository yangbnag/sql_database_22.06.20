
 -- 사원들의 사번, 이름, 주소, 부서명
 
 SELECT
  F.emp_no, F.emp_nm, F.addr, G.dept_nm
 FROM tb_emp F
 JOIN tb_dept G
 ON F.dept_cd = G.dept_cd
 ;
 
 -- ==================================== --
 -- 조인 기초 테스트 데이터
CREATE TABLE TEST_A ( -- 가칭 게시판 테이블
    id NUMBER(10) PRIMARY KEY -- 게시판 글번호
    , content VARCHAR2(200) -- 게시물 내용
);

CREATE TABLE TEST_B ( -- 가칭 댓글 테이블
    b_id NUMBER(10) PRIMARY KEY -- 댓글 번호
    , reply VARCHAR2(100)-- 댓글번호
    , a_id NUMBER(10) -- FK 역할 // 원본 글 번호
);

INSERT INTO TEST_A  VALUES (1, 'aaa');
INSERT INTO TEST_A  VALUES (2, 'bbb');
INSERT INTO TEST_A  VALUES (3, 'ccc');

INSERT INTO TEST_B  VALUES (1, 'ㄱㄱㄱ', 1);
INSERT INTO TEST_B  VALUES (2, 'ㄴㄴㄴ', 1);
INSERT INTO TEST_B  VALUES (3, 'ㄷㄷㄷ', 2);
INSERT INTO TEST_B  VALUES (4, 'ㄹㄹㄹ', 3);
COMMIT;

SELECT * FROM test_a;
SELECT * FROM test_b;

-- 조인 하기
-- # 기본 조인 [Cartesion product / CROSS JOIN]
SELECT
*
FROM test_a, test_b 
-- 행은 12행 / 컬럼은 5개
-- 조인 조건을 설정하지 않으면 test_a 와 test_b의 모든 행이 결합된다.
-- Cartesion product / CROSS JOIN a는 3개의 행 / b는 4개의 행 3*4 = 12행이 조회된다.
;

-- # INNER JOIN [EQUI JOIN의 한 종류]  
-- 동등조건에 의해 매칭되는 행 조인 //[WHERE 조건절로 JOIN]
SELECT
*
FROM test_a, test_b 
WHERE test_a.id = test_b.a_id 
-- test_a 의 id번호와 test_b의 a_id의 번호가 일치하는거를 조회 하려고 한다.
;


-- 5개 컬럼을 다 보고 싶지 않다.
SELECT
 A.id, test_A.content, B.reply 
 -- 소속 테이블명을 명시해야 한다.
 -- 원래 문법이다. 두 테이블간에 똑같은 컬럼이 없기 때문에 이전에는 실행 됐던 것임.
 
FROM test_a A, test_b B -- 테이블 별칭을 줘서 참조시 편리하게 할수 있다.
WHERE test_a.id = test_b.a_id 

;

-- 자격증 관련 테이블
SELECT * FROM tb_emp_certi; -- 123행 = EMP_NO | CERTI_SN | CERTI_CD | ACQU_DE 
SELECT * FROM tb_certi; -- 20행 = CERTI_CD | CDERTI_NM | |ISSUE_INSTI_NM

-- 사원의 사원 번호와 취득 자격증 명을 조회하고 싶다.
-- tb_emp_certi 테이블에서는 사원 이름을 구한다.
-- tb_certi 테이블에서는 자격증 이름을 구한다.

SELECT
 A.emp_no, B.certi_nm
FROM tb_emp_certi A, tb_certi B 
WHERE A.certi_cd = B.certi_cd -- where절로 certi_cd 일치하는 자료만 추출
ORDER BY A.emp_no, B.certi_cd
-- CROSS JOIN 이 되어서 123행 * 20행 = 2460행이 조회되었다.
;

-- 사원의 사원번호와 사원이름과 취득 자격증명을 조회하고 싶음
SELECT * FROM tb_emp_certi; -- 123행 = EMP_NO | CERTI_SN | CERTI_CD | ACQU_DE 
SELECT * FROM tb_certi; -- 20행 = CERTI_CD | CDERTI_NM | |ISSUE_INSTI_NM
SELECT * FROM tb_emp; -- 41행 = 
-- EMP_NO | EMP_NM | BIRTH_DE | LUNAR_YN | SEX_CD | ADDR 
-- | TEL_NO | FINAL_EDU_SE_CD | SAL_TRANS_BANK_CD | DIRECT_MANAGER_EMP_NO | DEPT_CD
-- .. 자격증 관련된 정보가 컬럼이 없음

SELECT
 A.emp_no, c.emp_nm, B.certi_nm
FROM tb_emp_certi A, tb_certi B, tb_emp C
WHERE A.certi_cd = B.certi_cd 
 AND A.emp_no = C.emp_no -- certi_cd 의 사원번호와 tb_emp의 사원번호 일치 조건 추가
ORDER BY A.emp_no, B.certi_cd
;

-- 사원의 사원번호와 사원이름과 부서이름과 취득 자격증명을 조회하고 싶음.

SELECT
 A.emp_no, c.emp_nm, D.dept_nm, B.certi_nm
FROM tb_emp_certi A, tb_certi B, tb_emp C, tb_dept D -- 부서테이블 조인추가
WHERE A.certi_cd = B.certi_cd 
 AND A.emp_no = C.emp_no 
 AND C.dept_cd = D.dept_cd -- 부서코드 일치 조건 추가
ORDER BY A.emp_no, B.certi_cd
;

-- 부서명 총 자격증 취득 수를 조회
SELECT
 B.dept_cd, C.dept_nm, COUNT(A.certi_cd) "부서별 자격증 수"
FROM tb_emp_certi A, tb_emp B, tb_dept C
WHERE A.emp_no = B.emp_no
AND B.dept_cd = C.dept_cd
GROUP BY b.dept_cd, c.dept_nm
ORDER BY b.dept_cd
;

-- # INNER JOIN 
-- 1. 2개 이상의 테이블이 공통된 컬럼에 의해 논리적으로 결합되는 조인기법입니다.
-- 2. WHERE절에 사용된 컬럼들이 동등연산자(=)에 의해 조인됩니다.

-- (용인시에 사는) 사원의 사원번호, 사원명, 주소, 부서코드, 부서명을 조회하고 싶다.
SELECT 
  A.emp_no
  , A.emp_nm
  , A.addr
  , A.dept_cd
  , B.dept_nm
FROM tb_emp A, tb_dept B
WHERE A.addr LIKE '%용인%' -- 오라클 조인 문법
 AND A.dept_cd = B.dept_cd
 AND A.emp_nm LIKE '김%' -- 김씨인 사람만 추출
ORDER BY A.emp_no
;
-- 위 문법의 문제점은 조인 테이블이 많아질수록 조인 조건이 많아진다.
-- 조인 조건은 테이블(N) 일때 N-1 이다. 


--============= 여기까지 

-- === 여기서 부터 [데이터베이스_SQL기본(JOIN)_예제2_ 22.06.24(day05)]


-- JOIN ON (ANSI 표준 조인)
-- 1. FROM절 뒤, WHERE절 앞
-- 2. JOIN 키워드 뒤에는 조인할 테이블명을 명시
-- 3. ON 키워드 뒤에는 조인 조건을 명시
-- 4. 조인 조건 서술부(ON절) 일반 조건 서술부(WHERE)를 분리해서 작성하는 방법
-- 5. ON절을 이용하면 JOIN 이후의 논리연산이나 서브쿼리와 같은 추가 서술이 가능

SELECT 
  A.emp_no  , A.emp_nm  , A.addr  , A.dept_cd  , B.dept_nm
FROM tb_emp A 
JOIN tb_dept B -- 1번 2번
ON A.dept_cd = B.dept_cd -- 3번 -- ON절로 JOIN 조건을 다른 WHERE 조건과 구분 할수 있다.
WHERE A.addr LIKE '%용인%' 
 AND A.emp_nm LIKE '김%' 
ORDER BY A.emp_no
;

-- 1980년대생 사원들의 사번, 사원명, 부서명, 자격증명, 취득일자를 조회
SELECT * FROM tb_emp; -- 사번, 사원명
SELECT * FROM tb_dept; -- 부서명
SELECT * FROM tb_certi; -- 자격증명
SELECT * FROM tb_emp_certi; -- 취득일자

SELECT 
 E.emp_no, E.emp_nm, D.dept_nm, C.certi, ec.acqu_de
-- FROM tb_emp E, tb_dept D, tb_emp_certi EC, tb_certi C
FROM tb_emp E, tb_dept D, tb_emp_certi EC, tb_certi C
WHERE E.dept_cd = D.tb_dept_cd
AND EC.certi_cd = C.certi_cd
AND E.emp_no = EC.emp_no
AND E.birth_de BETWEEN '19800101' AND '19891231'
;

-- 1980년대생 사원들의 사번, 사원명, 부서명, 자격증명, 취득일자를 조회
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

-- JOIN ON 구문으로 카테시안 곱 만들기
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
-- 1.NATURAL JOIN은 동일한 이름을 갖는 컬럼들에 대해 자동으로 조인조건을 생성하는 기법입니다.
-- 2.즉, 자동으로 2개 이상의 테이블에서 같은이름을 가진 컬럼을 찾아 INNER조인을 수행합니다.
-- 3.이 때 조인되는 동일 이름의 컬럼은 데이터 타입이 같아야 하며,
-- ALIAS나 테이블명을 자동 조인 컬럼 앞에 표기하면 안됩니다.
-- 4.SELECT * 문법을 사용하면, 공통 컬럼은 집합에서 한번만 표기됩니다.
-- 5. 공통 컬럼이 n개 이상이면 조인 조건이 n개로 처리됩니다.

-- 사원 테이블과 부서 테이블을 조인 (사번, 사원명, 부서코드, 부서명)
SELECT

 a.emp_no, a.emp_nm, 
  dept_cd, --b.dept_cd, : natural join의 3번 규칙 
 b.dept_nm

FROM tb_emp A
NATURAL JOIN tb_dept B;
--ON A.dept_cd = B.dept_cd 
-- pk와 fk의 이름이 똑같고 데이터 코드도 똑같다. (natural join 조건 성립)


-- # USING절 조인
--  [natural 조인에서 할수 없는 일을 조금 보완]
-- 1. NATURAL 조인에서는 자동으로 이름과 타입이 일치하는 모든 컬럼에 대해
--    조인이 일어나지만 USING을 사용하면 원하는 컬럼에 대해서만 선택적 조인을
--    부여할 수 있습니다.
-- 2. USING절에서도 조인 컬럼에 대해 ALIAS나 테이블명을 표기하시면 안됩니다.

SELECT

 a.emp_no, a.emp_nm, 
  dept_cd, --b.dept_cd, : natural join의 3번 규칙과 동일하게 using절에도 적용된다.
 b.dept_nm

FROM tb_emp A
INNER JOIN tb_dept B
USING (dept_cd);

-- # INNER JOIN의 SELECT * 문 사용 
-- 열 중복 제거 안함 . DEPT_CD 와 DEPT_CD1 컬럼 생성
-- 15개의 컬럼 생성

SELECT
*
FROM tb_emp A
INNER JOIN tb_dept B
ON A.dept_cd = B.dept_cd;

-- # NATURAL JOIN의 SELECT * 문 사용
-- 14개의 컬럼 생성 중복 되는 dept_cd가 하나만 나옴.
SELECT
 *
FROM tb_emp A
NATURAL JOIN tb_dept B;

-- # USING절 JOIN의 SELECT * 문 사용
-- 14개의 컬럼 생성 중복 되는 dept_cd가 하나만 나옴.
SELECT
*
FROM tb_emp A
INNER JOIN tb_dept B
USING (dept_cd);



 
