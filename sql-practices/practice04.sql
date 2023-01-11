-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 문제1. 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
-- 현재 평균 구하기
-- 직원 구하기
select count(*)
	from employees a, salaries b
	where a.emp_no = b.emp_no and b.to_date = '9999-01-01'
    and b.salary > (select avg(salary)
						from salaries
						where to_date='9999-01-01')
	order by b.salary desc;   

-- 문제3. 현재, 자신의 부서 평균 급여보다 급여가 많은 사원의 사번, 이름과 연봉을 조회하세요 
                        
select e.emp_no, e.first_name, s.salary
	from employees e join dept_emp d on e.emp_no = d.emp_no
					 join salaries s on d.emp_no = s.emp_no
                     join ( select de.dept_no, avg(salary) as avgsal
								from dept_emp de, salaries s
                                where de.emp_no = s.emp_no
                                and a.to_date = '9999-01-01' and s.to_date = '9999-01-01'
                                group by de.dept_no) a on d.dept_no = a.dept_no and s.salary > a.avgsal
	where d.to_date = '9999-01-01' and s.to_date = '9999-01-01';
                     

-- 문제4. 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.

select e.emp_no, e.first_name as name, a.manager_name as manager_name, a.dept_name 
	from employees e join dept_emp d on e.emp_no = d.emp_no 
					 join (select d.dept_name, d.dept_no, e.first_name as manager_name
								from departments d join dept_manager dm on d.dept_no = dm.dept_no
												   join employees e on dm.emp_no = e.emp_no
								where dm.to_date = '9999-01-01') a on d.dept_no = a.dept_no
	where d.to_date = '9999-01-01';



-- 문제5. 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
-- 평균 연봉이 가장 높은 부서 먼저 찾기

select e.emp_no, e.first_name, t.title, s.salary
	from employees e join dept_emp de on e.emp_no = de.emp_no and de.to_date = '9999-01-01'
					 join titles t on e.emp_no = t.emp_no and t.to_date = '9999-01-01'
                     join salaries s on e.emp_no = s.emp_no and s.to_date = '9999-01-01'
   where de.dept_no = (select dept_no
						from (
							select dept_no, avg(salary) as avgsal
							from salaries a, dept_emp b
                            where a.emp_no = b.emp_no and a.to_date = '9999-01-01' and b.to_date = '9999-01-01' 
                            group by dept_no
                            order by avgsal desc
                            limit 0, 1) a);
   

-- 문제6. 평균 급여가 가장 높은 부서는? 
-- 부서 이름, 평균 급여
select d.dept_name, avg(c.salary) as avg_salary
	from employees a, dept_emp b, salaries c, departments d
	where a.emp_no = b.emp_no and a.emp_no = c.emp_no and b.dept_no = d.dept_no
	and b.to_date = '9999-01-01' and c.to_date = '9999-01-01'
    group by d.dept_name
	order by avg_salary desc
    limit 0, 1;


-- 문제7. 평균 연봉이 가장 높은 직책?
-- 직책, 평균 급여
select a.title, avg(b.salary) as avg_salary
	from titles a, salaries b
    where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
	group by a.title
    order by avg_salary desc
    limit 0,1;
    
    
-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.

select b.dept_name, b.name, s.salary, b.manager_name, b.manager_salary
	from employees e join dept_emp de on e.emp_no=de.emp_no and de.to_date = '9999-01-01'
					 join salaries s on e.emp_no = s.emp_no and s.to_date = '9999-01-01'
                     join ( select a.dept_no , c.first_name as manager_name, b.dept_name  , d.salary as managersal
								from dept_manager a join departments b on a.dept_no = b.dept_no and a.to_date= '9999-01-01'
													join employees c on a.emp_no = c.emp_no
													join salaries d on c.emp_no = d.emp_no and d.to_date = '9999-01-01'
							) c on b.dept_no = c.dept_no and d.salary > c.managersal;