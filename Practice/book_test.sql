-- -------------------------------------------------
-- 데이터베이스_평가 20240129 - 유승수
-- -------------------------------------------------

/*
-- # 계정생성 쿼리문 
-- # 계정명 : book, 비번 : book, 모든곳에서 접근가능한 계정을 생성합니다
*/
drop user if exists 'book'@'%';
create user 'book'@'%' identified by 'book';

/*
-- # 권한설정 쿼리문
-- # book_db 데이터베이스의 book계정이 모든 테이블에 권한을 부여받습니다.
*/
grant all privileges on book_db.* to 'book'@'%';

-- # book_db 데이터베이스 생성 쿼리문

drop database if exists book_db;
create database book_db
	default character set utf8mb4
	collate utf8mb4_general_ci
    default encryption = 'n'
;

-- # 테이블 생성 쿼리문 2개

create table book(
	book_id int auto_increment primary key
   ,title varchar(100) not null
   ,pubs varchar(100)
   ,pub_date datetime
   ,author_id int
   ,constraint book_fk foreign key(author_id)
   references author(author_id)
);

create table author(
	author_id int auto_increment primary key
   ,author_name varchar(100)
   ,author_desc varchar(500)
);

-- # author테이블 데이터 입력 쿼리문 6개

insert into author
values(null, '이문열', '경북 영양');

insert into author
values(null, '박경리', '경상남도 통영');

insert into author
values(null, '유시민', '17대 국회의원');

insert into author
values(null, '기안84', '기안동에서 산 84년생');

insert into author
values(null, '강풀', '온라인 만화가 1세대');

insert into author
values(null, '김영하', '알쓸신잡');

-- # book테이블의 데이터 입력 쿼리문 9개

insert into book
values(null, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);

insert into book
values(null, '삼국지', '민음사', '2002-03-01', 1);

insert into book
values(null, '토지', '마로니에북스', '2012-08-15', 2);

insert into book
values(null, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);

insert into book
values(null, '패션왕', '중앙북스(books)', '2012-02-22', 4);

insert into book
values(null, '순정만화', '재미주의', '2011-08-03', 5);

insert into book
values(null, '오직두사람', '문학동네', '2017-05-04', 6);

insert into book
values(null, '26년', '재미주의', '2012-02-04', 5);

insert into book
values(null, '자바의정석', '열린책들', '2015-10-20', null);

-- # 아래의 조건에 맞는 책목록 리스트 쿼리문 1개
/*
(1) 등록된 모든 책이 출력되어야 합니다.(9권)
(2) 출판일은 '1998년 02월 02일' 형태로 보여야 합니다.
(3) 정렬은 책 제목을 내림차순으로 정렬합니다.
*/

select  b.book_id
	   ,b.title
       ,b.pubs
       ,date_format(b.pub_date, '%Y년  %m월  %d일') pub_date
       ,b.author_id
       ,a.author_id
       ,a.author_name
       ,a.author_desc
from book b
	left outer join author a
				 on b.author_id = a.author_id
order by b.title desc
;