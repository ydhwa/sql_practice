-- DDL
drop table member;

create table member(
	no int not null auto_increment,
    email varchar(50) not null default '',
    passwd varchar(64) not null,
    name varchar(25),
    dept_name varchar(25),
    primary key (no)
);

desc member;

insert
into member(passwd, name, dept_name)
values(password('1234'), '양동화', '개발팀');

select * from member;

-- 테이블 수정 - 컬럼 추가, 삭제. 위치는 after로 조정
alter table member add juminbunho char(13) not null after no;
alter table member drop juminbunho;
alter table member add joindate datetime not null;

-- 테이블 수정 - 컬럼 수정
alter table member change no no int unsigned not null auto_increment;
alter table member change dept_name department_name varchar(25);
alter table member change name name varchar(10);
-- 테이블 수정 - 테이블명 수정
alter table member rename user;
desc user;

insert
into user
values(null, '', password('1234'), '양동화2', '데이터분석팀', now());
insert
into user(joindate, name, passwd, department_name)
values(now(), '양동화', password('1234'), '개발팀');

-- update는 하나가 끝나면 다음 것이 실행되도록 하여 롤백이 가능하도록(=트랜잭션 성립) 만드는 것이 좋다.
-- 아래와 같은 서브쿼리 형태는 괜찮다.
update user
set joindate = (select now())
where no = 1;

update user
set joindate = now(), name = 'Yang DH'
where no = 1;

delete
from user
where no = 1;

select * from user;