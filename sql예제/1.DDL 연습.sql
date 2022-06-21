
 -- DDL : 데이터 정의어
 -- CREATE, ALTER, DROP, RENAME, TRUNCATE
 
 -- CREATE TABLE : 테이블 생성
 -- 게시판 정보를 저장할 테이블 생성 (명령어는 대문자를 권고함)
 
 DROP TABLE board;
 
 CREATE TABLE board (
     bno NUMBER(10)  -- NOT NULL 꼭기재 / UNIQUE 중복 배제
     , title VARCHAR2(200)NOT NULL 
     , wirter VARCHAR2(40) NOT NULL -- UNIQUE제한을 걸면 한 사람이 여러 글을 못쓰게 됨.
     , content CLOB -- VARCHAR2 4000BYTE 제한 
     , reg_date DATE DEFAULT SYSDATE -- 글이 작성된 현재시간이 자동으로 입력됨.
     , view_count NUMBER(10) DEFAULT 0 -- 조회수 처음에 0으로 설정
 
 );
 
 -- bno 컬럼 수정 UNIQUE 제한 해제
 -- ALTER TABLE board
 -- MODIFY(bno NUMBER(10));
 
  -- ALTER : 데이터베이스의 구조를 변경 [현재 상황 : 프라이머리키를 부여하지 않았음.]
  -- PK 설정 / 통째로 외울것
  ALTER TABLE board
  ADD CONSTRAINT pk_board_bno -- 제한 조건을 추가한다. [pk_board_bno 별칭]
  PRIMARY KEY(bno);
  
  -- 데이터 추가 1
  INSERT INTO board
  (bno, title, wirter, content)
  VALUES
   (1,'안뇽?', '꾸꾸까까', '아하하아하하 ㅋㅋㅋ');
   
    -- 데이터 추가 2
  INSERT INTO board
  (bno, title, wirter)
  VALUES
   (2,'맛있는 점심','꾸꾸까까'); -- PK는 중복을 허용하지 않는다.
                                 -- writer 의 제한이 not null 이므로 에러 발생
                                 -- content 는 없어도 행추가 된다.
                                            
   
   COMMIT;
  
 
 
 SELECT * FROM board;
 -- ======================= 2교시 ====================
 -- 연관관계 설정
 -- 게시물과 댓글의 관계 
 --    1  :  M
 
 -- 댓글 테이블 생성 
 CREATE TABLE REPLY(
   rno NUMBER(10) -- 댓글번호
   ,r_content VARCHAR2(400) -- 댓글내용
   ,r_writer VARCHAR2(40) NOT NULL
   , bno NUMBER(10) -- *부모 테이블의 PK이를 가지고 있어야 한다.*
                    -- foreing key 설정이 안된 상태.
   , CONSTRAINT pk_reply_rno PRIMARY KEY(rno) --PK 설정 
 );
 
  -- 외래키 설정 (FOREING KEY) : 테이블 간의 관계 제약 설정
  ALTER TABLE reply
  ADD CONSTRAINT fk_reply_bno -- reply에 fk를 설정한다.
  FOREIGN KEY(bno) -- bno를 reply의 fk로 설정하겠다.
  REFERENCES board (bno); -- 참조는 board 테이블의 bno
  
  -- 컬럼 변경
  -- 컬럼 추가
  -- ex) 댓글 테이블에 날짜를 넣고 싶다.
  ALTER TABLE reply
  ADD (r_reg_date DATE DEFAULT SYSDATE);
  
  SELECT
      * FROM reply;
 
 -- 컬럼 제거
 ALTER TABLE board
 DROP COLUMN view_count; -- board에 view_count 컬럼을 제거 하고 싶다.
 
 -- 컬럼 수정
 -- ex) board 테이블에 title 글자입력수제한을 200byte에서 500byte로 수정
 ALTER TABLE board
 MODIFY(title VARCHAR2(500)
 
   SELECT
      * FROM board;

-- 테이블 삭제
DROP TABLE reply; -- 테이블 구조 삭제

TRUNCATE TABLE board; --  테이블 내부 전체 삭제 - 롤백 불가

SELECT * FROM board;
      
      
  
 
 
 