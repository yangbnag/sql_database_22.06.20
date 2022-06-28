
-- 반환형태에 따른 서브쿼리 분류
-- # 단일 행 서브 쿼리
-- 서브쿼리의 실행결과가 항상 1건 이하인 서브쿼리를 의미한다.

-- 부서코드가 100004번인 부서의 사원정보 조회
SELECT
emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
;

-- 사원이름이 이나라인 사람이 속해 있는 부서의 사원정보 조회
-- 1. 이나라가 속해 있는 부서의 코드 확인
SELECT
dept_cd
FROM tb_emp
WHERE emp_nm = '이나라';

-- 2.이나라가 속해 있는 부서 코드로 부서 사원 정보 조회
SELECT
emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
;

-- 서브 쿼리를 이용해 1, 2의 과정을 하나의 
-- 동작으로 실행 시킬 수 있다.

-- 단일행 비교연산자는 단일행 서브쿼리만 비교해야 함.
-- (=, <>, >, >=, <, <=)
SELECT
emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd FROM tb_emp WHERE emp_nm = '이나라')
;

-- 20200525에 받은 급여가 
-- 회사전체의 20200525일 전체 평균 급여보다 높은 
-- 사원들의 정보 조회 (사번, 이름, 급여지급일, 받은급여액수)

-- [ 20200525 날짜에 전체평균 급여를 구하고,평균보다 높은 사원들의 정보를 조회]

SELECT
 A.emp_no, A.emp_nm, B.pay_de, B.pay_amt  
FROM tb_emp A , tb_sal_his B
WHERE A.emp_no = B.emp_no
AND B.pay_de = '20200525'
AND B.pay_amt >= (SELECT AVG(pay_amt) 
                  FROM tb_sal_his 
                  WHERE pay_de = '20200525')
ORDER BY A.emp_no, B.pay_de
;

SELECT
 A.emp_no, A.emp_nm, B.pay_de, B.pay_amt
FROM tb_emp A
JOIN tb_sal_his B
ON A.emp_no = B.emp_no
WHERE B.pay_de = '20200525'
 AND B.pay_amt >= (SELECT AVG(pay_amt)
                   FROM tb_sal_his
                   WHERE pay_de = '20200525')
ORDER BY A.emp_no, B.pay_de
;
-- 단일행 서브쿼리
-- 비 연관 서브 쿼리 이다.
-- 메인쿼리의 칼럼을 가진다는 거는 위에서 
-- FROM tb_sal_his => B.tb_sal_his 처럼 메인에 있는 B나 A를 쓰는 것을 말한다.

-- 회사 전체 20200525 급여평균
SELECT AVG(pay_amt)
FROM tb_sal_his
WHERE pay_de = '20200525'
;

-- # 다중행 서브쿼리
-- 서브쿼리의 조회 건수가 0건 이상인 것

-- ## 다중행 연산자
-- 1. IN : 메인쿼리의 비교조건이 서브쿼리의 결과중에 하나라도 일치하면 참
-- ex) salary > IN (200, 300, 400)  
    --          250  -> 200, ,300, 400 중에 없으므로 false
    
-- 2. ANY, SUM : 메인쿼리의 비교조건이 서브쿼리의 검색결과 중 하나 이상 일치하면 참
--        ex) salary > ANY (200, 300, 400) = 200 초과 400 미만 은 모두 참    
    --          250  -> 200 보다 크므로 true 
    
-- 3. ALL : 메인쿼리의 비교조건이 서브쿼리의 검색결과와 모두 일치하면 참
--        ex) salary > ALL (200, 300, 400) 
        --     250    -> 200보다는 크지만 300, 400 보다는 크지 않으므로 false
        
-- 4. EXISTS : 메인쿼리의 비교조건이 서브쿼리의 결과 중 만족하는 값이 하나라도 존재하면 참

-- 다중행서브쿼리 예제) 데이터 조회 요구사항
-- 한국데이터베이스 진흥원에서 발급한 자격증을 가지고 있는 
-- 사원의 사원번호와 사원이름과 자격증 개수를 조회

SELECT
  A.emp_no, A.emp_nm, COUNT(b.certi_cd)
FROM tb_emp A, tb_emp_certi B
WHERE A.emp_no = B.emp_no 
AND B.certi_cd IN 
( 
SELECT certi_cd  
FROM tb_certi
WHERE tb_certi.issue_insti_nm = '한국데이터베이스진흥원')
GROUP BY A.emp_no, A.emp_nm
ORDER BY A.emp_no
;
    


SELECT
A.emp_no, A.emp_nm, COUNT(B.certi_cd) "자격증 개수"
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
WHERE B.certi_cd 
= ANY-- 다중행 서브쿼리로 한국데이터베이스진흥원의 자격증 코드를 출력
(
SELECT certi_cd FROM tb_certi WHERE tb_certi.issue_insti_nm = '한국데이터베이스진흥원')
GROUP BY A.emp_no, A.emp_nm -- *그룹바이절에 명시하지 않은 컬럼은 select 절에 나올수 없다.
ORDER BY A.emp_no
;

-- EXISTS문 : 메인쿼리의 비교조건인 서브쿼리의 결과 중 만족하는 값이 하나라도 존재하면 참

-- 주소가 강남인 직원들이 근무하고 있는 부서정보를 조회 (부서코드, 부서명)

SELECT emp_no, emp_nm, addr, dept_cd FROM tb_emp WHERE addr LIKE '%강남%';

SELECT dept_cd, dept_nm 
FROM tb_dept
WHERE dept_cd IN('100009', '100010');

-- ===
SELECT dept_cd, dept_nm 
FROM tb_dept
WHERE dept_cd IN(
SELECT dept_cd FROM tb_emp WHERE addr LIKE '%강남%');

-- ===

SELECT dept_cd, dept_nm 
FROM tb_dept
WHERE EXISTS(
SELECT dept_cd FROM tb_emp WHERE addr LIKE '%강남%');
-- 매칭되는 결과가 하나라도 있을 때 true를 반환하여 
-- SELECT dept_cd, dept_nm 을 모두 조회를 한다.

SELECT A.dept_cd, A.dept_nm 
FROM tb_dept A
WHERE EXISTS(
             SELECT B.dept_cd 
             FROM tb_emp B 
             WHERE addr LIKE '%강남%'
               AND A.dept_cd = B.dept_cd);

-- # 다중 칼럼 서브 쿼리
-- : 서브쿼리의 컬럼이 2개 이상인 서브쿼리

-- 부서원이 2명 이상인 부서중에서 각 부서의 가장 연장자의 사번과 이름
-- 생년월일과 부서코드를 조회

SELECT 
 A.emp_no, A.emp_nm, A.birth_de, A.dept_cd, b.dept_nm 
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = b.dept_cd
WHERE (A.dept_cd, A.Birth_de) IN (
           SELECT
           dept_cd, MIN(birth_de)
           FROM tb_emp
           GROUP BY dept_cd
           HAVING COUNT(*) >= 2 -- 사원이 2명 이상인 부서 골라내기
             )
ORDER BY A.emp_no
;

-- 인라인 뷰 서브쿼리 (FROM절에 쓰는 서브쿼리)

-- 각 사원의 사번과 이름과 평균 급여정보를 조회하고 싶다.

SELECT 
 A.emp_no, A.emp_nm, B.pay_avg
FROM tb_emp A, (
               SELECT
               emp_no,(AVG(pay_amt)) AS pay_avg
               FROM tb_sal_his
               GROUP BY emp_no) B
WHERE A.emp_no = B.emp_no
;

-- #스칼라 서브쿼리 (SELECT절에 쓰는 서브쿼리) 

-- 사원의 사번, 사원명, 부서명, 생년월일, 성병코드를 조회

SELECT 
  A.emp_no
  , A.emp_nm
  ,(SELECT B.dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm
  ,A.birth_de
  ,A.sex_cd
FROM tb_emp A
;



