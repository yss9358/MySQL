-- -------------------------------------------------
-- 20240124 Practice03 테이블간 조인(JOIN) SQL 문제입니다.
-- -------------------------------------------------

/*
문제1.
직원들의 사번(employee_id), 이름(first_name), 성(last_name)과 부서명(department_name)을
조회하여 부서이름(department_name) 오름차순, 사번(employee_id) 내림차순 으로 정렬하세
요.
(106건)
*/

-- 필요한 정보
-- employees -> employee_id / first_name / last_name
-- departments -> department_name 
-- 정렬 : department_name asc , employee_id desc

select e.employee_id 사번
	  ,e.first_name 이름
      ,e.last_name 성
      ,d.department_name 부서명
from employees e
	inner join departments d
			on e.department_id = d.department_id
order by department_name asc, employee_id desc
; -- 106 row(s)

/*
문제2.
employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
직원들의 사번(employee_id), 이름(first_name), 월급(salary), 부서명(department_name), 현
재업무(job_title)를 사번(employee_id) 오름차순 으로 정렬하세요.
부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.
(106건)
*/

-- 필요한 정보 :
-- employees -> employee_id / first_name / salary 
-- departmnets -> department_name
-- jobs -> job_title
-- 정렬 : employee_id asc 
-- 부서가 없는 Kimberely(사번 178)은 표시하지 않습니다. -> department_id is null
-- null값이 들어있지만 제외하고 출력 -> inner join 사용 / outer join 사용 x

select  e.employee_id 사번
       ,e.first_name 이름
       ,e.salary 월급
       ,d.department_name 부서명
       ,j.job_title 현재업무
from employees e
	inner join departments d
			on e.department_id = d.department_id
	inner join jobs j
			on e.job_id = j.job_id
order by employee_id asc
; -- row(s) 106

/*
문제2-1.
문제2에서 부서가 없는 Kimberely(사번 178)까지 표시해 보세요
(107건)
*/

-- join 조건 department id 가 null 인 Kimberely 를 포함시키려면 outer join 사용
select  e.employee_id 사번
       ,e.first_name 이름
       ,e.salary 월급
       ,d.department_name 부서명
       ,j.job_title 현재업무
from employees e
	left outer join departments d
				 on e.department_id = d.department_id
	left outer join jobs j
				 on e.job_id = j.job_id
; -- row(s) 107

/*
문제3.
도시별로 위치한 부서들을 파악하려고 합니다.
도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력하세요
부서가 없는 도시는 표시하지 않습니다.
(27건)
*/

-- 부서가 없는 도시는 표시 x -> null 값 표시 x
-- 필요한 정보 :
-- departments -> department_id / department_name / location_id
-- locations -> location_id / city
-- 정렬 : location asc

select  l.location_id
       ,l.city
       ,d.department_name
       ,d.department_id
from departments d, locations l
where d.location_id = l.location_id
order by location_id asc
; -- row(s) 27

/*
문제3-1.
문제3에서 부서가 없는 도시도 표시합니다.
(43건)
*/

-- right outer join
-- 부서가 없는 도시도 표시 -> null 값이 들어 있는 도시도 표시
-- 도시를 표시 : locations 에 정보가 있다

select  l.location_id
       ,l.city
       ,d.department_name
       ,d.department_id
from departments d
	right outer join locations l
				  on d.location_id = l.location_id
order by location_id asc
; -- row(s) 43

/*
문제4.
지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하
되 지역이름(오름차순), 나라이름(내림차순) 으로 정렬하세요.
(25건)
*/

-- 필요한 정보 : left outer join
-- regions -> region_name
-- countries -> country_name
-- 정렬 : region_name asc , country_name desc

select  region_name 지역이름
       ,country_name 나라이름
from countries c
	left outer join regions r
				 on c.region_id = r.region_id
order by r.region_name asc, c.country_name desc
; -- row(s) 25

/*
문제5. 
자신의 매니저보다 채용일(hire_date)이 빠른 사원의
사번(employee_id), 이름(first_name)과 채용일(hire_date), 매니저이름(first_name), 매니저입
사일(hire_date)을 조회하세요.
(37건)
*/

-- 필요한 정보 : self join 개념이해 필요
-- employees e  -> employee_id / first_name / hire_date 
-- employees em -> first_name / hire_date
-- where e.hire_date < em.hire_date / e.manager_id = em.employee_id

select  e.employee_id 사번
	   ,e.first_name 이름
       ,e.hire_date 채용일
       ,em.first_name 매니저이름
       ,em.hire_date 매니저입사일
from employees e, employees em
where e.manager_id = em.employee_id
and e.hire_date < em.hire_date
; -- row(s) 37

/*
문제6.
나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다.
나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를 나라명(오름차순)로 정렬하여
출력하세요.
값이 없는 경우 표시하지 않습니다.
(27건)
*/

-- 필요한 정보 : 값이 없는 경우 출력 x -> inner join 의 순서파악 / inner join 으로 도출해낸 결과값을 join 
-- countires   -> country_name / country_id 
-- locations   -> city / location_id
-- departments -> department_name / department_id
-- 정렬 :county_name asc

select  c.country_name 나라명
       ,c.country_id 나라아이디
       ,l.city 도시명
       ,l.location_id 도시아이디
       ,d.department_name 부서명
       ,d.department_id 부서아이디
from departments d
	join locations l
	  on d.location_id = l.location_id
	join countries c
	  on l.country_id = c.country_id
order by country_name asc
; -- row(s) 27

/*
문제7.
job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다.
과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한 사원의 사번, 이름(풀네임), 업무아이
디, 시작일, 종료일을 출력하세요.
이름은 first_name과 last_name을 합쳐 출력합니다.
(2건)
*/

-- 필요한 정보 :  
-- employees -> employee_id / first_name, last_name / job_id
-- job_history -> job_id / start_date / end_date
-- jobs -> 'AC_ACCOUNT'
-- where job_id = 'AC_ACCOUNT' 

select  e.employee_id 사번
       ,concat(e.first_name, ' ', e.last_name) 이름
       ,e.job_id 업무아이디
       ,jh.start_date 시작일
       ,jh.end_date 종료일
from employees e
    join jobs j
      on e.job_id = j.job_id
	join job_history jh
      on e.employee_id = jh.employee_id
where jh.job_id = 'AC_ACCOUNT'
; -- row(s) 2

/*
문제8.
각 부서(department)에 대해서 부서번호(department_id), 부서이름(department_name), 
매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 나라(countries)의 이름
(countries_name) 그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요.
(11건)
*/

-- employees   -> manager_first_name
-- departments -> department_id / department_name / manager_id = employees.first_name
-- locations   -> city 
-- countries   -> country_name
-- regions     -> region_id  

-- 보고싶은 결과물을 그려서 해당하는 기준을 잡는다
-- 각 부서별 -> departments 기준 -> join 
-- departments 의 manager_id 와 employees 의 employee_id 같다 -> 매니저이름

select  d.department_id 부서번호
       ,d.department_name 부서이름
       ,concat(e.first_name, ' ', e.last_name) 매니저이름
       ,l.city 도시이름
       ,c.country_name 나라이름
       ,r.region_name 지역구분
from departments d
	join employees e on d.manager_id = e.employee_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
    join regions r   on c.region_id = r.region_id
; -- row(s) 11

/*
문제9.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
매니저가 없는 Steven도 표시합니다.
(107명)
*/

-- 각 사원 -> employees -> 사번 / 이름 / 부서명 / 매니저의 이름 조회
-- 부서명 -> departments join 
-- 부서가 없는 직원 표시 -> departments outer join
-- 매니저가 없는 steven 표시 

select  e.employee_id 사번
       ,e.first_name 이름
       ,ifnull(d.department_name, '부서없음') 부서명
       ,ifnull(em.first_name, '매니저없음') 매니저이름
from employees e
	left outer join departments d
				 on e.department_id = d.department_id
	left outer join employees em
				 on e.manager_id = em.employee_id	
; -- row(s) 107

/*
문제9-1.
문제9 에서 부서가 없는 직원(Kimberely)도 표시하고.
매니저가 없는 Steven도 표시하지 않습니다.
(106명)
*/

-- Kimberely : 부서없음, 표시 -> outer join
-- Steven : 매니저없음, 표시 x -> inner join

select  e.employee_id 사번
       ,e.first_name 이름
       ,d.department_name 부서명
       ,em.first_name
from employees e
	left outer join departments d
				 on e.department_id = d.department_id
			   join employees em
                 on e.manager_id = em.employee_id
; -- row(s) 106
                 
/*
문제9-2.
문제9 에서 부서가 없는 직원(Kimberely)도 표시하지 않고
매니저가 없는 Steven도 표시하지 않습니다.
(105명)
*/

-- Kimberely : 부서없음, 표시 x -> inner join
-- Steven : 매니저없음, 표시 x -> inner join

select  e.employee_id 사번
	   ,e.first_name 이름
       ,d.department_name 부서명
       ,em.first_name 매니저이름
from employees e
	join departments d
      on e.department_id = d.department_id
	join employees em
      on e.manager_id = em.employee_id
; -- row(s) 105