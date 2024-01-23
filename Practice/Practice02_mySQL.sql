-- 집계(통계) SQL 문제입니다.

/*
문제1.
매니저가 있는 직원은 몇 명입니까? 아래의 결과가 나오도록 쿼리문을 작성하세요

haveMngCnt
106

*/

-- count 로 총 몇명인지 확인. haveMngCnt 로 별명작성
-- manager_id 가 null 이 아닌 직원수 확인
-- count() 안에 column 명을 작성하면 null 제외

select  count(manager_id) haveMngCnt
from employees e
;

/*
문제2.
직원중에 최고임금(salary)과 최저임금을 "최고임금", "최저임금" 으로 출력해 보세요. 
두 임금의 차이는 얼마인가요? "최고임금 – 최저임금"이란 타이틀로 함께 출력해 보세요.
*/

-- 최고임금(salary) -> max(salary) 최고임금
-- 최저임금(salary) -> min(salary) 최저임금
-- 두 임금의 차이 -> '최고임금 - 최저임금'

select  salary 임금
from employees e
order by salary desc
;

-- 최고임금 max = 24000.00 / 최저임금 min = 2100.00
-- 두 임금의 차이 = '최고임금 - 최저임금' 출력

select	max(salary) 최고임금
	   ,min(salary) 최저임금
       ,max(salary) - min(salary) '최고임금 - 최저임금'
from employees e
;

/*
문제3.
마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
예) 2014년 07월 10일
*/

-- 마지막 들어온날 -> hire_date 가 max 인 직원
-- 구한 max 값 -> date_format 으로 변경
-- date_format(max(hire_date), '%Y년%m월%d일')

select date_format(max(hire_date), '%Y년%m월%d일') '마지막 신입사원이 들어온 날'
from employees e
;

/*
문제4.
부서별로 평균임금, 최고임금, 최저임금을 부서아이디(department_id)와 함께 출력합니다.
정렬순서는 부서번호(department_id) 내림차순입니다.
*/

-- 부서별-> group by / 평균임금 -> avg(salary) / 최고임금 -> max(salary) / 최저임금 -> min(salary)
-- 부서아이디 -> department_id / 정렬순서 -> department_id desc

select	ifnull(department_id, 0) 부서아이디  -- null 값 0처리
       ,avg(ifnull(salary, 0)) 평균임금     -- null 값 0처리
       ,max(salary) 최고임금
       ,min(salary) 최저임금
from employees e
group by department_id        -- department_id를 그룹화
order by department_id desc   -- 정렬순서
;

/*
문제5.
업무(job_id)별로 평균임금, 최고임금, 최저임금을 업무아이디(job_id)와 함께 출력하고 정렬
순서는 최저임금 내림차순, 평균임금(소수점 반올림), 오름차순 순입니다.
(정렬순서는 최소임금 2500 구간일때 확인해볼 것)
*/

-- 업무(job_id)별로 -> 그릅화 / 평균임금 -> avg(salary) / 최고임금 -> max(salary) / 최저임금 -> min(salary)
-- 업무아이디 -> job_id / 순서 : (1)최저임금 내림차순 -> order by min(salary) desc
-- (2)평균임금(소수점 반올림) 오름차순 -> round(avg(salary)) asc
-- 정렬순서 확인 최소임금 2500 -> min(salary) = 2500 

select	job_id 업무아이디
	   ,avg(ifnull(salary, 0)) 평균임금       -- null 이면 0처리
       ,max(salary) 최고임금
       ,min(salary) 최저임금
from employees e
group by job_id
order by min(salary) desc, round(avg(salary)) asc
;

/*
문제6.
가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
예) 2005-08-20 Saturday
*/

-- 가장 오래 근속한 직원의 입사일 -> min(hire_date)
-- 2005-08-20 Saturday 형식 -> '%Y-%m-%d %W'
-- hire_date 를 date_format(min(hire_date), '%Y-%m-%d %W') 로 변환

select  date_format(min(hire_date), '%Y-%m-%d %W') '가장 오래 근속한 직원의 입사일'
from employees e
;

/*
문제7.
평균임금과 최저임금의 차이가 2000 미만인 부서(department_id), 평균임금, 최저임금 그리
고 (평균임금 – 최저임금)를 (평균임금 – 최저임금)의 내림차순으로 정렬해서 출력하세요.
*/

-- 평균임금, 최저임금, (평균임금 - 최저임금) -> 부서 그룹화
-- 부서 -> departmetn_id / 평균임금 -> avg(salary) / 최저임금 -> min(salary) 
-- (평균임금 - 최저임금) -> (avg(salary) - min(salary)
-- 평균임금과 최저임금의 차이가 2000 미만 -> where avg(salary) - min(salary) < 2000
-- (평균임금 - 최저임금)의 내림차순 -> order by (avg(salary) - min(salary)) desc
 
select	ifnull(department_id, 0) 부서   -- null 이면 0 처리
       ,avg(ifnull(salary, 0)) 평균임금  -- null 이면 0 처리
       ,min(salary) 최저임금
       ,avg(ifnull(salary, 0)) - min(salary) '평균임금 - 최저임금' -- null 이면 0처리
from employees e
group by department_id
having avg(ifnull(salary, 0)) - min(salary) < 2000  -- null 이면 0 처리
order by avg(ifnull(salary, 0)) - min(salary) desc  -- null 이면 0 처리
;

/*
문제8.
업무(JOBS)별로 최고임금과 최저임금의 차이를 출력해보세요.
차이를 확인할 수 있도록 내림차순으로 정렬하세요
*/

-- 업무별 -> job_id 그룹화
-- 최고임금 -> max(salary) / 최저임금 -> min(salary) / 최고임금과 최저임금의 차이 -> max(salary) - min(salary)
-- 내림차순 정렬 -> order bymax(salary) - min(salary) desc

select	job_id 업무
       ,max(salary) - min(salary) '최고임금과 최저임금의 차이'
from employees e
group by job_id
order by max(salary) - min(salary) desc
;

/*
문제9
2005년 이후 입사자중 관리자별로 평균급여 최소급여 최대급여를 알아보려고 한다.
출력은 관리자별로 평균급여가 5000이상 중에 평균급여 최소급여 최대급여를 출력합니다.
평균급여의 내림차순으로 정렬하고 평균급여는 소수점 첫째짜리에서 반올림 하여 출력합니다.
매니저아이디는 manager_id, 평균급여는 avg, 최대급여는 max, 최소급여는 min 으로 출력
합니다.
*/

-- 2005년 이후 입사자 -> hire_date >= 2005-01-01 / 관리자별 -> manager_id 그룹화
-- 평균급여 -> avg(salary) / 최소급여 -> min(salary) / 최대급여 -> max(salary)
-- where avg(salary) >= 5000  -> 평균급여, 최소급여, 최대급여
-- 평균급여 -> desc / 평균급여 -> round(avg(salary),0) 
-- 매니저아이디 -> 'manager_id' / 평균급여 -> 'avg' / 최대급여 -> 'max' / 최소급여 -> 'min' 출력

select	manager_id 'manager_id'
       ,round(avg(ifnull(salary, 0)), 0)avg
       ,max(salary) max
       ,min(salary) min
from employees e
group by manager_id , hire_date
having hire_date >= '2005-01-01'
   and avg(ifnull(salary, 0)) >= 5000
order by avg(ifnull(salary, 0)) desc
;

/*
문제10
아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다. 
입사일이 02/12/31일 이전이면 '창립맴버', 03년은 '03년입사', 04년은 '04년입사'
이후입사자는 '상장이후입사' optDate 컬럼의 데이터로 출력하세요.
정렬은 입사일로 오름차순으로 정렬합니다.
*/

-- 직원을 입사일 기준으로 나눈다 -> 누구인지알아야함. 입사일 기준으로 나눠야함 -> concat(first_name,' ',last_name) , hire_date
-- hire_date <= 2002-12-31                      -> '창립멤버'
-- hire_date between 2003-01-01 and 2003-12-31  -> '03년입사'
-- hire_date between 2004-01-01 and 2004-12-31  -> '04년입사'
-- hire_date > 2004-12-31                       -> '상장이후입사'
-- column 명은 optDate / 정렬은 입사일기준 오름차순 -> order by hire_date asc

select  concat(first_name,' ',last_name) 이름
       ,hire_date 입사일
       ,case
			when hire_date <= '2002-12-31' then '창립멤버'
            when hire_date between '2003-01-01' and '2003-12-31' then '03년입사'
            when hire_date between '2004-01-01' and '2004-01-01' then '04년입사'
            else '상장이후입사'
		end optDate
from employees e
order by hire_date asc
;

/*
문제11 - 필요한 함수를 검색하고 사용법을 주석으로 남겨두세요
가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
예) 2005년 08월 20일(토요일)
*/

-- ppt 참고
-- 가장 오래 근속한 직원의 입사일 -> min(hire_date)
-- 2005년 08월 20일(토요일) 형식으로 출력 
-- date_format() 으로 min(hire_date)를 '%Y년  %m월  %d일(토요일)' 로 변환
-- date_format(min(hire_date), '%Y년  %m월  %d일(토요일)')

select  date_format(min(hire_date), '%Y년  %m월  %d일(토요일)')
from employees e
;
