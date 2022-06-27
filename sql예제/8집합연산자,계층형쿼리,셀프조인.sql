
-- 집합 연산자
-- ## UNION
-- 1. 합집합 연산의 의미입니다.
-- 2. 첫번째 쿼리와 두번째 쿼리의 중복정보는 한번만 보여줍니다.
-- 3. 첫번째 쿼리의 열의 개수와 타입이 두번째 쿼리의 열수와 타입과 동일해야 함.
-- 4. 자동으로 정렬이 일어남 (첫번째 컬럼 오름차가 기본값)

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
-- 70년생 사원 중 이관심이 중복이 되어있다.
-- 사원번호로 분리 하다가 사원번호를 뺀후 UNION 실행하니 중복된 이관심 하나가 없어짐.
-- 정렬은 첫번째 컬럼 오름차로 되었다.
;

SELECT
  emp_nm EN, birth_de BD -- 별칭을 준후 UNION 하면?
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT
  emp_nm EN2, birth_de BD2
FROM tb_emp
WHERE birth_de BETWEEN '1970101' AND '19791231'
ORDER BY BD DESC -- 자동정렬 : 첫열의 오름차 / 다르게 정렬하고 싶으면 UNION 끝나는 지점에 작성
;

-- 별칭을 주지 않으면 컬럼명으로 나오는데 별칭이 있는 경우 위에 있는 별칭을 쓴다.


-- ## UNION ALL
-- 1. UNION과 같이 두 테이블로 수직으로 합쳐서 보여줍니다.
-- 2. UNION과는 달리 중복된 데이터도 한번 더 보여줍니다.
-- 3. 자동 정렬 기능을 지원하지 않아 성능상 유리합니다.

SELECT
  emp_no,emp_nm, birth_de 
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL -- UNION과 달리 정렬이 되지 않았다.
SELECT
  emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '1970101' AND '19791231'
;

SELECT
  emp_nm, birth_de 
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL -- 중복 제거가 되지 않았고, 정렬도 되지 않았다.
SELECT
  emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '1970101' AND '19791231'
;

-- ===

-- ## INTERSECT
-- 1. 첫번째 쿼리와 두번째 쿼리에서 중복된 행만을 출력합니다.
-- 2. 교집합의 의미입니다.

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
WHERE A.addr LIKE '%용인%';


SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%용인%'
    AND C.certi_nm = 'SQLD'
;

-- ## MINUS(EXCEPT) 
-- 1. 두번째 쿼리에는 없고 첫번째 쿼리에만 있는 데이터를 보여줍니다.
-- 2. 차집합의 개념입니다.

SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100001'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100004'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE sex_cd = '1'
;

-- ========
-- 계층형 쿼리
-- START WITH : 계층의 첫 단계를 어디서 시작할 것인지 대한 조건
-- CONNECT BY : 전계방향을 어디로 짤 것인가
  -- [ 부모에서 자식으로 전개 : 순방향 탐색 // 자식에서 부모로 : 역방향 탐색 ]
  -- CONNECT BY PRIOR 자식 = 부모 -> 순방향 탐색
  -- CNONECT BY 자식 = PRIOOR 부모 -> 역방향 탐색
  
  -- ORDER SILBINGS BY : 같은 레벨끼리의 정렬을 정함.
  -- EX) 형제들 끼리는 사번 내림차로 정렬하고 싶다.

SELECT 
    LEVEL AS LVL,
    LPAD(' ', 44*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
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
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
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
 -- 1. 하나의 테이블에서 자기 자신의 테이블끼리 조인하는 기법입니다.
 -- 2. 자기 자신 테이블에서 pk와 fk로 동등조인 합니다.
 
 SELECT 
    A.emp_no 
  , A.emp_nm "사원 이름"
  , A.addr "사원 주소"
  , A.direct_manager_emp_no
  , B.emp_nm "직속 상사 사원명"
  , B.addr "직속 상사의 주소"
 FROM tb_emp A
 LEFT JOIN tb_emp B
 ON A.direct_manager_emp_no = b.emp_no
 ORDER BY emp_no 
;
   -- 이경오의 직장상사 번호가 나온다. 
   -- 직장상사의 번호와 함께 상사의 이름과 주소도 알고 싶을때.
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

-- 셀프 fk 선언하기
ALTER TABLE tb_emp
ADD CONSTRAINT fk_direct_emp_no
FOREIGN KEY (direct_manager_emp_no)
REFERENCES tb_emp (emp_no);


