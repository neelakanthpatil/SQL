WITH NUM_SEQ AS(SELECT LEVEL NUM FROM DUAL CONNECT BY LEVEL<=100)
SELECT LISTAGG(NUM,'&')
    WITHIN GROUP(ORDER BY NUM)
    FROM NUM_SEQ NUM1 WHERE NUM!=1
AND NOT EXISTS(SELECT 1 FROM NUM_SEQ NUM2
    WHERE NUM != 1
    AND NUM1.NUM!=NUM2.NUM
    AND MOD(NUM1.NUM,NUM2.NUM)=0)
--------------------------------------------------
	with t1 as(select level num from dual connect by level<=100)
select listagg(num,',') within group(order by num) from t1
where NUM!=1 and not exists(select t2.num from t1 t2
    			where t2.num <> 1
     			and t1.num!=t2.num
    			and mod(t1.num,t2.num)=0);
------------------------------------------------------------------------
with num_seq  as (select level num from dual connect by level<=100)
select listagg(num,'&')  within group(order by ns1.num) from num_seq ns1
where ns1.num!=1 and 
    not exists (select 1 from num_seq ns2 where ns2.num!=1 and ns1.num!=ns2.num and mod(ns1.num,ns2.num)=0);