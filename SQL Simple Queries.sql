--SELECT COUNT(*) FROM HR.EMPLOYEES--107
--SELECT COUNT(*) FROM SCOTT.EMP--14


1. Self Join
SELECT COUNT(*) FROM SCOTT.EMP, SCOTT.EMP -->196 Rows

2. Second Highest Salary
SELECT   MAX(SAL) FROM SCOTT.EMP WHERE SAL <> (SELECT MAX(SAL) FROM SCOTT.EMP)

--All Records
SELECT * FROM SCOTT.EMP WHERE SAL IN(SELECT MAX(SAL) FROM SCOTT.EMP WHERE SAL <> (SELECT MAX(SAL) FROM SCOTT.EMP));

3. Sub Query
SELECT * FROM SCOTT.EMP WHERE SAL > (SELECT ROUND(AVG(SAL)) FROM SCOTT.EMP)
IN, NOT IN, >,>=,<,<=,=

4. Correlated Query
SELECT * FROM SCOTT.EMP A WHERE EXISTS(SELECT SAL FROM SCOTT.EMP B WHERE A.EMPNO = B.EMPNO)
SELECT * FROM SCOTT.EMP A WHERE NOT EXISTS(SELECT SAL FROM SCOTT.EMP B WHERE A.EMPNO = B.EMPNO)

5. Find second highest salary.
SELECT * FROM (
SELECT EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO, ROW_NUMBER() OVER(ORDER BY SAL DESC) AS RNUM FROM SCOTT.EMP)
WHERE RNUM = 2;

SELECT A.* FROM (
SELECT SAL, ROWNUM r FROM(
SELECT DISTINCT SAL FROM SCOTT.EMP ORDER BY SAL DESC)) A
WHERE A.r = 2;

SELECT * FROM(
SELECT SAL, RANK() OVER(ORDER BY SAL DESC) AS RNK,
DENSE_RANK() OVER(ORDER BY SAL DESC) AS DRNK
 FROM SCOTT.EMP)
WHERE DRNK = 2

select MIN(SAL) as SecondMax from TEMP_EMP where SAL !=(select MIN(SAL) from TEMP_EMP)

SELECT * FROM HR.EMPLOYEES A WHERE 2 = (SELECT COUNT(DISTINCT SALARY) FROM HR.EMPLOYEES B WHERE A.SALARY <= B.SALARY)

6. Delete Duplicate rows:
SELECT * FROM SCOTT.EMP A WHERE 1 = (SELECT COUNT(DISTINCT SAL) FROM SCOTT.EMP B WHERE A.SAL <= B.SAL)

SELECT * FROM EMP_T WHERE ROWID NOT IN (SELECT MAX(ROWID) FROM EMP_T GROUP BY EMPNO, ENAME, JOB, SAL, DEPTNO)

SELECT * FROM EMP_T A WHERE ROWID > (SELECT MIN(ROWID) FROM EMP_T B WHERE A.EMPNO=B.EMPNO AND A.ENAME=B.ENAME AND A.JOB=B.JOB AND A.SAL=B.SAL AND  A.DEPTNO=B.DEPTNO)


SELECT EMPNO, ENAME, JOB, SAL, DEPTNO, COUNT(*) FROM EMP_T
GROUP BY EMPNO, ENAME, JOB, SAL, DEPTNO
HAVING COUNT(*) > 1

select * from emp_T where rowid IN(
SELECT ROWID from(
SELECT ROWID, ROW_NUMBER() OVER(PARTITION BY EMPNO, ENAME, JOB, SAL, DEPTNO ORDER BY EMPNO, ENAME, JOB, SAL, DEPTNO) AS RNK FROM EMP_T)
where rnk != 1)

7. Find DISTINCT Records without using DISTINCT Keyword in the query.
select UNIQUE ROLL_NO, STU_NAME from Student_list
order by ROLL_NO, STU_NAME

select  ROLL_NO, STU_NAME from Student_list
group by ROLL_NO, STU_NAME
order by ROLL_NO, STU_NAME;

SELECT ROLL_NO, STU_NAME FROM STUDENT_LIST
UNION
SELECT ROLL_NO, STU_NAME FROM STUDENT_LIST 

SELECT ROLL_NO, STU_NAME FROM STUDENT_LIST
UNION
SELECT NULL, NULL FROM DUAL WHERE 1 = 2 

SELECT ROLL_NO, STU_NAME FROM STUDENT_LIST
INTERSECT
SELECT ROLL_NO, STU_NAME FROM STUDENT_LIST

SELECT ROLL_NO, STU_NAME FROM STUDENT_LIST
MINUS
SELECT NULL,NULL FROM DUAL

SELECT ROLL_NO, STU_NAME FROM(
SELECT ROLL_NO, STU_NAME, ROW_NUMBER() OVER(PARTITION BY ROLL_NO, STU_NAME ORDER BY ROLL_NO, STU_NAME) AS RNUM FROM STUDENT_LIST)
WHERE RNUM = 1;

SELECT ROLL_NO, STU_NAME FROM(
SELECT ROLL_NO, STU_NAME, RANK() OVER(PARTITION BY ROLL_NO, STU_NAME ORDER BY ROWNUM) AS RNUM FROM STUDENT_LIST)
WHERE RNUM = 1;

SELECT ROLL_NO, STU_NAME FROM STUDENT_LIST WHERE ROWID   IN (
    SELECT MIN(ROWID) FROM STUDENT_LIST GROUP BY ROLL_NO, STU_NAME);
	
SELECT ROLL_NO, STU_NAME FROM STUDENT_LIST A 
WHERE 1 = (SELECT COUNT(1) FROM STUDENT_LIST B WHERE A.ROLL_NO=B.ROLL_NO AND A.STU_NAME=B.STU_NAME
AND A.ROWID>=B.ROWID)
-----------------------------------------------------------
CREATE TABLE int_orders(
 order_number int NOT NULL,
 order_date date NOT NULL,
 cust_id int NOT NULL,
 salesperson_id int NOT NULL,
 amount float NOT NULL)
 
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (30, TO_DATE('1995-07-14','YYYY-MM-DD'), 9, 1, 460);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (10, TO_DATE('1996-08-02','YYYY-MM-DD'), 4, 2, 540);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (40, TO_DATE('1998-01-29','YYYY-MM-DD'), 7, 2, 2400);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (50, TO_DATE('1998-02-03','YYYY-MM-DD'), 6, 7, 600);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (60, TO_DATE('1998-03-02','YYYY-MM-DD'), 6, 7, 720);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (70, TO_DATE('1998-05-06','YYYY-MM-DD'), 9, 7, 150);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (20, TO_DATE('1999-01-30','YYYY-MM-DD'), 4, 8, 1800);

select * from int_orders;

select sum(amount) from int_orders;

select salesperson_id, sum(amount) from int_orders
group by salesperson_id;

select order_number, order_date, cust_id, salesperson_id, sum(amount) over()
from int_orders;

select order_number, order_date, cust_id, salesperson_id, sum(amount) over(partition by salesperson_id)
from int_orders;

select order_number, order_date, cust_id, salesperson_id, sum(amount) over(partition by salesperson_id order by order_date)
from int_orders;

select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date)
from int_orders;

select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date rows between 2 preceding and current row)
from int_orders;

select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date rows between 2 preceding and 1 preceding)
from int_orders;

select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date rows between 1 preceding and 1 following)
from int_orders;

select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date rows between unbounded preceding and current row)
from int_orders;