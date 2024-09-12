Select match_number, runs_scored,status,rsum,round(total_score/cnt,2) as avg_score from (select match_number, runs_scored,status,
    sum(runs_scored) over(order by match_number) as RSUM,
    sum(case when status='out' then 1 else 0 end) over() as cnt,
    sum(runs_scored) over() as total_score
    from input_1)
where RSUM >=500 and rownum=1;
--------------------------------------------------------------
create table input_1
(match_number NUMBER,
runs_scored NUMBER,
status varchar2(10));

insert into input_1 values (10,25,'out'); 
insert into input_1 values (9,93,'out'); 
insert into input_1 values (8,149,'out'); 
insert into input_1 values (7,73,'out'); 
insert into input_1 values (6,39,'out'); 
insert into input_1 values (5,0,'out'); 
insert into input_1 values (4,29,'out'); 
insert into input_1 values (3,113,'out'); 
insert into input_1 values (2,59,'not out'); 
insert into input_1 values (1,53,'out');