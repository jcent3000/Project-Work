-- exer 7
select deptid as deptno, count(*) as empcount from l_emp group by deptid;

-- exer 8
select deptno,deptname,empcount from (select deptid as deptno, count(*) as empcount from l_emp group by deptid), l_dept where deptno = l_dept.deptid;

select deptno,deptname,empcount from (select deptid as deptno, count(*) as empcount from l_emp group by deptid), l_dept where deptno = l_dept.deptid order by empcount;

-- exer 9
select deptid from l_emp group by deptid having count(*) = (select max(count(*)) from l_emp group by deptid);

select deptname from (select deptid from l_emp group by deptid having count(*) = (select max(count(*)) from l_emp group by deptid)) a, l_dept where a.deptid = l_dept.deptid;

-- exer 10
select * from l_emp natural join l_dept;

select * from l_emp, l_dept where l_emp.deptid = l_dept.deptid;
