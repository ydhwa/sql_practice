-- serial vs sequence
create table t1(
	c1 serial
);
insert into t1 values(default);
select * from t1;

create sequence t2_seq;
create table t2(
	c2 int not null default nextval('t2_seq')
);
alter sequence t2_seq owned by t2.c2;
insert into t2 values(default);
select * from t2;



-- char vs varchar
create table t3(
	c3 char(4)
);
insert into t3 values('ok');
-- insert into t3 values('too long');
select c3, char_length(c3) from t3;

-- varchar는 blank가 초과해서 들어가 있을 경우 무시하고, 데이터가 길이를 초과하면 오류가 난다.
create table t4(
	c4 varchar(5)
);
insert into t4 values('ok');
insert into t4 values('good            ');
insert into t4 values('too long'::varchar(5));
select c4, char_length(c4) from t4;



-- enum
create type mood as enum('sad', 'ok', 'happy');
create table person(
	name varchar(10),
	current_mood mood
);

insert into person values('you', 'happy');
insert into person values('me', 'ok');
select * from person;
select * from person where current_mood > 'ok';



-- json
select '{"result": "success", "data": 1}'::json;

create table t5(
	response json
);

insert into t5 values('{"result": "success", "data": 2}');
select * from t5;



-- DDL 연습
drop table member1;
create table member1(
	no int,
	email varchar(50) not null default '',
	password varchar(20) not null,
	name varchar(25),
	dept_name varchar(25),
	primary key(no)
);

-- 새 컬럼 추가
alter table member1 add juminbunho char(13) not null;
alter table member1 add join_date timestamp not null;
-- 칼럼 삭제
alter table member1 drop juminbunho;

-- 컬럼 타입 변경
-- using [형변환]은 데이터가 이미 들어있을 경우 타입 변환을 해주는 것임
alter table member1 alter column no type bigint using no::bigint;

-- not null 설정
alter table member1 alter column no set not null;
alter table member1 alter column dept_name set not null;

-- not null 설정 해제
alter table member1 alter column dept_name drop not null;

-- default 세팅
create sequence member_seq;
alter table member1 alter column no set default nextval('member_seq');

-- 컬럼 이름 변경
alter table member1 rename column dept_name to department_name;

-- 테이블 이름 변경
alter table member1 rename to member2;

