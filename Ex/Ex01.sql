use hrdb;
/*******************************
select 문 (조회)
*******************************/

-- select ~ from 절
-- 테이블 전체 조회하기

select * from employees;
select * from departments;
select * from locations;
select * from countries;
select * from regions;
select * from jobs;

-- select 절
select first_name,salary
from employees;

-- # 모든 직원의 직원아이디(employee_id), 이름(first_name), 성(last_name)
-- # 을 출력하세요
select first_name, last_name, employee_id
from employees;

-- # 모든 직원의 이름(first_name), 전화번호, 입사일, 월급을 출력하세요
select first_name,phone_number,hire_date,salary
from employees;
-- # 모든 직원의 이름(first_name)과 성(last_name), 월급, 전화번호, 이메일, 입사일을 출력하세요
select first_name, last_name, salary, phone_number, email, hire_date
from employees;

-- 테이블부터 확인한 후 원하는 column 을 입력
select * -- 
from employees;

select first_name,phone_number,hire_date,salary
from employees;

select  first_name
       ,last_name
       ,salary
       ,phone_number
       ,email
       ,hire_date
from employees;

-- column 이름을 바꿔서 보고 싶을땐 as 를 붙이고 작성한다.
-- 특수문자가 포함되면 ''  따옴표 사이에 쓴다. 띄어쓰기도 포함.
-- as를 생략해도 가능. 띄어쓰기는 해야함

-- # 직원아이디, 이름, 월급을 출력하세요.
-- # 단 직원아이디는 empNO, 이름은 'f-name', 월급은 '월 급' 으로 column명을 출력하세요
select employee_id as empNO
	  ,first_name as 'f-name'
      ,salary as '월 급'
from employees;

-- # 직원의 직원아이디를 '사 번', 이름(first_name), 성(last_name).
-- # 월급, 전화번호, 이메일, 입사일로 표시되도록 출력하세요
select employee_id '사 번'
	  ,first_name 이름
	  ,last_name 성
      ,salary 월급
      ,phone_number 전화번호
      ,email 이메일
      ,hire_date 입사일
from employees;

-- 산술 연산자 사용하기
--  + , - , * , / , % 

select  first_name 이름
	   ,salary 월급
       ,salary-100 '월급-식대'
       ,salary*12 연봉
       ,salary*12+5000 '연봉(보너스포함)'
       ,salary/30 일급
       ,employee_id%3 '워크샵 팀'
from employees;

-- 산술연산자 사용시 문자열은 0으로 처리한다 -> 오류가 발생해도 모를 수 있으니 문자열을 처리할때 주의
select job_id*12
from employees;

-- column 합치기 

select first_name,last_name
from employees;

-- concat(column, column)
-- ' ' 공백을 넣으면 띄어씌기가 됨
-- column 명이 아닌 값을 입력하면 출력해서 보여줄 때 전체 적용이 됨
-- 따로 별명을 만들지 않으면 함수가 column명으로 출력됨
select concat(first_name,last_name) name
from employees;


select concat(first_name, ' - ',last_name) name
from employees;

select first_name
      ,last_name
      ,concat(first_name, ' ' , last_name) name
      ,concat(first_name, ' ' , last_name, ' hire date is' , hire_date) name2
from employees;       


-- 같은값으로 받고 싶으면 없는 column 을 그냥 작성해도된다.
-- table의 column명과 table의 데이터, 문자열, 숫자는 그대로 출력
select first_name
	  ,salary*12 연봉
      ,'(주)개발자' company
      ,3 상태
from employees;

-- table명을 가져올 데이터가 없으면 from 을 생략해도 된다.
-- from 뒤에 table이 없으면 가상의 table인 dual 을 작성해 from 절을 완성할 수 있다.

select now() from dual;  -- 현재시간 표시 -> table에 없어서 from을 생략가능

-- 계산기로도 쓸 수 있다.
select 123*5;
select 5+10;

-- 보고 싶은 column 을 제어하는 건 select 절
-- 보고 싶은 row 을 제어하는 건 where 절

-- 같을 때 =
-- 같지 않을때 != , <>  둘다 사용가능
-- 부등호 > , < , >= , <=

-- # 부서번호가 10인 사원의 이름을 구하시오
select first_name, department_id
from employees
where department_id = 10;

-- # 월급이 15000 이상인 사원들의 이름과 월급을 출력하세요
select  first_name
	   ,salary
from employees
where salary >= 15000;

-- # 07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
select  first_name 이름
	   ,hire_date '입사일이 070101 이후인사람'
from employees
where hire_date >= '2007-01-01';

-- where binary 키워드를 작성하면 대소문자를 구분해준다
select  first_name
	   ,salary
from employees
where binary first_name = 'Lex';

-- 부등호를 복수로 사용해 특정구간의 값을 구할 수 있다.
-- # 월급이 14000 이상 17000 이하인 사원의 이름과 월급을 구하시오
select  first_name
	   ,salary
from employees
where salary<=14000
or salary>=17000
;

-- # 입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select  first_name
       ,hire_date
from employees
where  hire_date >='2004-01-01'
and hire_date <='2005-12-31'
;

-- BETWEEN 연산자로 특정구간 값 출력하기
-- # 월급이 14000 이상 17000 이하인 사원의 이름과 월급을 구하시오
select  first_name
       ,salary
from employees
where salary >=14000
and salary<=17000
;

-- between a and b 는 a이상 b 이하일때 사용가능
-- 순서가 중요함. 작은수 ~ 큰수 사이로 표기하도록 해야함.
select  first_name
	   ,salary
from employees
where salary between 14000 and 17000
;

-- IN 연산자로 여러 조건을 검사하기
-- # Neena, Lex, John 의 이름, 성, 월급을 구하시오
select  first_name
	   ,last_name
	   ,salary
from employees
where first_name = 'Neena' 
or	  first_name = 'lex'
or    first_name = 'john'
or    first_name = 'steve'
;
-- in() 괄호안에 구하려는 값을 계속 입력하면됨
select  first_name
       ,last_name
	   ,salary
from employees
where first_name in ('neena', 'lex' , 'john', 'david')
;
 
select  first_name
	   ,salary
from employees
where salary = 2100
or    salary = 3100
or    salary = 4100
or    salary = 5100
;

-- 해당하는 결과값이 없으면 없는대로 출력됨
select  first_name
	   ,salary
from employees
where salary in (2100, 3100, 4100, 5100)
;
