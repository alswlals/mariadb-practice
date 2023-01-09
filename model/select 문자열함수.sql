-- 문자열 함수

-- upper
select upper('busan'), ucase('BusaN'), upper('BUsan') from dual;
select upper(first_name) from employees order by upper(first_name); 

-- lower
select lower('BUSAN'), lcase('BusaN'), lower('BUsan') from dual;
select lower(first_name) from employees; 

-- substring(문자열, index, length)
select substring('Hello world', 3, 2);

-- 예제) 1989년에 입사한 사원드르이 이름, 입사일을 출력하라
select first_name, hire_date
	from employees
    where substring(hire_date, 1, 4) = '1989';
    
-- lpad(오른쪽 정렬), rpad(오른쪽 정렬)  left padding right padding
select lpad('1234', 10, '-' ), rpad('1234', '10', '-');

-- 예제) 직원들의 월급을 오른쪽 정렬(빈공간 *)
select lpad(salary,10, '*') from salaries;

-- trim, ltrim, rtrim
select concat('---', ltrim('                     hello               '), '---'),
	   concat('---', trim(both 'x' from 'xxxxxhelloxxxxx'), '---'),
	   concat('---', rtrim('                     hello               '), '---'),
       concat('---', trim(leading 'x' from 'xxxxxhelloxxxxx'), '---'),
       concat('---', trim(trailing 'x' from 'xxxxxhelloxxxxx'), '---')
       from dual;

-- length
select length('Hello World') from dual;
select length('Hello World') from dual;