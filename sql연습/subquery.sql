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
    
    
    
-- 3-2) 복수행 연산자: in, not in, any + 비교연산자, all + 비교연산자

-- any 사용법
-- 1. =any : in 
-- 2. >any , >=any : 최소값
-- 3. <any , <=any : 최대값
-- 4. <>any , !=any : not in

-- all 사용법
-- 1. =all:(x)
-- 2. >all, >=all : 최대값
-- 3. <all, <=all : 최소값
-- 4. <>all , !=all : not in
 
-- 실습 문제 3
-- 현재 급여가 5000 이상인 직원의 이름과 급여를 출력하세요.
-- 둘리 6000
-- 또치 8000

-- sol 1) join
select a.first_name, b.salary
	from employees a, salaries b
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01'
    and b.salary > 50000
    order by b.salary asc;

-- sol 2) subquery    
select a.first_name, b.salary
	from employees a, salaries b
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01'
    and (a.emp_no, b.salary) in (select emp_no, salary
									from salaries
									where to_date = '9999-01-01'
									and salary > 50000)
	order by b.salary asc;
    
-- sol 3) subquery    
select a.first_name, b.salary
	from employees a, salaries b
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01'
    and (a.emp_no, b.salary) =any (select emp_no, salary
									from salaries
									where to_date = '9999-01-01'
									and salary > 50000)
	order by b.salary asc;    

-- 실습문제 4: 현재, 각 부서별로 최고 급여를 받고 있는 직원의 이름과 월급을 출력하세요.
-- 총무 둘리 4000
-- 영업 또치 5000

select a.dept_no, max(b.salary)
	from dept_emp a, salaries b
    where a.emp_no = b.emp_no
    and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
	group by a.dept_no;
    
-- sol 1 : where 절 subquery (in)
select a.dept_name, c.first_name, d.salary
	from departments a, dept_emp b, employees c, salaries d
    where a.dept_no = b.dept_no and b.emp_no = c.emp_no and c.emp_no = d.emp_no
    and b.to_date = '9999-01-01' and b.to_date = '9999-01-01'
    and (a.dept_no, d.salary) in (  select a.dept_no, max(b.salary)
										from dept_emp a, salaries b
										where a.emp_no = b.emp_no
										and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
										group by a.dept_no);

-- sol 2 : from 절 subquery & join
select a.dept_name, c.first_name, d.salary
	from departments a, dept_emp b, employees c, salaries d,
		(select a.dept_no, max(b.salary) as max_salary
			from dept_emp a, salaries b
			where a.emp_no = b.emp_no
			and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
			group by a.dept_no) e
    where a.dept_no = b.dept_no and b.emp_no = c.emp_no and c.emp_no = d.emp_no
		  and a.dept_no = e.dept_no
    and b.to_date = '9999-01-01' and b.to_date = '9999-01-01'
    and d.salary = e.max_salary;



    
-- insert into post values ((select max(group_no) from post), from dual);
