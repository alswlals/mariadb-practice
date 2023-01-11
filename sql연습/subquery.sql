-- subquery

--
-- 1) select절, insert values(....)의 서브쿼리
--

--
-- 2) from절의 서브쿼리
--
select now() as n, sysdate() as s, 3 + 1 as r from dual;
select a.n, a.r
	from (select now() as n, sysdate() as s, 3 + 1 as r from dual) a;

--
-- 3) where절의 서브쿼리
--

-- 예제) 현재, Fai Bale이 근무하는 부서에서 근무하는 다른 직원의 사번, 이름을 춟력하세요.
-- 번호를 알아내기 위한 커리
select b.dept_no
	from employees a, dept_emp b
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01' and concat(first_name, ' ', a.last_name) = 'Fai Bale';
    
-- 'd004' 실제 출력값 알아내는 쿼리
select a.emp_no, a.first_name 
	from employees a, dept_emp b
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01' and b.dept_no = 'd004';

-- subquery
select a.emp_no, a.first_name 
	from employees a, dept_emp b
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01'
    and b.dept_no = (select b.dept_no
						from employees a, dept_emp b
						where a.emp_no = b.emp_no
						and b.to_date = '9999-01-01'
                        and concat(first_name, ' ', a.last_name) = 'Fai Bale');

-- 3-1) 단일행 연산자:  =,  >, <, >=, <=, <>, != (비교연산자)
-- 실습 문제 1: 현재, 전체 사원의 평균 연봉보다 적은 급여를 받는 사원의 이름과 급여를 출력하세요.
select avg(salary)
	from salaries
    where to_date = '9999-01-01';
    
select a.first_name, b.salary
	from employees a, salaries b
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01' -- join 쓰는 것도 좋음
    and b.salary < (select avg(salary)
						from salaries
						where to_date = '9999-01-01')
	order by b.salary desc;

-- 실습 문제 2: 현재, 가장 적은 평균 급여의 직책과 그 평균급여를 출력하세요. (ex. Engineer 20000)
-- 직책별 평균 급여부터 구해야 함 group by title

-- 1) 직책별 평균 급여
select a.title, avg(b.salary) as avg_salary
	from titles a, salaries b
    where a.emp_no = b.emp_no
    and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
    group by a.title
    /* order by avg(salary) asc
    limit 0, 1 */;
-- 2) 직책별 가장 적은 평균 급여
select min(a.avg_salary)
	from (select a.title, avg(b.salary) as avg_salary
			from titles a, salaries b
			where a.emp_no = b.emp_no
			and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
			group by a.title) a;
-- 3) sol 1 : subquery
select a.title, avg(b.salary) as avg_salary
	from titles a, salaries b
    where a.emp_no = b.emp_no
    and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
    group by a.title
    having avg_salary = (select min(a.avg_salary)
							from (select a.title, avg(b.salary) as avg_salary
									from titles a, salaries b
									where a.emp_no = b.emp_no
									and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
									group by a.title) a);
    
-- 4) sol 2 : top-k
select a.title, avg(b.salary) as avg_salary
	from titles a, salaries b
	where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
	group by a.title
    order by avg_salary asc
    limit 0, 1;
    
    
    
    
-- 3-2) 복수행 연산자: 
 


-- insert into post values ((select max(group_no) from post), from dual);
