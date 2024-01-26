-- author table 만들기 
create table author(
	author_id int auto_increment primary key -- not null + unique
   ,author_name varchar(100) not null
   ,author_desc varchar(500)
);

-- book table 만들기
create table book(
	book_id int auto_increment primary key
   ,title varchar(100) not null
   ,pubs varchar(100)
   ,pub_date datetime
   ,author_id int
   ,constraint book_fk foreign key(author_id)	-- book table 의 author_id를 forieign key 지정
   references author(author_id)					-- author table dml author_id 를 primary key 지정
);

-- ----------------------------------------------------------------------------
-- 제약조건
-- NOT NULL : NULL 값 입력불가 -> 값을 꼭 입력해야함
-- UNIQUE : 중복값 입력불가 ( NULL 값은 허용 )
-- PRIMARY KEY : NOT NULL + UNIQUE , 데이터들끼리의 유일성을 보장하는 column에 설정
-- 				 테이블당 1개만 설정 가능 ( 여러개를 묶어서 설정가능)
-- FOREIGN KEY = 외래키 , 일반적으로 REFERENCE 테이블의 PK 를 참조
-- 				 		REFERENCE 테이블에 없는 값은 삽입불가
-- 						REFERENCE 테이블의 레코드 삭제시 동작
-- 						- ON DELETE CASCADE : 해당하는 FK를 가진 참조행도 삭제
-- 						- ON DELETE SET NULL : 해당하는 FK를 NULL 로 바꿈
-- ---------------------------------------------------------------------------

/*
-- table 확인
show tables;

-- column 추가
alter table book add pubs varchar(50);				-- column 추가

-- column 수정
alter table book modify title varchar(100);			-- column의 자료형 수정 
alter table book rename column title to subject;	-- column 명 수정

-- column 삭제
alter table book drop author;						-- column 삭제

-- table 명 수정
rename table book to article;

-- table 삭제
drop table book;

-- table의 모든 row를 제거
-- truncate table article;

*/

-- 작가 등록 : 묵시적 방법
-- column 이름, 순서 지정하지 않음 -> 테이블 생성시 정의한 순서에 따라 값 지정됨
insert into author
values(1, '박경리', '토지 작가')
;

-- 작가 등록 : 명시적 방법
-- () 안의 값을 지정해서 넣는 방법 , values()의 값들을 insert into table()의 순서대로 입력해준다
-- 지정되지 않은 column 은 NULL 이 자동입력된다
insert into author(author_id, author_name)
values(2, '이문열')
;

insert into author(author_name, author_id)
values('황일영', 3)
;

insert into author(author_id, author_name)
values(4, '정우성')
;

insert into author(author_name)
values('박명수')
;

insert into author
values(5, '김종국', null)
;

-- UPDATE 수정

-- 조건을 만족하는 레코드를 변경
-- column  이름, 순서 지정하지 않음 -> 테이블 생성시 정의한 순서에 따라 값 지정
-- update '테이블명' set column = '변경내용' , column = '변경내용' where column = ();
-- where 절이 생략되면 모든 레코드에 적용 -> 주의해서 where 절을 정의

update author
set author_name = '기안84'
   ,author_desc = '웹툰작가'
where author_id = 3;

-- DELETE 삭제
-- delete from 'table' where 'column' = () ;
-- where절 조건을 만족하는 레코드 삭제
-- where 절 없이 delete from 'table' 작성시 모든 데이터 삭제 -> 주의해서 where 절을 정의
delete from author 
where author_id = 5
;

delete from author
where author_name = '이문열'
;

-- TRUNCATE : table의 모든 row 제거
-- truncate table article;

insert into book
values(1, '우리들의', '다림', '1998-02-02', 2)
;

insert into book
values(2, '삼국지', '민음사', '2002-03-01', 2)
;
insert into book
values(3, '토지', '마로니에북스', '2012-08-15', 1)
;

insert into book
values(4, '오직두사람', '문학동네', '2017-05-04', 6)
;

select  b.book_id
	   ,b.title
       ,b.pubs
       ,b.pub_date
       ,a.author_id
       ,a.author_name
       ,a.author_desc
from book b, author a
where b.author_id = a.author_id
;

-- auto_increment
-- 연속적인 인렬번호 생성 -> primary key 에 주로 사용됨
/* -- 테이블생성시 작성
create table author(
	author_id int auto_increment primary key
   ,author_name varchar(100) not null
   ,author_desc varchar(500) 
);
*/
/*-- 생성된 테이블에 적용 / 기본적으로 safe-mode로 막아놓음 ->safe-mode를 해제해야 사용됨
alter table author modify author_id int auto_increment primary key;
*/

-- 현재값을 조회할 때 
select last_inser_id();
