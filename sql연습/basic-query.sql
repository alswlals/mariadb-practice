select version(), current_date(), now() from dual;

-- 수학 함수, 사칙 연산도 된다.
select sin(pi() / 4), 1 + 2 * 3 / 4 - 5 from dual;

-- 대소문자 구분 안 한다.
seLECt Version(), CURrent_DATE(), now() frOm DuaL;

-- table 생성: DML
create table pet (
	name varchar(100), 
    owner varchar(20),
    species varchar(20),
    gender char(1),
    birth date,
    death date
);

-- schema 확인
desc pet;
describe pet;

-- table 삭제
drop table pet;
show tables;

-- insert : DML(C)
insert into pet values('마루', '언니', 'dog', 'f', '2021-01-01', null);

-- select: DML(R)
select * from pet;

-- update: DML(U)
update pet
	set name='귀염둥이 마루' 
    where name='마루';

-- delete: DML(D)
delete from pet where name='마리';

-- load data
load data local infile 'D:\pet.txt' into table pet;

-- select 
select * from pet where name ='bowser';
select name, species from pet where name ='bowser';
