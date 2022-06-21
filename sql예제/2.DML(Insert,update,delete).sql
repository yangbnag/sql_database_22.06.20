
-- DML : 데이터 조작어
-- SELECT, INSERT, UPDATE, DELETE (R C U D) -> (C R U D)
-- SELECT 는 조회 내용을 반환
-- INSERT, UPDATE, DELETE는 데이터를 변환 하고 변환 여부를 TRUE, FALSE로 반환

INSERT INTO board -- 1번 INSERT
   (bno, title, content, wirter, reg_date) -- data를 삽입할 컬럼들을 명시
   
   VALUES 
     (1, '제목이야~', '랄랄랄','둘리', SYSDATE + 1) ; -- 위에 명시한 컬럼 순서대로 데이터 입력 
     
INSERT INTO board --2번 INSERT
-- 삽입 안됨 . title - nn 제약조건 위반
   (bno, content, wirter) 
   
VALUES 
     (1, '랄랄랄', '마이콜' ) ; 
     
INSERT INTO board --3번 INSERT
-- pk의 unique 제약조건 위반
   (bno, title, wirter) 
   
VALUES 
     (1, '랄랄랄', '마이콜' ) ; 
     
INSERT INTO board --4번 INSERT
-- 삽입 가능 // reg-date not null 일지라도 default로 자동 삽입이 되기 때문에.
   (bno, title, wirter) 
   
VALUES 
     (2, '랄랄랄', '마이콜' ) ; 
    

INSERT INTO board 
 --(bno, title, wirter)  -- 컬럼을 명시하지 않을수 있다.
 -- values의 값은 컬럼 순서대로 모두 채워줘야 가능하다.
 
 VALUES
  (3,'제목제목' , '꽥꽥이', '내용내용', SYSDATE + 30);

     
 -- 데이터 수정
 -- ex) title의 내용을 수정
 UPDATE board 
 SET title = '수정된 제목이야~'
 WHERE bno = 3; -- 3번 글을 대상으로 제목을 '수정된 제목이야~' 로 바꿔라
 
 -- 2번글 수정
 UPDATE board
 SET wirter = '수정맨' 
     , content = '메롱메롱메롱 fix'
 WHERE bno = 2;
 
 -- WHERE절 생략시 전체가 수정된다.
 UPDATE board
 SET wirter = '나쁜놈'; 
 
 
 -- 데이터 삭제
 -- 1번 글 삭제
 DELETE FROM board
 WHERE bno = 1; -- WHERE 절을 생략하면 TRUNCATE 처럼 모두 삭제
                -- DELETE 는 ROLLBACK이 되지만 TRUNCATE는 ROLLBACK이 안됨!
                

-- 전체 데이터 삭제
--   1. WHERE절을 생략한 DELETE절 (롤백 가능, 수동커밋 가능, 로그남기기 가능)

-- 게시물을 전부 지우고 싶다.!
DELETE FROM board;

--   2.TRUNCATE TABLE (롤백 불가능, 자동커밋, 로그를 남길 수 없음, 테이블 생성 초기상태로 복귀)

TRUNCATE TABLE board;

--   3. DROP TABEL (롤백 불가능, 자동커밋, 로그를 남길 수 없음, 테이블 구조가 완전 삭제됨) 
DROP TABLE board;


 
 
ROLLBACK;
COMMIT;        
SELECT * FROM board;