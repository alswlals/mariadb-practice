SELECT CONCAT(employees.last_name, ' ', employees.first_name) as name, 
		employees.emp_no,
        titles.emp_no, titles.title
	FROM employees, titles
    WHERE employees.emp_no = titles.emp_no;
    
-- inner join

-- 예제 1 : 현재(to_date : '9999-99-99'), 근무하고 있는 직원의 이름과 직책을 모두 출력하세요.
select a.first_name, b.title
	from employees a, titles b
    where a.emp_no = b.emp_no         -- join  조건(n-1)
    and b.to_date = '9999-01-01';	  -- row 선택 조건
    
-- 예제 2 : 현재, 근무하고 있는 직원의 이름과 직책을 출력하되 여성 엔지니어(Engineer)만 출력하세요.
select a.first_name, a.gender, b.title
	from employees a, titles b
    where a.emp_no = b.emp_no         -- join  조건(n-1)
    and b.to_date = '9999-01-01'	  -- row 선택 조건 1
    and a.gender = 'f'				  -- row 선택 조건 2
    and b.title = 'Engineer';		  -- row 선택 조건 3
    
    
-- 
-- ANSI/ISO SQL1999 JOIN 표준 문법
-- 

/* 1) Natural Join         
 *	  조인 대상이 되는 두 테이블에 이름이 같은 공통 컬럼이 있으면 조인 조건을 
 *	  명시하지 않고 암묵적으로 조인이 된다.
 *	  + join  조건이 없어도 join이 걸림 */
select a.first_name, b.title
	from employees a natural join titles b
    where b.to_date = '9999-01-01';
    
/* 2) Join ~ Using
 *    natural join의 문제점 */
 -- 직책별 평균 연봉을 구하라
select count(*)
	from salaries a natural join titles b
    where a.to_date = '9999-01-01'
    and b.to_date = '9999-01-01';
    
select count(*)
	from salaries a join titles b using(emp_no) -- 조인 컬럼 지정
    where a.to_date = '9999-01-01'
    and b.to_date = '9999-01-01';

/* 3) Join ~ on *** */
select a.first_name, b.title
	from employees a join titles b on a.emp_no = b.emp_no
    where b.to_date = '9999-01-01';

-- 예제) 현재, 직책별 평균 연봉을 큰 순서대로 출력하세요.
select b.title, avg(a.salary)
	from salaries a join titles b on a.emp_no = b.emp_no
    where a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
    group by b.title 
    order by avg(a.salary) desc;


-- 실습 문제 1
-- 현재,  직원별 근무 부서를 사번, 직원 이름, 부서명으로 출력하세요.
select a.emp_no as '사번', a.first_name as '이름', b.title as '부서명'
	from employees a join titles b on a.emp_no = b.emp_no
	where b.to_date = '9999-01-01' ;
    
select a.emp_no, a.first_name, b.dept_name
	from employees a, departments b, dept_emp c
	where a.emp_no = c.emp_no and b.dept_no = c.dept_no and c.to_date = '9999-01-01';

-- 실습 문제 2
-- 현재, 지급되고 있는 급여를 출력하세요.
-- 사번, 이름, 급여 순으로 출력하세요.
select a.emp_no as '사번', a.first_name as '이름', b.salary as '급여'
	from employees a join salaries b on a.emp_no = b.emp_no
	where b.to_date = '9999-01-01' ;

select a.emp_no, a.first_name, b.salary
	from employees a, salaries b
    where a.emp_no = b.emp_no and b.to_date = '9999-01-01';

-- 실습 문제 3
-- 현재, 직책별 평균연봉, 원수를 구하되 직책별 직원수가 100명 이상인 직책만 출력하세요.
-- 직책, 평균연봉, 직원수 순으로 출력하세요.
select b.title as '직책', avg(a.salary) as '급여', count(a.emp_no) as '직원수'
	from salaries a join titles b on a.emp_no = b.emp_no
    where a.to_date = '9999-01-01' and b.to_date = '9999-01-01' 
    group by b.title 
    having count(a.emp_no) >=100;
    
select a.title, avg(b.salary), count(*)
	from titles a, salaries b
    where a.emp_no = b.emp_no and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
    group by a.title
    having count(*) >= 100; 
    
    
-- 실습 문제 4
-- 현재, 부서별로 직책이 Engineer인 직원들에 대해서만 평균 급여를 구하세요.
-- 부서명, 평균 급여 순으로 출력하세요.

select dept_emp, avg(a.salary) 
	from salaries a join titles b on a.emp_no = b.emp_no
    where a.to_date = '9999-01-01' and b.to_date = '9999-01-01' and b.title = 'Engineer'
    group by dept_name;
 

select a.dept_name, avg(d.salary), c.title
	from departments a, dept_emp b, titles c, salaries d
    where a.dept_no = b.dept_no and b.emp_no = c.emp_no and c.emp_no = d.emp_no and c.title = 'engineer'
		  and b.to_date = '9999-01-01' and c.to_date = '9999-01-01' and d.to_date = '9999-01-01'
	group by a.dept_name;
    -- order by avg(d.salary) desc;