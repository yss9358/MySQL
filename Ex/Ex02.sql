-- 20240122 월

/* 복습
-- 기본구조 select, from
select  *
from employees;

-- mysql은 from 절 생략가능
select now();

-- 가상의 테이블 dual
select now()
from dual;

-- 사칙연산
select  first_name
       ,salary
       ,salary*12
from employees;

-- column 합치기
select  concat(first_name, '-', last_name) as name
	   ,salary
       ,salary*12
from employees;

-- select 절에 column명이 아닌 값을 사용했을 때
select first_name, '남' as '성 별'
from employees;

-- where 절
select  first_name, salary
from employees
where salary != 17000;

-- 비교연산자, 조건이 여러개일때, between, in
*/

-- 일부 문자를 포함하는 값을 찾기
-- where 절 뒤에 like 와 찾을 '단어+%' 를 써준다
-- = 등호는 사용하지 않음
-- % 가 앞에 있으면 %~ 로 끝나는 값
-- %가 뒤에 있으면 ~%로 시작하는 값
-- %~% 를 적으면 ~를 포함하는 값

-- # 이름이 L(대소문자 구분x)로 시작하는 직원의 이름, 성, 월급을 출력하세요

select  first_name
	   ,last_name
       ,salary
from employees
where first_name like 'L%'
;

-- # 이름에 am을 포함한 사원의 이름과 월급을 출력하세요

select  first_name
	   ,salary
from employees
where first_name like '%am%'
;

-- # 이름의 두번째 글자가 a인 사원의 이름과 월급을 출력하세요
-- # _ 는 한칸을 의미, 두번째 글자만 a 이고 뒤에는 상관이 없으니 뒤에 % 를 써준다

select  first_name
	   ,salary
from employees
where  first_name like '_a%'
;

-- 이름의 네번째 글자가 a인 사원의 이름을 출력하세요

select  first_name
from employees
where first_name like '___a%'
;

-- 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
-- 글자수가 정해져있기 때문에 %를 쓰지않음

select  first_name
from employees
where first_name like '__a_'
;

-- NULL 의 의미
-- 저장공간을 만들고 값을 넣지 않은 상태, 0과는 다르다. 0은 0이라는 값을 넣은 것.
-- null 을 포함한 산술식은 0이 아니라 null 이 됨.
-- primary key 를 null 로 작성할 수 없음.

select  first_name
	   ,salary
       ,commission_pct
       ,salary*commission_pct
from employees
where salary between 13000 and 15000
;

-- 값이 null 인 경우를 찾으려면 where ~~ is null 이라고 작성해야함
-- 값이 null 이 아닌 경우를 찾으려면 where ~~ is not null 이라고 작성해야함
-- where ~~ = null 이라고 하지 않음.

select  *
from employees
where commission_pct is null
;

-- # 커미션비율이 있는 사원의 이름과 월급 커미션비율을 출력하세요

select  first_name
	   ,salary
       ,commission_pct
from employees
where commission_pct is not null
;

-- # 담당매니저가 없고 커미션비율이 없는 직원의 이름과 매니저아이디 커미션 비율을 출력하세요

select  first_name
	   ,manager_id
       ,commission_pct
from employees
where manager_id is null
and   commission_pct is null
;

-- # 부서가 없는 직원의 이름과 월급을 출력하세요

select  first_name
	   ,salary
from employees
where department_id is null
;

-- ORDER BY 절
-- order by 절을 사용하면 값을 정렬할 수 있다. where 절 뒤에 작성, where 절이 없으면 생략가능
-- order by ~ asc = 작은것부터 큰것 ( 오름차순 )
-- order by ~ desc = 큰것부터 작은것 ( 내림차순 )

select  first_name
	   ,salary
from employees
where salary >= 10000
order by salary desc
;

-- 불러온 값들이 정렬되어 있어 보여도 새로운 값을 넣으면 저장된 순서가 변할 수 도 있다.
-- 순서가 중요하면 order by 절을 꼭 사용해주는 것이 좋다
select  *
from employees
order by employee_id asc
;

-- # 직원의 이름을 abcd 순서대로 출력하기
select  first_name 
	   ,salary
from employees
order by first_name asc
;

-- # 직원의 고용날짜를 최근순서에서 오래된순서로 출력하기
select  first_name
	   ,hire_date
from employees
order by hire_date desc
;

-- # 1.최근 입사한 순 2.입사일이 같으면 월급이 많은순서로 출력하기
-- # 정렬조건이 복수일 때 , 를 작성하여 조건들을 나열한다. 앞에 적힌 조건이 먼저 적용된다
-- # order by 절은 asc, desc를 기입하지 않으면 asc를 dafault 값으로 나타낸다. -> 헷갈릴 수 있으니 작성을 해주는 것이 중요
select  first_name
	   ,hire_date
       ,salary
from employees
order by hire_date desc, salary desc
;

-- # 부서번호를 오름차순으로 정렬하고 부서번호, 월급, 이름을 출력하세요
select  department_id
       ,salary
       ,first_name
from employees
order by department_id asc
;

-- # 월급이 10000 이상인 직원의 이름, 월급을 월급이 큰 직원부터 출력하세요
select  first_name
       ,salary
from employees
order by salary desc
;

-- # 부서번호를 오름차순으로 정렬하고 부서번호가 같으면 월급이 높은 사람부터
-- # 부서번호, 월급, 이름을 출력하세요
select  department_id
       ,salary
	   ,first_name
from employees
order by department_id asc, salary desc
;

-- # 직원의 이름, 급여, 입사일을 이름의 알파벳 올림차순으로 출력하세요
select  first_name
	   ,salary
       ,hire_date
from employees
order by first_name asc
;

-- # 직원의 이름, 급여, 입사일을 입사일이 빠른사람부터 출력하세요
select  first_name
       ,salary
       ,hire_date
from employees
order by hire_date asc
;

-- # select from where order by 절 로직 이해 
/*
1. from 절에서 table을 찾음                      // table 별명적용 가능
2. table 에서 row를 읽음
3. row 가 where절의 조건을 만족하는지 확인
4. table의 모든 row를 확인                       // table의 별명 사용 가능, column의 별명 사용 불가능
4-1. 조건을 만족하면 임시결과 저장
4-2. 조건을 만족하지 않으면 버리고 다시 3으로 복귀
5. select 절을 이용하여 결과 생성                  // 사용될 column 명이 정해지고 column의 별명 사용 가능
6. order by 절을 이용해 결과를 정렬                // select절에 사용하지 않는 column도 정렬 가능 
*/
-- ------------------------------------------
--                단일행 함수                 --
-- ------------------------------------------

-- -----------------
-- 단일행 함수 - 숫자함수
-- -----------------

-- ROUND(숫자, m) : 반올림, 소수점 m자리까지 표현
-- m 이 0 이면 생략가능
-- , 를 앞에 쓰면 순서를 바꿀때 편하게 작성할 수 있다.
select   round(123.123, 2)
        ,round(123.126, 2)
        ,round(234.567, 0)
        ,round(123.456, 0)
        ,round(123.456)
        ,round(123.126, -1)
        ,round(125.126, -1)
        ,round(123.126, -2)
from dual
;

-- CEIL(숫자) : 올림
select  ceil(123.456)
	   ,ceil(123.789)
       ,ceil(123.7892313)
       ,ceil(987.1234)
;

-- FLOOR(숫자) : 내림
select  floor(123.456)
	   ,floor(123.789)
       ,floor(123.7892313)
       ,floor(987.1234)
;

-- TRUNCATE(숫자, m) : 버림, 소수점 m자리 까지 표현
select  truncate(1234.34567, 2)
       ,truncate(1234.34567, 3)
       ,truncate(1234.34567, 0)
       ,truncate(1235.34567, -2)
;

select  first_name '이 름'
       ,salary '월 급'
       ,truncate(salary/30, 0) '일 당'
from employees
order by salary desc
;       

-- POWER(숫자, n), pow(숫자, n) : 숫자의 n승
select  pow(12,2)
	   ,power(12,2)
;

-- SQRT(숫자) : 숫자의 제곱근
select sqrt(144)
;

-- SIGN(숫자) : 숫자가 음수이면 -1, 0이면 0 , 양수이면 1
select  sign(123)
       ,sign(0)
       ,sign(-123)
;

-- ABS(숫자) : 절대값
select  abs(123)
       ,abs(0)
       ,abs(-123)
;

-- GREATEST(x,y,z, ...) : 괄호안의 값중 가장 큰값
-- greatest 와 max 의 차이 : greatest 는 () 안에 값들을 적어서 비교, max 는 ()안의 범위를 비교
select  greatest(2, 0, -2)
	   ,greatest(4, 3.2, 5.25)
       ,greatest('B', 'A', 'C', 'c')  -- 소문자가 대문자보다 크지 않을까 하는 예상?이됨
;

-- LEAST(x,y,z, ...) : 괄호안의 값중 가장 작은값
-- least 와 min 의 차이 : least 는 () 안에 값들을 적어서 비교, min 은 ()안의 범위를 비교

select  least(2, 0, -2)
	   ,least(4, 3.2, 5.25)
       ,least('B', 'A', 'C', 'c')
from dual
;
-- -----------------
-- 단일행 함수 - 문자함수
-- -----------------

-- CONCAT(str1,str2,...,strn) : str1, str2,... strn을 연결
select concat('안녕','하세요')
from dual
;

select concat('안녕','-','하세요')
from dual
;

select concat(first_name, ' ', last_name)
from employees
;

-- CONCAT_WS(s, str1, str2, ... , strn) : str1, str2, ..., strn 을 연결할때 사이에 s로 연결 
select concat_ws('-', 'abc','123','가나다')
from dual
;

select concat_ws('-', first_name, last_name, salary)
from employees
;

-- LCASE(str) 또는 LOWER(str) : str의 모든 대문자를 소문자로 변환
select  first_name
       ,lcase(first_name)
       ,lower(first_name)
       ,lower('ABCabc!#$%')
       ,lower('가나다')
from employees
;

-- UCASE(str) 또는 UPPER(str) : str의 모든 소문자를 대문자로 변환
select  first_name
       ,ucase(first_name)
       ,upper(first_name)
       ,upper('ABCabc!#$%')
       ,upper('가나다')
from employees
;

-- 문자갯수
-- LENGTH(str) : str의 길이를 바이트로 반환
-- CHAR_LENGTH(str) 또는 CHARACTER_LENGTH() : str의 문자열 길이를 반환
select  first_name
       ,length(first_name)
       ,char_length(first_name)
       ,character_length(first_name)
from employees
;

select  length('a')
	   ,char_length('a')
       ,character_length('a')
from dual
;

select  length('가')
       ,char_length('가')
       ,character_length('가')
from dual
;

-- SUBSTRING(str, pos, len) 또는 SUBSTR(str, pos, len) : str의 pos 위치에서 시작하여 len 길이의 문자열 반환
-- 양수인 경우 왼쪽 -> 오른쪽으로 검색해서 글자수 만큼 추출
-- 음수인 경우 오른쪽 -> 왼쪽으로 검색을 한 후 왼쪽 -> 오른쪽으로 글자수 만큼 추출
select  first_name
       ,substr(first_name, 1, 3)
       ,substr(first_name, 2, 2)
       ,substr(first_name, -3, 2)
from employees
where department_id = 100;

select  substr('901112-1234567', 8, 1)    -- 성별
	   ,substr('901112-1234567', -7, 1)   -- 성별 뒤에서 계산
       ,substr('901112-1234567', 1, 2)    -- 년도
       ,substr('901112-1234567', 3, 2)    -- 월
       ,substr('901112-1234567', 5, 2)    -- 일
from dual
;       

-- LPAD(str, len, padstr) : str 문자열 왼쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬
-- RPAD(str, len, padstr) : str 문자열 오른쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬

select  first_name
	   ,lpad(first_name, 10, '*')
       ,rpad(first_name, 10, '*')
from employees
;

-- TRIM(str) : str의 양쪽에 있는 공백 문자를 제거
-- LTRIM(str) : str의 왼쪽에 있는 공백 문자를 제거
-- RTRIM(str) : str의 오른쪽에 있는 공백 문자를 제거

select  concat('|', '                   안녕하세요                ', '|') concat
	   ,concat('|', trim('              안녕하세요                '), '|') trim
       ,concat('|', ltrim('             안녕하세요                '), '|') ltrim
       ,concat('|', rtrim('             안녕하세요                '), '|') rtrim
from dual
;

 -- REPLACE(str, from_str, to_str) : str에서 from_str을 to_str로 변경
 select  first_name
		,replace(first_name, 'a', '*')
        ,replace(first_name, substr(first_name, 2, 3), '***')
 from employees
 where department_id = 100
 ;

-- ------------------
--  날짜 / 시간함수
-- ------------------

-- CURRENT_DATE() 또는 CURDATE()  : 현재 날짜를 반환
-- CURRENT_TIME() 또는 CURTIME()  : 현재 시간을 반환
-- CURRENT_TIMESTAMP() 또는 NOW() : 현재 날짜와 시간을 반환

select  current_date()
	   ,curdate()
from dual
;

select  current_time()
       ,curtime()
from dual
;

select  current_timestamp()
       ,now()
from dual
;

-- ADDDATE() 또는 DATE_ADD() :  날짜 시간 더하기
-- SUBDATE() 또는 DATE_SUB() :  날짜 시간 빼기
-- ADDDATE() 에서 음수를 넣으면 빼기효과

select  adddate('2021-06-20 00:00:00', INTERVAL 1 YEAR)
       ,adddate('2021-06-20 00:00:00', INTERVAL 1 MONTH)
       ,adddate('2021-06-20 00:00:00', INTERVAL 1 WEEK)
       ,adddate('2021-06-20 00:00:00', INTERVAL 1 DAY)
       ,adddate('2021-06-20 00:00:00', INTERVAL 1 HOUR)
       ,adddate('2021-06-20 00:00:00', INTERVAL 1 MINUTE)
       ,adddate('2021-06-20 00:00:00', INTERVAL 1 SECOND)
from dual
; 

select  subdate('2021-06-20 00:00:00', INTERVAL 1 YEAR)
       ,subdate('2021-06-20 00:00:00', INTERVAL 1 MONTH)
       ,subdate('2021-06-20 00:00:00', INTERVAL 1 WEEK)
       ,subdate('2021-06-20 00:00:00', INTERVAL 1 DAY)
       ,subdate('2021-06-20 00:00:00', INTERVAL 1 HOUR)
       ,subdate('2021-06-20 00:00:00', INTERVAL 1 MINUTE)
       ,subdate('2021-06-20 00:00:00', INTERVAL 1 SECOND)
from dual
; 

-- DATEDIFF() : 두 날짜간 일수차
-- TIMEDIFF() : 두 날짜시간 간 시간차

select  datediff('2021-06-21 01:05:05', '2021-06-21 01:00:00')
       ,timediff('2021-06-21 01:05:05', '2021-06-20 01:00:00')
from dual
;

select  first_name
       ,hire_date
       ,datediff(now(), hire_date) workday
       ,datediff(now(), hire_date)/365 workyear
from employees
order by workday desc
;

-- ------------------
-- 변환함수
-- ------------------

-- 변환함수 : 날짜(시간) -> 문자열
-- DATE_FORMAT(date, format) : date를 format 형식으로 변환
select  now()
       ,date_format(now(), '%Y-%b-%d(%a) %H:%i:%s %p')
       ,date_format(now(), '%Y-%m-%d(%a) %H:%i:%s %p')
from dual
;

-- 변환함수 : 문자열 -> 날짜(시간)
-- STR_TO_DATE(str, format) : str 을 format 형식으로 변환


select  datediff('2021-Jun-04', '2021-06-01')     -- 날짜 모양의 문자열을 날짜형으로 인식하지 못해 -가 계산되지 않는다
	   ,str_to_date('2021-Jun-04', '%Y-%b-%d')    -- '2021-Jun-04'을 '%Y-%b-%d' 형식으로 해석해서 올바른 날짜형으로 반환
       ,str_to_date('2021-06-01', '%Y-%m-%d')     -- '2021-06-01'을 '%Y-%m-%d' 형식으로 해석해서 올바른 날짜형으로 반환
       ,datediff(str_to_date('2021-Jun-04', '%Y-%b-%d'), str_to_date('2021-06-01', '%Y-%m-%d'))  -- 각각의 문자열을 날짜형으로 변환시켜서 계산함
from dual
;

-- 상식선의 날짜표시인 경우 그냥 계산된다
select datediff('2021-06-04', '2021/06/01')
from dual
;

-- 변환함수 : 숫자 -> 문자열
-- FORMAT(숫자, p) : 숫자에 콤마(,)를 추가, 소수점 p자리까지 출력
-- 세번째 마다 ,를 찍음 / 음수는 0이랑 똑같이 처리됨
select  format(1234567.89, 2)
	   ,format(1234567.89, 0)
       ,format(1234567.89, -5)
from dual
;

-- 변환함수
-- CAST(expression AS type) : expression을 type 형식으로 변환

-- 변환함수
-- IFNULL(column, null일때값) : column 의 값이 null일 때 정해진 값을 출력
select  first_name
       ,commission_pct
       ,ifnull(commission_pct, 0)
       ,ifnull(commission_pct, '없음') -- 문자보단 숫자로 표현해주는게 좋다.
from employees
;