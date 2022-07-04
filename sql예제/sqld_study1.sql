SELECT * FROM income;
SELECT * FROM expense;

SELECT TO_CHAR(SUM(in_amt), 'L999,999,999') FROM income WHERE in_date < '22-07-01';
SELECT TO_CHAR(SUM(out_amt),'L999,999,999') FROM expense WHERE out_date <'22-07-01';

SELECT TO_CHAR(SUM(A.in_amt) - SUM(B.out_amt), 'L999,999,999') FROM income A, expense B 
WHERE A.in_date < '22-07-01' and B.out_date < '22-07-01';


SELECT * FROM income WHERE in_date < '22-07-01';
SELECT * FROM expense WHERE out_date <'22-07-01';

SELECT * FROM income A, expense B 
WHERE A.in_date < '22-07-01' and B.out_date < '22-07-01';

SELECT
    A.in_sum - B.out_sum AS result    
FROM (
        SELECT SUM(in_amt) in_sum
        FROM income
        WHERE in_date < '22-07-01'
        ) A, 
        (
        SELECT SUM(out_amt) out_sum 
        FROM expense
        WHERE out_date < '22-07-01'
        ) B
    ;

SELECT
   * 
FROM (
        SELECT SUM(in_amt) in_sum
        FROM income
        WHERE in_date < '22-07-01'
        ) A, 
        (
        SELECT SUM(out_amt) out_sum 
        FROM expense
        WHERE out_date < '22-07-01'
        ) B
    ;

