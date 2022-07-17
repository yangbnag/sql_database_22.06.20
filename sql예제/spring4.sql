SELECT * FROM board;

UPDATE board SET view_cnt = view_cnt+1 where board_no = 1;

 UPDATE board SET view_cnt = view_cnt+1 where board_no = 11 ;
 
 commit;

