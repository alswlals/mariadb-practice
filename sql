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

update pet 
	set death = null
    where name = 'Bowser';
    
-- delete: DML(D)
delete from pet where name='마리';

-- load data
load data local infile 'D:\pet.txt' into table pet;

-- select 연습 
select * from pet where name ='bowser';
select name, species from pet where name ='bowser';
select name, species from pet where birth >='1998-01-01';

select name, species, gender
	from pet
    where species = 'dog'
    and gender = 'f';

select name, species, gender
	from pet
    where species = 'snake'
    or species = 'bird';
    
select name, species, birth
	from pet
	order by birth;
    
select name, birth, death
	from pet
    where death is not null;
    
-- 패턴 매칭 예제 (이름 속 단어 포함)
select name
	from pet
    where name like'b%';
   
select name
	from pet
    where name like'%fy';
    
select name
	from pet
    where name like'%w%';
    
-- 글자 수 찾기 는 _ 언더바 한 개당 단어 한 개
select name
	from pet
    where name like'_____';
    
select name
	from pet
    where name like'b____';    
    
-- 집계 ? null이 아닌 개수 출력
select count(*)
	from pet
    where death is not null;
    
