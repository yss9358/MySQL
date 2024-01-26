-- ----------------------------------------------------------------
-- 20240126 book계정 초기화 
-- ----------------------------------------------------------------

-- # book_db 데이터베이스, book 계정, book 계정 권한 초기화 세팅 스크립트
-- # root로 접속해야함

-- 계정이 있다면 삭제
drop user if exists 'book'@'%';
-- 아이디 생성 '아이디'@'%' identified by '비밀번호' - '' 표시 
create user 'webdb'@'%' identified by '1234';
-- 비밀번호 변경
alter user 'webdb'@'%' identified by 'webdb';
-- 권한을 부여할때 사용 - web_db 데이터베이스의 접근권한을 부여 
-- '%' - 모든 곳에서 접속가능
-- 'localhost' - localhost 에서만 접속가능
-- '192.168.0.111' - '192.168.0.111' 에서만 접속가능 
grant all privileges on web_db.* to 'webdb'@'%';
-- 계정을 삭제
drop user 'webdb'@'%';
-- 계정을 삭제하거나 권한을 수정한 후 변경된 권한 즉시 적용
flush privileges;


-- 데이터베이스가 있다면 삭제
drop database if exists book_db;
-- 데이터베이스 생성
create database web_db
	default character set utf8mb4  -- 이모티콘사용 캐릭터 셋
    collate utf8mb4_general_ci     -- 정렬규칙
    default encryption = 'n'       -- 암호화 no (기본값 생략가능)
;
-- 데이터베이스 조회
show databases ;
-- 데이터베이스 삭제
drop database web_db;

-- 11p 계정 만들기 , 14p 데이터베이스 만들기
-- 계정명 book / 비번 book / 모든곳에서 접속가능 
-- 권한 book_db 데이터베이스의 모든 테이블에 모든권한 사용 가능

create user 'book'@'%' identified by 'book';
grant all privileges on book_db.* to 'book'@'%';
create database book_db
	default character set utf8mb4
    collate utf8mb4_general_ci
    default encryption = 'n'
;
flush privileges ;


