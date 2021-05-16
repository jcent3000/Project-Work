-- exer 1
select first||last salary from staff where salary >= all(select salary from staff);
select first||last from staff where salary = (select max(salary) from staff);

-- exer 2
select last, salary from staff where salary = (select salary from staff where lower(last) = 'zichal');
select last, salary from staff where salary = any(select salary from staff where lower(last) = 'young');

-- exer 3
select count(salary) as salary_above_100k from staff where salary>=100000;

-- exer 4
select salary, count(salary) as salaries_above_100k from staff group by salary having salary > 100000;

-- exer 5
select salary, count(salary) as salaries_above_100k from staff group by salary having salary > 100000 and count(*)>=10;

-- exer 6
select last from staff where regexp_like (last, '([aeriou])\1', 'i');
