-- book_db 데이타베이스 생성
create database book_db
	default character set utf8mb4	-- 이모티콘사용 캐릭터셋
    collate utf8mb4_general_ci		-- 정렬 규칙
    default encryption = 'n'		-- 암호화 no (기본값 생략가능)
;

-- 데이터베이스 생성 확인
show databases;

-- 데이터베이스 선택
use book_db;

-- 테이블 생성
create table book(
	book_id	int	auto_increment primary key
   ,title varchar(100) not null
   ,pubs varchar(100)
   ,pub_date datetime
   ,author_id int,
   constraint book_fk foreign key(author_id)
   references author(author_id)
);

create table author(
	author_id int auto_increment primary key
   ,author_name varchar(100) not null
   ,author_desc varchar(500) 
);

-- 생성된 테이블 확인
show tables;

-- author table 정보 추가
-- inser into author() values();

insert into author
values(null,'김문열','경북 영양');

insert into author
values(null,'박경리','경상남도 통영');

insert into author
values(null,'유시민','17대 국회의원');

insert into author
values(null,'기안84','기안동에서 산 84년생');

insert into author
values(null,'강풀','온라인 만화가 1세대');

insert into author
values(null,'김영하','알쓸신잡');

select * from author;

-- book table 정보 추가
-- inser into book() values();

insert into book
values(null,'우리들의 일그러진 영웅','다림','1998-02-22',1);

insert into book
values(null,'삼국지','민음사','2002-03-01',1);

insert into book
values(null,'토지','마로니에북스','2012-08-15',2);

insert into book
values(null,'유시민의 글쓰기 특강','생각의길','2015-04-01',3);

insert into book
values(null,'패션왕','중앙북스(books)','2012-02-22',4);

insert into book
values(null,'순정만화','재미주의','2011-08-03',5);

insert into book
values(null,'오직두사람','문학동네','2017-05-04',6);

insert into book
values(null,'26년','재미주의','2012-02-04',5);

select * from book;

-- ppt05-34 실습예제
-- 데이터베이스 book_db , 계정 book 으로 접속
-- book_id / title / pubs / pub_date / author_id / author_name / author_desc 출력
-- 출력후 강풀의 author_desc 정보를 '서울특별시'로 변경
-- author 테이블에서 기안84데이터를 삭제해 보세요 -> 삭제안됨 -> 이유?적기

select  b.book_id
	   ,b.title
       ,b.pubs
       ,a.author_id
       ,a.author_name
       ,a.author_desc
from book b
	join author a
	  on b.author_id = a.author_id
order by b.book_id asc
;

-- 강풀의 author_desc 바꾸기
update author
set author_desc = '서울특별시'
where author_id = 5
;

-- author table 에서 기안84의 데이터 삭제
delete from author
where author_id = 4;
-- book table 에서 사용하고 있기 때문에 삭제 불가
-- book table 에서 author_id = 4 인 row를 지우면 되지않을까

-- book table 에서 author_id 가 4인 row 삭제 
-- author table 에서 author_id 가 4인 row 는 존재
delete from book
where author_id = 4;
select * from author;

-- author table 에서 author_id 가 4인 row 삭제
delete from author
where author_id = 4;
select * from author;
