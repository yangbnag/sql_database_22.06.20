
select * from tbl_score;



CREATE SEQUENCE seq_board;

DROP TABLE board;
CREATE TABLE board (
    board_no NUMBER(10),
    writer VARCHAR2(20) NOT NULL,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(2000),
    view_cnt NUMBER(10) DEFAULT 0,
    reg_date DATE DEFAULT SYSDATE,
    CONSTRAINT pk_board PRIMARY KEY (board_no)
);

INSERT INTO board 
(board_no, writer, title, content)
VALUES (seq_board.nextval, '²Ü²ÜÀÌ','¾ÆÄ§¹ä¸ÔÀÚ' ,'¾ÆÄ§¿¡´Â µÎ³¢- ºí¶óºí¶ó');

commit;

SELECT * FROM board;

