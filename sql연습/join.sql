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