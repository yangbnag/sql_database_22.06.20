
-- DML : ������ ���۾�
-- SELECT, INSERT, UPDATE, DELETE (R C U D) -> (C R U D)
-- SELECT �� ��ȸ ������ ��ȯ
-- INSERT, UPDATE, DELETE�� �����͸� ��ȯ �ϰ� ��ȯ ���θ� TRUE, FALSE�� ��ȯ

INSERT INTO board -- 1�� INSERT
   (bno, title, content, wirter, reg_date) -- data�� ������ �÷����� ���
   
   VALUES 
     (1, '�����̾�~', '������','�Ѹ�', SYSDATE + 1) ; -- ���� ����� �÷� ������� ������ �Է� 
     
INSERT INTO board --2�� INSERT
-- ���� �ȵ� . title - nn �������� ����
   (bno, content, wirter) 
   
VALUES 
     (1, '������', '������' ) ; 
     
INSERT INTO board --3�� INSERT
-- pk�� unique �������� ����
   (bno, title, wirter) 
   
VALUES 
     (1, '������', '������' ) ; 
     
INSERT INTO board --4�� INSERT
-- ���� ���� // reg-date not null ������ default�� �ڵ� ������ �Ǳ� ������.
   (bno, title, wirter) 
   
VALUES 
     (2, '������', '������' ) ; 
    

INSERT INTO board 
 --(bno, title, wirter)  -- �÷��� ������� ������ �ִ�.
 -- values�� ���� �÷� ������� ��� ä����� �����ϴ�.
 
 VALUES
  (3,'��������' , '�в���', '���볻��', SYSDATE + 30);

     
 -- ������ ����
 -- ex) title�� ������ ����
 UPDATE board 
 SET title = '������ �����̾�~'
 WHERE bno = 3; -- 3�� ���� ������� ������ '������ �����̾�~' �� �ٲ��
 
 -- 2���� ����
 UPDATE board
 SET wirter = '������' 
     , content = '�޷ո޷ո޷� fix'
 WHERE bno = 2;
 
 -- WHERE�� ������ ��ü�� �����ȴ�.
 UPDATE board
 SET wirter = '���۳�'; 
 
 
 -- ������ ����
 -- 1�� �� ����
 DELETE FROM board
 WHERE bno = 1; -- WHERE ���� �����ϸ� TRUNCATE ó�� ��� ����
                -- DELETE �� ROLLBACK�� ������ TRUNCATE�� ROLLBACK�� �ȵ�!
                

-- ��ü ������ ����
--   1. WHERE���� ������ DELETE�� (�ѹ� ����, ����Ŀ�� ����, �α׳���� ����)

-- �Խù��� ���� ����� �ʹ�.!
DELETE FROM board;

--   2.TRUNCATE TABLE (�ѹ� �Ұ���, �ڵ�Ŀ��, �α׸� ���� �� ����, ���̺� ���� �ʱ���·� ����)

TRUNCATE TABLE board;

--   3. DROP TABEL (�ѹ� �Ұ���, �ڵ�Ŀ��, �α׸� ���� �� ����, ���̺� ������ ���� ������) 
DROP TABLE board;


 
 
ROLLBACK;
COMMIT;        
SELECT * FROM board;