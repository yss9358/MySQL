-- 20240123
-- -------------------------------------------
-- 그룹함수
-- -------------------------------------------
-- 종류 : avg(), count(), max(), min(), sum()
-- 그룹함수의 결과값은 한개만 나타나게 된다.

-- 단일행 함수
select  first_name
	   ,salary
from employees
;

-- 그룹함수 
select  sum(salary)
from employees
;

-- 오류 / 단일행 함수와 그룹함수는 같이 사용X
select  first_name
	   ,salary
       ,sum(salary)
from employees
;

-- ---------------------------------------------
-- COUNT() : 함수에 입력되는 데이터의 총 건수를 구하는 함수
-- ---------------------------------------------
-- 전체 직원의 수 
select  *
from employees
;

-- 제일 많은 row를 작성하게된다. -> 전체직원의 수 출력하게됨.
-- count() 는 null 을 포함하고 계산한다.
select  count(*)         -- 107
from employees
;

-- count() 안에 column명을 작성하면 null은 제외하고 계산한다.
select  count(first_name)  -- 107
from employees
;

select count(manager_id)    -- 106
from employees
;

select  count(commission_pct)  -- 35
from employees
;

select  count(*)               -- 107 / null 포함
       ,count(commission_pct)  -- 35  / null 제외
from employees
;

-- # 월급이 16000 초과 되는 직원의 수는?
select count(*)     -- 3 / null 포함 전체 count 실행
from employees
where salary > 16000
;

select  count(commission_pct)     -- 0 / null 은 count에 포함시키지 않음
from employees
where salary> 16000
;

-- --------------------------------------
-- SUM() : 입력된 데이터들의 합계 값을 구하는 함수
-- --------------------------------------
select  count(*)       -- 전체 직원의 수      // null 포함 계산
	   ,sum(salary)    -- 전체 직원의 월급의 합 // null은 제외하고 계산
from employees
;

-- -----------------------------------------
-- AVG() : 입력된 값들의 평균값을 구하는 함수
-- -----------------------------------------
-- AVG() 는 null 값이 있으면 제외하고 계산함
-- null을 제외할지 포함할지 정한뒤에 계산해야함

-- null값을 제외시키고 계산
select  count(*)
       ,sum(salary)
       ,avg(salary)
from employees
;

-- salary 에 null 값이 있으면 0으로 처리하는 ifnull(salary, 0) 을 작성
select  count(*)
       ,sum(salary)
       ,avg(ifnull(salary, 0))
from employees
;

-- --------------------------------------
-- MAX() : 입력된 값들중 가장 큰값을 구하는 함수
-- MIN() : 입력된 값들중 가장 작은값을 구하는 함수
-- --------------------------------------
-- 여러건의 데이터를 순서대로 정렬 후 값을 구하기 때문에 데이터가 많을 때는 느리다.

select  count(*)
       ,max(salary)
       ,min(salary)
from employees
;

-- ---------------
-- GROUP BY 절
-- ---------------

-- 부서번호, 월급 출력
select  department_id
       ,salary
from employees
order by department_id
;

-- department_id 로 그룹 후 그룹별로 월급 max값과 평균값 출력
-- group에 참여한 column 은 단일행 함수이더라도 그룹함수와 같이 사용가능

-- 그룹번호에 대한 정보가 필요
select  max(salary)
       ,avg(salary)
from employees
group by department_id
;

select  department_id
       ,max(salary)
       ,avg(salary)            -- null 값을 제외하고 계산
       ,avg(ifnull(salary, 0)) -- null 값이 있을경우 0으로 출력해서 계산
from employees
group by department_id
order by department_id asc
;

-- 그룹에 참여하지 않은 column은 사용할 수 없다 , first_name 사용x
select department_id, max(salary), avg(salary), first_name
from employees
group by department_id
;

-- 그룹을 세분화, 그룹안에 그룹만들기
-- 그룹에 참여한 column명은 select 절에 사용할 수 있다.
-- department_id 를 세분화해서 job_id 로 그룹을 한번더 생성
-- 앞에 작성한 순서대로 그룹화가 진행
select  ifnull(department_id, 0)
	   ,job_id
       ,max(salary)
       ,avg(salary)
from employees
group by department_id, job_id
order by department_id asc, job_id asc
;

-- # 월급(salary)의 합계가 20000 이상인 부서의 부서 번호와, 인원수, 월급합계를 출력하세요
-- where 절에는 그룹함수를 쓸 수 없다.
-- 합계를 계산하기전에 where절을 실행한다.

select  ifnull(department_id, 0)
	   ,count(*)
       ,sum(salary)
from employees
where sum(salary) >= 20000   -- 오류
group by department_id
order by department_id asc
;

-- --------------------
-- HAVING 절
-- --------------------

-- # 월급(salary)의 합계가 20000 이상인 부서의 부서 번호와, 인원수, 월급합계를 출력하세요
-- Having 절에는 그룹함수 와 group by 에 참여한 column 만 사용이 가능하다
select  ifnull(department_id, 0)
       ,count(*)
       ,sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and department_id in (90, 100)
order by department_id asc
;

-- GROUP BY ~ HAVING 절
-- (1) FROM 실행
--  - JOIN을 통하여 큰 table 을 만든다
-- (2) WHERE
--  - table로 부터 한 row씩 읽어 조건을 만족하는 결과를 뽑는다
-- (3) GROUP BY
--  - 원하는 그룹별로 row를 grouping 한다
-- (4) HAVING
--  - 원하는 조건을 만족하는 그룹만 남긴다
-- (5) SELECT
--  - 원하는 결과마나 projection 한다
-- (6) ORDER BY
--  - 주어진 조건에 따라 정렬한다

-- ----------------------------
-- 그룹합수 JOIN
-- ----------------------------
-- IF ~ ELSE 문 / CASE ~ END 문

-- IF ~ ELSE 문
-- IF(조건문, true값, false값)

-- # 모든 직원의 이름, 월급, 수당, 상태(state)를 출력하세요
-- # 상태 column은 수당이 없으면 0, 수당이 있으면 1을 state column에 표시하세요
select  first_name
       ,salary
       ,commission_pct
       ,if(commission_pct is null, 0, 1) state -- commission_pct 가 null 이면 0 , null이 아니면 1 을 출력
from employees
;

-- if 조건문과 ifnull 은 다르다
-- if조건문 : if(조건문, true값, false값) : 조건문, 조건문의 값이 true일때 값, 조건문의 값이 false일때 값
-- ifnull : ifnull(column, null일때 출력할값) : column 의 값이 null 이면 정해진값을 출력
select commission_pct
	  ,ifnull(commission_pct, 0)
from employees
;

-- ------------------------------------------
-- CASE ~ END 문 : if~else if ~else if ~else
-- ------------------------------------------
-- CASE 
--  WHEN 조건 THEN 출력1
--  WHEN 조건 THEN 출력2
--  WHEN 조건 THEN 출력3
--  ELSE 출력4
-- END column

-- # 예제) 직원아이디, 월급, 업무아이디, 실제월급(realSalary)을 출력하세요
-- # 실제월급은 job_id 가 'AC_ACCOUNT'면 월급+월급*0.1
-- #                   'SA_REP'   면  월급+월급*0.2
-- #                   'ST_CLERK' 면  월급+월급*0.3
-- #                   그외에는 월급으로 계산하세요

select  employee_id 직원아이디
       ,salary 월급
       ,job_id
       ,case -- case ~ end문 시작
         when job_id = 'AC_CCCOUNT' then salary + (salary*0.1)  -- when 조건 then 결과값출력
         when job_id = 'SA_REP' then salary + (salary*0.2)
         when job_id = 'ST_CLERK' then salary + (salary*0.3)
         else salary   -- 그외의 값 else로 출력
		end realSalary -- end column명 을 적고 마무리
from employees
order by employee_id asc -- 직원아이디 오름차순
;

-- # 예제) 직원의 이름, 부서번호, 팀을 출력하세요
-- # 팀은 코드로 결정하며 부서코드가
-- # 10 ~ 50 이면 'A-TEAM'
-- # 60 ~ 100이면 'B-TEAM'
-- # 110 ~ 150이면 'C-TEAM'
-- # 나머지는 '팀없음' 으로 출력하세요

select  first_name
	   ,department_id
       ,case
         when department_id >= 10 and department_id <= 50 then 'A-TEAM'
         when department_id >= 60 and department_id <= 100 then 'B-TEAM'
         when department_id >= 110 and department_id <= 150 then 'C-TEAM'
         else '팀없음'
		end 팀
from employees
;
-- between A and B 사용
select  first_name
       ,department_id
       ,case
         when department_id between 10 and 50 then 'A-TEAM'
         when department_id between 60 and 100 then 'B-TEAM'
         when department_id between 110 and 150 then 'C-TEAM'
         else '팀없음'
		end 팀
from employees
;

-- ----------------------------
-- JOIN
-- ---------------------------
-- # 직원의 이름과 직원이 속한 부서명을 함께 보고 싶다면
-- # 원하는 결과 -> 사원이름, 부서명, 부서번호
-- # 데이터가 2개의 테이블 employees, departments 에 나눠져 있다

-- 이름, 부서번호
select	* -- row 107
from employees
;
-- 부서번호, 부서명
select	* -- row 27
from departments
;

-- JOIN 을 통해 두개의 table을 합친다 
-- 두개의 table의 column이 한개로 합쳐진다. department_id 는 두개의 table에 존재
-- 두개의 테이블에서 그냥 결과를 선택하면 -> 107 * 27 의 row 값이 생긴다 : 만들 수 있는 경우의 수 모두 계산 (Cartesian Product)
select	*
from employees, departments
;

-- join : from table1, table2, ... ,tablen
-- 원하는 column명만 출력
-- departmetn_id column 때문에 오류(양쪽테이블에 같은 column명 존재)
select  first_name
       ,department_name
       ,department_id
from employees, departments
;

-- 어느 table의 department_id column인지 명확하게 표시해야함
select  first_name
       ,department_name
       ,employees.department_id
       ,departments.department_id
from employees, departments
;

-- from 절은 별명으로 작성이 가능. from 절이 별명으로 작성되면 별명으로만 사용가능함
-- 겹치지 않는 column 명은 table명을 써도 되고 안 써도 된다 / 겹치는 column 명은 꼭 써야됨
select  first_name  -- table명 생략
       ,d.department_name
       ,e.department_id
       ,d.department_id
from employees e, departments d
;

-- ------------------------------------
-- INNER JOIN ( EQUI JOIN )
-- ------------------------------------
-- EQUI JOIN (INNER JOIN)

-- 조건절을 사용한 equi join
select  e.first_name
       ,d.department_name
       ,e.department_id
       ,d.department_id
from employees e, departments d
where e.department_id = d.department_id -- 조건에 부합하는 결과값들만 모이게됨 -> null은 join 되지 않음 
;

-- inner join 을 사용한 equi join
select  e.first_name
       ,d.department_name
       ,d.department_id
       ,e.department_id
from employees e
	inner join departments d
			on e.department_id = d.department_id
;
-- from 절에 필요로 하는 테이블을 모두 적는다
-- column 에 어느 테이블에서 왔는지 지정해준다 / table 에 별명을 사용하면 별명을 사용해 column값을 지정해주어야한다
-- join에 필요한 조건을 where 절에 부여한다 / 일반적으로 table 수 -1개의 조건이 필요 (반드시는 아님)
-- inner join 에서 inner는 생략가능
-- inner join ~ on ~ / where 절  둘다 사용가능

-- # 예제) 모든 직원이름, 부서이름, 업무명을 출력하세요 *3개의 테이블

-- inner join 을 사용해 진행
select  e.first_name
	   ,d.department_name
       ,j.job_title
from employees e
	join departments d 
	  on e.department_id = d.department_id -- join 을 통해 나온 결과값들과 다시 join을 진행해야함
	join jobs j
      on e.job_id = j.job_id
;

-- where 절 사용해 진행
select  e.first_name
	   ,d.department_name
       ,j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
;

-- # 이름, 부서번호, 부서명, 업무아이디, 업무명, 도시아이디, 도시명 출력
select  e.first_name
       ,d.department_id
       ,d.department_name
       ,j.job_id
       ,j.job_title
       ,l.location_id
       ,l.city
from employees e
	join departments d
      on e.department_id = d.department_id
	join locations l
      on d.location_id = l.location_id
	join jobs j
      on e.job_id = j.job_id 
