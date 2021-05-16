select * from L_EMP;
select * from L_DEPT;

/* Finds employee's who work in testing*/
select empname from L_EMP,L_DEPT where L_EMP.deptid = L_DEPT.deptid and deptname = 'Testing';

