select custid, firstname||lastname as fullname, city from customer;
select * from customer order by lastname;
select * from schedule order by serviceid DESC, custid DESC;
select serviceid from deliveryservice minus select serviceid from schedule;
select firstname from customer, schedule where day = 'm' and schedule.custid = customer.custid;
select distinct lastname from schedule, customer where schedule.custid = customer.custid;
select MAX(servicefee) highest_Servicefee from deliveryservice;
select day, count(*) numberOfShipments from schedule group by day;
Select A.custid,B.custid,A.city from Customer A, Customer B where A.city=B.city And A.custid <> B.custid;
select distinct firstname from deliveryservice d, customer c, schedule s where d.location = c.city and c.custid = s.custid;
select MAX(salary) maxSalary, MIN(salary) minSalary from staff;

