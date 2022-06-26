
SELECT DISTINCT
 SUBSTR(emp_nm,1,1)  성씨
FROM tb_emp;

 -- 집계 함수(다중행 함수)
 -- : 여러 행을 묶어서 함수를 적용
 
 SELECT * FROM tb_sal_his;

 -- 1행 2019.02.25에 5번 사원이 5,620,000 을 수령했다.
 
 -- 5번 사원의 월급 수령 내역 확인
 SELECT * FROM tb_sal_his 
 WHERE emp_no = '1000000005';
 
 -- 5번 사원의 총 월급 수령액과 월급의 평균액, 제일 많은 월급과 제일 적은 월급
 -- 그리고 5번 사원뿐만 아니라 전체 사원에 대해서 위에 데이터들을 추출하고 싶을때..
 
 SELECT
 
    SUM(pay_amt) "지급 총액" -- 다중행 함수이다.
   ,SUM(pay_amt) "평균 지급액" -- GROUP BY로 소그룹화 하지 않으면 집계 함수는 전체행수를 기준으로 집계한다.
   ,COUNT(pay_amt) "지급 횟수"
   -- ,emp_no -- 행수 매칭이 되지 않는다. 984개의 그룹이다.
   
 FROM tb_sal_his
 ;
 
SELECT * FROM tb_emp; -- 41행
 
 SELECT
     COUNT(emp_nm) "총 사원수" -- 중복을 건너뛰지 않는다.
     ,MAX(birth_de) "최연소자의 생일" -- 41개의 생일 중에 최소값 1개
     ,MIN(birth_de) "최연장자의 생일" -- 41개의 생일 중에서 최댓값 1개
     -- 그룹화 하지 않으면 전체를 기준으로 집계함수가 실행된다.
     
     ,COUNT(direct_manager_emp_no) 
     ,COUNT(*) 주의
      -- 모든 집계 함수는 특정 컬럼이나 표현식을 넣으면 NULL은 세지 않는다.
      -- 예외 COUNT(*)은 NULL도 다 센다. 주의!!
 FROM tb_emp;

-- ==========================================================================--

-- GROUP BY : 지정된 컬럼으로 소그룹화 한 후 집계함수 적용
-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일 부서별 총 사원 수를 조회

SELECT * FROM tb_emp
ORDER BY dept_cd
; -- 그룹 코드별로 묶은 후 아래 내용을 조회 해야지 위에서 원하는 대로 조회 할수 있다.

SELECT
 -- emp_nm -- 사원의 이름은 41개 이므로 14개의 
        --그룹으로 조회된 데이터와 일치하지 않아 조회 불가능
        
  dept_cd 부서코드 -- 그룹 바이에서 지정한 컬럼은 조회 가능      
 ,MAX(birth_de) 최연소자
 ,MIN(birth_de) 최연장자
 ,COUNT(emp_no) 직원수
FROM tb_emp
GROUP BY dept_cd
ORDER BY dept_cd
;

 -- 사원별 누적 급여수령액 조회
SELECT 
  emp_no
  ,SUM(pay_amt) "누적 수령액"

FROM tb_sal_his
GROUP BY emp_no -- group by는 where절 뒤에 order by 전에 위치 해야함.
ORDER BY emp_no
;



-- 사원별로 급여를 제일 많이 받았을 때, 제일 적게 받았을때, 평균적으로 얼마 받았는지 조회
SELECT
  emp_no
  , TO_CHAR(MAX(pay_amt),'L999,999,999') "최고 수령액"
  , TO_CHAR(MIN(pay_amt),'L999,999,999') "최저 수령액"
  , TO_CHAR(ROUND(AVG(pay_amt),2),'L999,999,999.99' )"평균 수령액" 
  -- 통계를 낸 데이터를 단일화 함수로 적용시키는 것은 가능

FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no;

SELECT * FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
ORDER BY emp_no, pay_de
;


-- 2019년에 사원별로 급여를 제일 많이 받았을 때, 제일 적게 받았을때, 평균적으로 얼마 받았는지 조회
 -- 그룹화 하기전에 정보를 제한한후 진행 해야 한다.
 -- WHERE는 그룹화 하기전에 정보를 추출해놓는다.
SELECT
  emp_no
  , TO_CHAR(MAX(pay_amt),'L999,999,999') "최고 수령액"
  , TO_CHAR(MIN(pay_amt),'L999,999,999') "최저 수령액"
  , TO_CHAR(ROUND(AVG(pay_amt),2),'L999,999,999.99' )"평균 수령액" 
  , TO_CHAR(SUM(pay_amt),'L999,999,999') "2019년 연봉"
  -- 통계를 낸 데이터를 단일화 함수로 적용시키는 것은 가능

FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
ORDER BY emp_no
;

-- ============================ 여기까지

-- HAVING : 그룹화된 결과에서 조건을 걸어 행 수를 제한

-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일, 부서별 총 사원 수를 조회
-- 그런데 부서별 사원이 1명인 부서의 정보는 조회화고 싶지 않음.
-- WHERE 이후 ORDER BY 이전에 HAVING을 작성

SELECT
  dept_cd 부서코드 
 ,MAX(birth_de) 최연소자
 ,MIN(birth_de) 최연장자
 ,COUNT(emp_no) 직원수
FROM tb_emp
GROUP BY dept_cd
HAVING COUNT(emp_no)>1 --사원수가 1명보다는 커야되요~
ORDER BY dept_cd
;

-- 사원별로 급여를 제일 많이 받았을 때, 제일 적게 받았을때, 평균적으로 얼마 받았는지 조회
-- 그룹화 이후에 평균 급여가 450만원 이상인 사람만 조회
SELECT
  emp_no "사번"
  , TO_CHAR(MAX(pay_amt),'L999,999,999') "최고 수령액"
  , TO_CHAR(MIN(pay_amt),'L999,999,999') "최저 수령액"
  , TO_CHAR(ROUND(AVG(pay_amt),2),'L999,999,999.99' )"평균 수령액" 

FROM tb_sal_his
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no;

-- 사원별로 2019년 평균 수령액이 450만원 이상인 사원의 2019년 연봉 조회
SELECT
  emp_no "사번"
  , SUM(pay_amt)

FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no;

-- 
-- 그룹화를 할때 컬럼이 2개이면?
 SELECT
  emp_no
  ,sex_cd
  ,dept_cd
 FROM tb_emp
 ORDER BY dept_cd
 ;
SELECT
  
    dept_cd
    , COUNT(*)

FROM tb_emp
GROUP BY dept_cd, sex_cd 
ORDER BY dept_cd
;

--============ 여기 까지

-- ORDER BY : 정렬
-- ASC : 오름차 정렬 (기본값), DESC 내림차 정렬
-- 항상 SELECT절의 맨 마지막에 위치

SELECT
emp_no
,emp_nm
,addr
FROM tb_emp
ORDER BY  emp_nm DESC
;

SELECT
emp_no
,emp_nm
,dept_cd
FROM tb_emp
ORDER BY  dept_cd,emp_nm DESC -- 부서코드로 정렬 + 부서간에는 emp_no로 정렬
; 

SELECT
emp_no 사번 -- 1 컬럼 번호가 묵시적으로 들어가 있음.
,emp_nm 이름 -- 2 
,addr 주소 -- 3
FROM tb_emp
ORDER BY 1 DESC, 이름 -- 정렬시 별칭 사용 가능
;


-- 사원별로 2019년 평균 수령액이 450만원 이상인 사원의 2019년 연봉 조회
SELECT
  emp_no "사번"
  , SUM(pay_amt) 연봉

FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY 연봉 DESC
;
 
 