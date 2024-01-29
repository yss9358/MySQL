-- --------------------------------------
-- 그룹함수
-- -------------------------------------
-- 여러행으로부터 하나의 결과값을 반환

-- 단일행 함수 
select  first_name
	   ,salary
from employees
;

-- SUM() : column 의 합계를 보여준다
-- 그룹함수
select  sum(salary)
from employees
;

-- 단일행함수와 그룹함수를 동시에 사용 x
select  first_name
	   ,salary
       ,sum(salary)
from employees
;
-- -----------------------------------------------
-- COUNT() : 함수에 입력되는 데이터의 총 건수를 구하는 함수
-- -----------------------------------------------

-- 제일 많은 row를 출력
select  count(*)
from employees;

select  count(first_name)
from employees;

-- count()에 column명을 작성하면 null은 제외하고 계산
select count(manager_id)
from employees;

select count(commission_pct)
from employees;

-- 데이터에 대한 이해를 가지고 count 를 작성해야한다
select  count(*)
       ,count(commission_pct) 
from employees;

-- # 월급이 16000 초과 되는 직원의 수는?
select  count(commission_pct) -- 갯수만 계산됨
from employees
where salary > 16000
;

-- --------------------------------------
-- SUM() : 입력된 데이터들의 합계 값을 구하는 함수
-- -------------------------------------- 
select  count(*)    -- null을 포함한 전체직원의 수
       ,sum(salary) -- 전체직원의 월급의 수
       ,count(commission_pct) -- 
from employees
;

-- ----------------------------
-- AVG() : 입력된 값들의 평균값을 구하는 함수
-- ---------------------------
-- avg 할때 null은 포함을 시키지 않음
-- null 을 포함시킬지 제외시킬지 정하고 계산해야함
-- null 도 포함을 시킬거면 ifnull(salary, 0) 으로 작성해 계산
select  count(*)
	   ,sum(salary)
       ,avg(ifnull(salary, 0))
from employees
;

-- ------------------------------------------------------
-- MAX() : 입력된 값들중 가장 큰값을 구하는 함수
-- MIN() : 입력된 값들중 가장 작은값을 구하는 함수
-- ------------------------------------------------------
-- 여러건의 데이터를 순서대로 정렬한 후 값을 구하기 때문에 데이터가 많을 때는 느리다
select  count(*)
	   ,max(salary)
       ,min(salary)
from employees
;

-- ------------------------------------------
-- GROUP BY 절
-- ----------------------------------------------
-- group 지은 column 은 같이 사용 가능
select department_id, sum(salary), count(*)
from employees
group by department_id
;

select  department_id, job_id, count(*), max(salary)
from employees
group by department_id, job_id
;


-- # 월급(salary)의 합계가 20000 이상인 부서의 부서 번호와, 인원수, 월급합계를 출력하세요
select  department_id
       ,count(*)
       ,sum(salary)
from employees
group by department_id
order by department_id
;

-- -------------------------------------
-- HAVING 절
-- -------------------------------------
select  department_id
       ,count(*)
       ,sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and department_id in (90, 100)
order by department_id asc
;


-- -------------------
-- if~ else문 
-- ----------------
-- IF( 조건문, True 값, false 값)  -> if
-- IFNULL 과 다름. -> null 일때 값을 
select  first_name
       ,salary
       ,commission_pct
       ,if(commission_pct is null, 0, 1) state
from employees;

-- -------------
-- case ~ end 문
-- ------------

-- 직원아이디, 월급 업무아이디, 실제월급을 출력하세요
-- 실제월급은 job_id 가 ac_acccount 면 월급+ 월급*0.1
--                   sa_rep 면 월급 + 월급*0.2
--                    st_clerk 월급 + 월급*0.3
--                    그외에는 월급

select  employee_id
       ,salary
       ,job_id
       ,case
       when job_id = 'AC_ACCOUNT' then salary + (salary*0.1)
       when job_id = 'SA_REP' then salary + (salary*0.2)
       when job_id = 'ST_CLERK' then salary + (salary*0.3)
       else salary
       end as realSalary
from employees
order by job_id asc
;

-- IF ~ ELSE 문 / CASE ~ END 문 예제
-- # 직원의 이름, 부서번호, 팀을 출력하세요
-- # 팀은 코드로 결정하며 부서코드가 
-- # 10 ~ 50 이면 'A-TEAM'
-- # 60 ~ 100 이면 'B-TEAM'
-- # 110 ~ 150 이면 'C-TEAM'
-- # 나머지는 '팀없음' 으로 출력하세요

select  first_name
       ,department_id
       ,case
			when department_id between 10 and 50 then 'A-TEAM'
		    when department_id between 60 and 100 then 'B-TEAM'
			when department_id between 110 and 150 then 'C-TEAM'
		else '팀없음'
       end as 팀
from employees
order by department_id asc
;

-- ----------------------------
-- JOIN
-- ----------------------------
-- # 직원의 이름과 직원이 속한 부서명을 함께 보고싶다면?
-- 사원이름, 부서번호
select  first_name
	   ,department_id
from employees
;

-- 부서명
select  *
from departments
;

-- join
-- from table, table, ... table
-- 만들수 있는 경우의수를 모두 계산
-- 어떤 table에서 가져온 data인지 확인을 해주어야함
-- from 절 별명으로 작성가능 , 별명으로 작성하면 별명으로만 작성해야함
-- 
select  first_name
       ,department_name
       ,employees.department_id
       ,departments.department_id
from employees, departments
where employees.department_id = departments.department_id
;

-- ------------
-- inner join
-- ----------

select  first_name 이름
       ,department_name 부서명
       ,e.department_id
       ,d.department_id 
  from employees e
inner join departments d -- inner 생략가능
        on e.department_id = d.department_id
;

-- EQUI JOIN


-- # 예제
-- # 모든 직원이름, 부서이름, 업무명을 출력하세요
select  e.first_name
       ,d.department_name
       ,j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
;

select  first_name
	   ,d.department_name
       ,j.job_title
from employees e inner join departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
;

select  first_name
       ,d.department_name
       ,job_title
from employees e 
	inner join departments d 
			on e.department_id = d.department_id 
            inner join jobs j 
            on e.job_id = j.job_id
;

-- # 이름, 부서번호, 부서명, 업무아이디, 업무명, 도시아이디, 도시명 출력

select	e.first_name 이름
	   ,e.department_id 부서번호
       ,d.department_name 부서명
       ,e.job_id 업무아이디
       ,j.job_title 업무명
       ,d.location_id 도시아이디
       ,l.city 도시명
from employees e
	inner join departments d
			on e.department_id = d.department_id
	inner join locations l
			on d.location_id = l.location_id
	inner join jobs j
			on e.job_id = j.job_id
order by 이름 asc
;


-- ----------------------------------------------
-- 20240124
-- -----------------------------------------------
-- outer join
-- ----------------------------------------------
-- join 조건을 만족하지 않는 column이 없는 경우 null 포함하여 결과를 생성
-- 모든 행이 table 참여

-- left outer join
select e.department_id
	  ,e.first_name
      ,d.department_name
from employees e
left outer join departments d on e.department_id = d.department_id -- left 는 기준을 잡아주기 때문에 생략x / outer는 생략가능 / join ~ on ~ 은 생략x  
;

-- right outer join
select d.department_name
	  ,e.first_name
from employees e
right join departments d on e.department_id = d.department_id
order by e.first_name desc
;

-- outer join left/right 방향에 대한 이해
-- null 값 처리 방식?
-- 


-- union
-- union 사용방법 : (select 문) union (select 문) ;
-- 정보를 보고싶은 두 select 문을 작성한 뒤에 union 으로 묶어준다
-- 중복된 정보는 버리고 각 select문에서만 존재하는 정보를 추가해서 하나로 만든다
-- 중복된 정보를 확실하게 확인할 수 있는 key값이 필요하다 ex) employee_id

select  e.first_name,
		d.department_name,
        e.department_id
from employees e left join departments d
on e.department_id = d.department_id
;



-- self join 
-- table 에 별명을 붙여서 같은 table을 join 시킬수있다 / 별명은 다르게
-- ex) employees e , employees em

-- 잘못된 join

select  e.first_name,
		e.salary,
        l.location_id,
        l.city,
        l.street_address
from employees e, locations l
where e.salary = l.location_id
;

-- -------------------------------------------------
-- ppt04 - SubQuery / rownum
-- -------------------------------------------------
-- query 문 안에 query문을 삽입해 사용

-- # 예제) 'Den'보다 월급을 많이 받는 사람의 이름과 월급은?

-- Den 의 월급을 구한다 -> Den의 월급인지 확인하기 위해 이름과 월급을 모두 출력해봄
select  first_name,
		salary
from employees
where first_name = 'den'
;
-- Den 의 월급보다 월급이 많은 사람의 이름과 월급을 구한다
select first_name
,      salary
from employees
where salary >= 11000
order by salary desc
;
-- SubQuery문을 이용해 한번에 해결한다 
select first_name
  ,  salary
from employees
where salary >= (select salary 
				 from employees
                 where first_name = 'den'
                 )
order by salary desc
;

-- subQuery 작성시 주의사항
-- subQuery 부분은 괄호처리 
-- order by는 가급적 사용하지 않는다
-- 단일행함수 <-> 다중행함수 를 구분해서 사용해야함 / date를 이해하고 연산자 선택 중요

-- # 예제) 월급을 가장 적게 받는 사람의 이름,월급,사원번호는

-- 직원들의 이름,월급,사원번호를 출력
select  first_name
	   ,salary
       ,employee_id
from employees
order by salary asc
;

-- 가장 적은 월급을 출력
select min(salary)
from employees
;

-- 직원들의 이름,월급,사원번호를 출력 하는데 월급이 가장 적은 사람의 정보만 출력
select  first_name
       ,salary
       ,employee_id
from employees
where salary = (select min(salary)
				from employees)
;

-- # 예제) 평균 월급보다 적게 받는 사람의 이름,월급을 출력하세요

-- 직원들의 평균 월급 출력
select  avg(salary)
from employees
;

-- 직원들의 이름과 월급 출력
select  first_name
       ,salary
from employees
;

-- 직원들의 이름과 월급을 출력하는데, 평균 월급보다 적게 월급을 받는 사람 출력
select  first_name
	   ,salary
from employees
where salary < (select avg(salary)
				from employees)
;

-- ---------------------------
-- 다중행 subQuery 
-- ---------------------------------

-- # 예제) 부서번호가 110인 직원의 급여와 같은 월급을 받는
-- #      모든 직원의 사번, 이름, 급여를 출력하세요

-- ------------
-- IN 연산자 활용
-- ------------

-- 부서번호 = 110 / 급여
select salary
from employees
where department_id = 110
;

-- 직원의 사번, 이름, 급여 를 출력해야함
select  employee_id
       ,first_name
       ,salary
from employees
;

-- 직원의 사번, 이름, 급여를 출력해야하는데, 부서번호가 110 인사람의 급여와 같은 모든 직원
select  employee_id
	   ,first_name
       ,salary
from employees
where salary in (select salary
				from employees
                where department_id = 110
                )
; -- in 연산자는 where ~ or ~ 의 의미

-- subQuery 문 결과가 여러개 일경우 = 대신 다른 연산자를 써야한다
-- subQuery 문에는 원하는 결과값만 나타낼수 있도록 select문을 작성해야한다

-- # 예제) 각 부서별로 최고급여를 받는 사원의 이름과 월급을 출력하세요

-- 각 부서별 - 그룹화
-- 최종출력 부서별 / 이름 / 월급

-- 각 부서별 최고급여 값 구하기
select  department_id -- 확인용
	   ,max(salary)
from employees
group by department_id
;

-- 각 부서별 최고급여를 받는 사원의 이름과 월급
select  e.department_id
	   ,e.first_name
       ,e.salary
from employees e
where (department_id, salary) in (select department_id
										,max(salary)
								  from employees 
							      group by department_id)
order by department_id asc
; -- where 절 안의 subQuery 의 select 문 결과값이 여러개 -> in 연산자 사용
-- where ~ subQuery 문 작성시 subQuery 문의 값 
-- 

/*
부서별 최고값 이름
부서별 최저값 이름
월급 최저인 직원의 월급과 이름
가장 적게 월급을 받는 직원의 이름, 월급은?
*/

select  department_id
       ,max(salary)
from employees
group by department_id
;

select	 first_name
		,salary
from employees
where (department_id, salary) in (select department_id 
										,max(salary)
								  from employees
								  group by department_id)
;

select	department_id
	   ,first_name
       ,salary
from employees e
where (department_id, salary) in (select department_id
										,min(salary)
								  from employees
                                  group by department_id)
order by department_id asc
;

-- -------------
-- ANY 연산자 활용
-- -------------

/*
부서번호가 110인 직원의 급여 보다 큰
모든 직원의 이름, 급여를 출력하세요 (or 여산 --> 8300보다 큰)
*/

-- # 월급이 15000 보다 큰 직원의 이름, 급여를 출력하세요

select  e.first_name
       ,e.salary
from employees e
where salary > 15000
order by e.salary asc
;

-- 부서번호가 110인 직원의 월급
select  e.department_id
	   ,e.first_name
	   ,e.salary
from employees e
where department_id = 110
;

-- IN 연산자는 같다만 활용
select  first_name
	   ,salary
from employees e
where salary > any (select e.salary
					from employees e
					where department_id = 110)
order by salary asc
;

-- -----------------------
-- ALL 연산자 활용
-- -----------------------

select *
from employees
where department_id = 110
;

select first_name
	  ,salary
from employees e
where salary > ALL (select salary
				    from employees e
                    where department_id = 100)
;

-- ----------------------------------------------
-- SubQuery 문을 where절에서 쓸때랑 from 절에 쓸때 비교
-- ---------------------------------------------

-- # 각 부서별로 최고급여를 받는 사원을 출력하세요

select  department_id
	   ,max(salary)
from employees e
group by department_id
;

select  department_id
	   ,employee_id
       ,first_name
	   ,salary
from employees e
where (department_id, salary) in (select department_id
										,max(salary)
								  from employees e
                                  group by department_id)
;

select *
from employees e, (select department_id
						 ,max(salary)
				   from employees e
				   group by department_id) s
where e.department_id = s.department_id

;

-- ------------------
-- limit
-- ------------------
-- limit 시작할번호-1 , 1번부터 시작해서 보여줄 개수

select *
from employees
order by employee_id asc
limit 1,5
;

select *
from employees
order by employee_id asc
limit 5 offset 0
;

-- 예제) 07년에 입사한 직원중 급여가 많은 직원 중 3에서 7등의 이름, 급여, 입사일

-- --------------------------------------------------------------

select  first_name
       ,salary
       ,hire_date
from employees
where hire_date >= '07/01/01'
and hire_date < '08/01/01' 
order by salary desc
limit 2,5
;



-- ----------------------------------------------------------------------------



   