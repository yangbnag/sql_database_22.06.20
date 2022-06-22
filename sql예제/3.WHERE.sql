

-- WHERE 조건절 : 조회 결과 행을 제한하는 조건절

SELECT
 
 emp_no, emp_nm, addr, sex_cd

FROM tb_emp -- 41행 인출 (총 행수가 41행 임)
WHERE sex_cd = 2
; -- 성별이 여자인 사람들의 정보를 WHERE 조건절로 설정하여 출력


 -- PK로 WHERE절 동등조건을 만들면 반드시 단일행이 조회된다.
SELECT
 emp_no, emp_nm, addr, sex_cd
FROM tb_emp 
WHERE emp_no = 1000000003;




-- 비교 연산자

SELECT 
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de >= '19900101' AND birth_de <= '19991231' ;
  -- 90년생인 사원만 조회 하려고 한다.

  
SELECT 
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de BETWEEN '19900101' AND '19991231';

-- OR 연산
SELECT
      emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004' 
       OR dept_cd = '100006'
; -- 부서 번호가 100004 이거나 100006 인 사원의 정보 조회


-- IN 연산자
SELECT
      emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd in('100004', '100006')
; -- 부서 번호가 100004 이거나 100006 인 사원의 정보 조회


-- NOT IN 연산자
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd NOT IN('100004','100006')
; -- 부서 번호가 100004 번과, 100006인 사원의 정보는 나오지 않는다.
  -- 100004번 100006번 부서를 빼고 조회해 줘라.

-- LIKE 연산자
-- 검색시 사용 ( ex) 제목으로 검색, 내용으로 검색 시)
-- 와일드 카드 맵핑 (% : 0글자 이상, _ : 단 1글자만)

SELECT 
 emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '이%' -- 이름의 시작이 '이'이면 모두 조회 
;

SELECT 
 emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '이__' -- 이로 시작하는데 뒤에 단 2글자만 있는 사원의 이름을 조회
;

SELECT 
 emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '%심' -- 이름의 끝 글자가 심으로 끝나는 사원의 이름을 조회
;

SELECT
 emp_no, emp_nm, addr
FROM tb_emp
WHERE addr LIKE '%용인%'
;

-- 성씨가 김씨이면서, 부서가 100003, 100004, 100006번 중에 하나이면서, 
-- 90년대생인 사원의 사번, 이름, 생일, 부서코드를 조회

SELECT
 emp_no, emp_nm, birth_de, dept_cd
FROM tb_emp
WHERE 1=1 -- 실무 팁
AND emp_nm LIKE '김%' 
AND dept_cd IN('100003','100004','100006')
AND birth_de BETWEEN '19900101' AND '19991231'
;

-- 부정 일치 비교 연산자
SELECT
 emp_no, emp_nm, addr, sex_cd
FROM tb_emp 
WHERE sex_cd != 2 -- 성별이 여자가 아닌 사람
-- WHERE sex_cd ^= 2 -- 성별이 여자가 아닌 사람
-- WHERE sex_cd <> 2 -- 성별이 여자가 아닌 사람
-- WHERE NOT sex_cd = 2 -- 성별이 여자가 아닌 사람
; 


-- 성별 코드가 1이 아니면서 성씨가 이씨가 아닌 사람들의 
-- 사번, 이름, 성별코드를 조회하세요.

SELECT

emp_no, emp_nm, sex_cd

FROM tb_emp 
WHERE sex_cd <> 1 AND emp_nm NOT LIKE '이%'
;

--null값 조회

SELECT 
 emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NULL -- null 값 조회
; 

SELECT 
 emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NOT NULL -- null값이 아닌 것 조회
;

-- 연산자 우선순위 : NOT > AND > OR
-- 사원정보 중에 김씨이면서 수원 또는 일산에 사는 사원들의 정보
SELECT
 emp_no, emp_nm, addr
FROM tb_emp
WHERE 1=1
AND emp_nm LIKE '김%' -- 김씨면서 수원사는 사람을 걸러낸후
AND (addr LIKE '%수원%' OR addr LIKE '%일산%') -- 일산 사는 사원을 조회
                           -- OR을 선 연산 시키기 위해 괄호로 
; 




    
