-- ---------------------------------------------
-- 20240125 Practice05_mySQL 혼합 SQL 문제입니다.
-- ---------------------------------------------

/*
문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)
*/

-- 담당매니저 o / 커미션비율 x / 월급 > 3000
-- 출력 : 이름 / 매니저아이디 / 커미션비유 /월급

select  first_name 이름
	   ,manager_id 매니저아이디
       ,commission_pct 커미션비율
       ,salary 월급
from employees
where manager_id is not null
and  commission_pct is null
and salary > 3000
; -- row(s) 45

/*
문제2. 
각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name), 월급
(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하
세요
-조건절비교 방법으로 작성하세요
-월급의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)
*/

-- 각 부서별로 -> 부서아이디 그룹화 / 최고의월급 max(salary)
-- 출력 : 직원번호 / 이름 / 월급 / 입사일 / 전화번호 / 부서번호
-- 정렬 : 월급 내림차순 order by
-- 조건절에서 비교 where
-- 입사일 형식 2001-01-13 토요일  -> '%Y-%m-%d 토요일'
-- 전화번호 형식 515-123-4567

-- 부서별 최고의 월급 
select  department_id
	   ,max(salary)
from employees
group by department_id
;
-- 요일을 한글표시 
select  case weekday(hire_date)
			when '0' then '월요일'
			when '1' then '화요일'
			when '2' then '수요일'
			when '3' then '목요일'
			when '4' then '금요일'
			when '5' then '토요일'
			when '6' then '일요일'
		end as day
	   ,hire_date
from employees;

select  employee_id 직원번호
	   ,first_name 이름
	   ,salary 월급
       ,concat(date_format(e.hire_date, '%Y-%d-%m'),' ',day) 입사일
       ,phone_number 전화번호
       ,department_id 부서번호
from employees e,(select hire_date
						,case weekday(hire_date)
							when '0' then '월요일'
							when '1' then '화요일'
							when '2' then '수요일'
							when '3' then '목요일'
							when '4' then '금요일'
							when '5' then '토요일'
							when '6' then '일요일'
						end as day
					from employees) s
where (department_id, salary) in (select  department_id
										 ,max(salary)
								  from employees
								  group by department_id)
and e.hire_date = s.hire_date
order by salary desc
; -- row(s) 11



