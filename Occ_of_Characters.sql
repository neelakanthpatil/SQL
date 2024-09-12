--Occurance of characters

select NAME_STRING, 
    REGEXP_REPLACE(NAME_STRING,'an','') "Replaced_Name",
    REGEXP_COUNT(NAME_STRING,'an') "Occurance_Count"
    from strings;

---------------------------------------------------------------
create table strings(name_string varchar2(30));

insert into strings values ('Ankit Bansal');
insert into strings values ('Utkarsh Choubey');
insert into strings values ('Mahendra Damodar Das Modi');
insert into strings values ('Mukesh Ambani');
insert into strings values ('Venkata Sai Laxman');
insert into strings values ('virat');
insert into strings values ('Mahendra Singh Dhoni');
insert into strings values ('Sanjay Ajay Vijay Parajay');
INSERT INTO strings values ('Bansal Bansal');
--------------------------------------------------------------