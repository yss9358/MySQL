-- -------------------------------------------------------
-- 20240125 Practice04_mySQL 서브쿼리(SUBQUERY) SQL 문제입니다.
-- -------------------------------------------------------

/*
문제1.
평균 월급보다 적은 월급을 받는 직원은 몇명인지 구하시요.
(56건)
*/

-- 평균월급 구하기 -> 평균월급보다 작은 직원의 수 구하기 -> count

select  avg(e.salary) -- 6461.831776
from employees e
;

select count(*) -- 56
from employees e
where e.salary < (select avg(e.salary)
				from employees e)
; -- row(s) 1 = 56

/*
문제2. 
평균월급 이상, 최대월급 이하의 월급을 받는 사원의
직원번호(employee_id), 이름(first_name), 월급(salary), 평균월급, 최대월급을 월급의 오름차
순으로 정렬하여 출력하세요
(51건)
*/

-- 평균월급 <= 월급 <= 최대월급
-- 직원번호 / 이름 / 월급 / 평균월급 /최대월급
-- 정렬 : 월급 오름차순

-- 평균월급
select avg(e.salary) -- 6461.831776
from employees e
;

-- 최대월급
select max(e.salary) -- 24000
from employees e
;

-- 평균월급 <= 월급 <= 최대월급 출력
select  e.employee_id 직원번호
	   ,e.first_name 이름
       ,e.salary 월급
       ,(select avg(e.salary) -- 6461.831776
		 from employees e) 평균월급
       ,(select max(e.salary) -- 24000
		 from employees e) 최대월급
from employees e
where e.salary between (select avg(e.salary)
						from employees e)
				   and (select max(e.salary)
						from employees e)
order by e.salary asc
; -- row(s) 51

/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소
를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주
(state_province), 나라아이디(country_id) 를 출력하세요
(1건)
*/

-- 출력 : 도시아이디 / 거리명 / 우편번호 / 도시명 / 주 / 나라아이디 -> locations
-- 출력 -> employees join departments join locations
-- first_name, last_name -> employees

select  concat(e.first_name, ' ', e.last_name)
	   ,e.employee_id
from employees e
where e.first_name = 'Steven'
and e.last_name = 'king'
;

select  l.location_id 도시아이디
	   ,l.street_address 거리명
       ,l.postal_code 우편번호
       ,l.city 도시명
       ,l.state_province 주
       ,l.country_id 나라아이디
from employees e
	join departments d
	  on e.department_id = d.department_id
	join locations l
      on d.location_id = l.location_id
where (e.first_name, e.last_name) in (select e.first_name, e.last_name
									  from employees e
									  where e.first_name = 'Steven'
									  and e.last_name = 'king')
; -- row(s) 1 

/*
문제4.
job_id 가 'ST_MAN' 인 직원의 월급보다 작은 직원의 사번,이름,월급을 월급의 내림차순으로
출력하세요 -ANY연산자 사용
(74건)
*/

-- job_id = 'ST_MAN' 직원의 월급 > 직원의 월급
-- 출력 : 사번 / 이름/ 월급
-- 정렬 : 월급 내림차순

-- job_id = 'ST_MAN' 직원의 월급 , 5개의 값 확인
select e.salary
from employees e
where e.job_id = 'ST_MAN' 
; -- row(s) 5

-- job_id = 'ST_MAN' 직원의 max(salary) = 8000 -> 8000이하의 값들만 나와야함
select  e.employee_id 사번
	   ,e.first_name 이름
       ,e.salary 월급
from employees e
where e.salary < ANY (select e.salary
					  from employees e
					  where e.job_id = 'ST_MAN' )
order by e.salary desc
; -- row(s) 74

/*
문제5. 
각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name)과 월급
(salary) 부서번호(department_id)를 조회하세요
단 조회결과는 월급의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)
*/

-- 각 부서별 -> 그룹화 / 최고의월급 -> max(salary)
-- 출력 : 직원번호 / 이름 / 월급 / 부서번호
-- 정렬 : 월급 내림차순
-- 조건절비교 / 테이블조인 2가지 방법

-- 각 부서별 최고의 월급
select  e.department_id
	   ,max(salary) 
from employees e
group by e.department_id
;

-- 조건절 비교
select  e.employee_id 직원번호
	   ,e.first_name 이름
       ,e.salary 월급
       ,e.department_id 부서번호
from employees e
where (e.department_id, e.salary) in (select e.department_id
											,max(e.salary)
									  from employees e
									  group by e.department_id)
order by e.salary desc
; -- row(s) 11

-- 테이블조인 -> max값 별명지어주기 
select  e.employee_id 직원번호
	   ,e.first_name 이름
       ,e.salary 월급
       ,e.department_id 부서번호
from employees e, (select  e.department_id
						  ,max(e.salary) salary
				   from employees e
				   group by e.department_id) s
where e.department_id = s.department_id
and e.salary = s.salary
; -- row(s) 11

/*
문제6.
각 업무(job) 별로 월급(salary)의 총합을 구하고자 합니다. 
월급 총합이 가장 높은 업무부터 업무명(job_title)과 월급 총합을 조회하시오
(19건)
*/

-- 각 업무별 -> job_id 그룹화 / 월급의 총합 -> sum(salary)
-- 출력 : 업무명 / 월급총합
-- 정렬 : 월급총합 내림차순

-- 각 업무별 월급의 총합
select  job_id
	   ,sum(salary)
from employees 
group by job_id
;

select  j.job_title
	   ,s.salary
from jobs j, (select  job_id
					 ,sum(salary) salary
			  from employees 
			  group by job_id) s
where j.job_id = s.job_id
;

/*
문제7.
자신의 부서 평균 월급보다 월급(salary)이 많은 직원의 직원번호(employee_id), 이름
(first_name)과 월급(salary)을 조회하세요
(38건)
*/

-- 부서 평균 월급 -> 부서 그룹화
-- 월급 > 부서평균월급
-- 출력 : 직원번호 / 이름 / 월급

-- 부서 평균 월급
select  department_id
	   ,avg(salary)
from employees
group by department_id
;

select  e.employee_id 직원번호
	   ,e.first_name 이름
       ,e.salary 월급
from employees e, (select department_id
						 ,avg(salary) salary
					from employees
					group by department_id) s
where e.department_id = s.department_id
and e.salary > s.salary
; -- row(s) 38

/*
문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 월급, 입사일을 입사일 순서로 출력하세요
*/

select  employee_id
	   ,first_name
	   ,salary
       ,hire_date
from employees
order by hire_date asc
limit 10, 5
;




