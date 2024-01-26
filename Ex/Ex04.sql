-- ----------------------------------------------
-- 2024012 (수)
-- ----------------------------------------------
-- OUTER JOIN
-- ----------------------------------------------
-- join 조건을 만족하지 않는 column이 없는 경우 null을 포함하여 결과를 생성
-- 모든 row가 table에 참여x
-- null 이 올 수 있는 쪽 조건에 붙인다

-- left outer join  : 왼쪽의 모든 row는 결과 테이블에 나타남
-- right outer join : 오른쪽의 모든 row는 결과 테이블에 나타남
-- full outer join : 양쪽 모두 결과 테이블에 참여 -> union

-- ------------------------------
-- OUTER JOIN ( LEFT OUTER JOIN)
-- ------------------------------
-- null도 포함해서 보여줌

-- inner join으로 실행
-- 원하는 정보 : 모든 직원의 이름 -> department_id가 null 값인 직원은 제외하고 출력됨
select e.first_name
from employees e
	join departments d
     on e.department_id = d.department_id
order by e.first_name asc
; -- 106rows

-- outer join으로 실행 -> null값을 포함해 모든 직원의 이름을 출력
-- employees 의 first_name 이 원하는정보 -> employees 에 left outer join 으로 departments 를 붙인다
-- left : 기준을 잡아줌. 생략x / outer : 생략가능 / join ~ on ~ :  생략x
-- outer join 은 where절 로 표현하지 않는다

-- 왼쪽 table을 기준으로 조인
-- (Kimberely 가 결과에 있어야함 : 소속부서가 없는 직원) 따라서 employees에 left join 으로 departments 를 붙어야함
select  e.first_name
	   ,d.department_id
       ,d.department_name
from employees e
left outer join departments d
on e.department_id = d.department_id
; -- 107row : left outer join 으로 join 조건 department_id가 null값인 직원의 이름도 출력됨 

-- ------------------------------
-- OUTER JOIN ( RIGHT OUTER JOIN)
-- ------------------------------

-- 오른쪽 테이블을 기준으로 조인
-- (Treasury, Corporate Tax 등 16개의 부서명이 결과에 있어야함 : 부서인원이 없는 부서명)
select *
from employees e, departments d
where e.department_id = d.department_id
;









