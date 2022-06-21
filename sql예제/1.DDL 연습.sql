
 -- DDL : ������ ���Ǿ�
 -- CREATE, ALTER, DROP, RENAME, TRUNCATE
 
 -- CREATE TABLE : ���̺� ����
 -- �Խ��� ������ ������ ���̺� ���� (��ɾ�� �빮�ڸ� �ǰ���)
 
 DROP TABLE board;
 
 CREATE TABLE board (
     bno NUMBER(10)  -- NOT NULL ������ / UNIQUE �ߺ� ����
     , title VARCHAR2(200)NOT NULL 
     , wirter VARCHAR2(40) NOT NULL -- UNIQUE������ �ɸ� �� ����� ���� ���� ������ ��.
     , content CLOB -- VARCHAR2 4000BYTE ���� 
     , reg_date DATE DEFAULT SYSDATE -- ���� �ۼ��� ����ð��� �ڵ����� �Էµ�.
     , view_count NUMBER(10) DEFAULT 0 -- ��ȸ�� ó���� 0���� ����
 
 );
 
 -- bno �÷� ���� UNIQUE ���� ����
 -- ALTER TABLE board
 -- MODIFY(bno NUMBER(10));
 
  -- ALTER : �����ͺ��̽��� ������ ���� [���� ��Ȳ : �����̸Ӹ�Ű�� �ο����� �ʾ���.]
  -- PK ���� / ��°�� �ܿ��
  ALTER TABLE board
  ADD CONSTRAINT pk_board_bno -- ���� ������ �߰��Ѵ�. [pk_board_bno ��Ī]
  PRIMARY KEY(bno);
  
  -- ������ �߰� 1
  INSERT INTO board
  (bno, title, wirter, content)
  VALUES
   (1,'�ȴ�?', '�ٲٱ��', '�����Ͼ����� ������');
   
    -- ������ �߰� 2
  INSERT INTO board
  (bno, title, wirter)
  VALUES
   (2,'���ִ� ����','�ٲٱ��'); -- PK�� �ߺ��� ������� �ʴ´�.
                                 -- writer �� ������ not null �̹Ƿ� ���� �߻�
                                 -- content �� ��� ���߰� �ȴ�.
                                            
   
   COMMIT;
  
 
 
 SELECT * FROM board;
 -- ======================= 2���� ====================
 -- �������� ����
 -- �Խù��� ����� ���� 
 --    1  :  M
 
 -- ��� ���̺� ���� 
 CREATE TABLE REPLY(
   rno NUMBER(10) -- ��۹�ȣ
   ,r_content VARCHAR2(400) -- ��۳���
   ,r_writer VARCHAR2(40) NOT NULL
   , bno NUMBER(10) -- *�θ� ���̺��� PK�̸� ������ �־�� �Ѵ�.*
                    -- foreing key ������ �ȵ� ����.
   , CONSTRAINT pk_reply_rno PRIMARY KEY(rno) --PK ���� 
 );
 
  -- �ܷ�Ű ���� (FOREING KEY) : ���̺� ���� ���� ���� ����
  ALTER TABLE reply
  ADD CONSTRAINT fk_reply_bno -- reply�� fk�� �����Ѵ�.
  FOREIGN KEY(bno) -- bno�� reply�� fk�� �����ϰڴ�.
  REFERENCES board (bno); -- ������ board ���̺��� bno
  
  -- �÷� ����
  -- �÷� �߰�
  -- ex) ��� ���̺� ��¥�� �ְ� �ʹ�.
  ALTER TABLE reply
  ADD (r_reg_date DATE DEFAULT SYSDATE);
  
  SELECT
      * FROM reply;
 
 -- �÷� ����
 ALTER TABLE board
 DROP COLUMN view_count; -- board�� view_count �÷��� ���� �ϰ� �ʹ�.
 
 -- �÷� ����
 -- ex) board ���̺� title �����Է¼������� 200byte���� 500byte�� ����
 ALTER TABLE board
 MODIFY(title VARCHAR2(500)
 
   SELECT
      * FROM board;

-- ���̺� ����
DROP TABLE reply; -- ���̺� ���� ����

TRUNCATE TABLE board; --  ���̺� ���� ��ü ���� - �ѹ� �Ұ�

SELECT * FROM board;
      
      
  
 
 
 