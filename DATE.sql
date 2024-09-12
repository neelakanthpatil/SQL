WITH DT AS(SELECT LEVEL,LEVEL*7,SYSDATE + LEVEL*7 AS DTE FROM DUAL CONNECT BY LEVEL<=366)
    SELECT TO_CHAR(DTE,'DD-MON-YYYY HH24:MI:SS'),
    TO_CHAR(DTE, 'Day')FROM DT WHERE DTE  < ADD_MONTHS(TRUNC(SYSDATE,'Y'),12)-1;
	
WITH DT AS(SELECT TRUNC(SYSDATE,'MM')-1 + LEVEL AS DTE FROM DUAL CONNECT BY LEVEL<=365)
    SELECT DTE,TO_CHAR(DTE,'IW'),TO_CHAR(DTE,'Day'),TO_CHAR(DTE,'Month'),TO_CHAR(DTE,'D') FROM DT;

--DATE, START_OF_WEEK, DAY

select trunc(sysdate,'MM') from dual;
select last_day(sysdate) from dual;
select trunc(sysdate,'Q') from dual;
select TO_CHAR(trunc(sysdate,'Y') + INTERVAL '1' YEAR - 1,'Day') from dual;

select TO_CHAR(sysdate,'YYYY') FROM DUAL;