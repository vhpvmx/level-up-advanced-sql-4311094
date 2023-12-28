select a.firstName, a.lastName, a.title, b.firstName as ManagerFirstName, b.lastName as ManagerLastName
from employee a
inner join employee b
on a.managerId = b.employeeId

go

select a.employeeId, a.firstName, a.lastName, b.*
from employee a, sales b
where a.employeeId = b.employeeId
order by a.employeeId

select a.employeeId, a.firstName, a.lastName, a.startDate, a.managerId, b.*
from employee a
LEFT JOIN sales b
ON a.employeeId = b.employeeId
WHERE salesId is NULL
and title = "Sales Person"
order by a.employeeId

select count(*)
from employee
where title = "Sales Person"

select a.employeeId, a.firstName, a.lastName, b.*
from employee a
LEFT JOIN sales b
ON a.employeeId = b.employeeId
where a.employeeId = 1

select DISTINCT employeeId from sales 

select a.*, b.*
from sales a
FULL OUTER JOIN customer b 
ON a.customerId = b.customerId

SELECT DISTINCT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
from sales sls
FULL OUTER JOIN customer cus
ON sls.customerId = cus.customerId

select a.employeeId, a.firstName, a.lastName, count(*) as sold_cars
from employee a
inner join sales b
on a.employeeId = b.employeeId
group by a.employeeId, a.firstName, a.lastName
order by sold_cars

select a.employeeId, a.firstName, a.lastName, min(salesAmount) as cheapest, max(salesAmount) expensive
from employee a
inner join sales b
on a.employeeId = b.employeeId
where soldDate >= date('now', 'start of year')
group by a.employeeId, a.firstName, a.lastName
order by expensive

WITH counter_id AS
(select employeeId, count(*) as n_sales
from sales
group by employeeId)

select a.employeeId, a.firstName, a.lastName, count(*) as sold_cars
from employee a
inner join sales b
on a.employeeId = b.employeeId
where a.employeeId in (select employeeId from counter_id where n_sales >= 5)
group by a.employeeId, a.firstName, a.lastName
order by sold_cars

select a.employeeId, a.firstName, a.lastName, min(salesAmount) as cheapest, max(salesAmount) expensive, count(*) as n_cars
from employee a
inner join sales b
on a.employeeId = b.employeeId
where soldDate >= date('now', 'start of year')
group by a.employeeId, a.firstName, a.lastName
having count(*) > 5
order by n_cars

WITH salesYear AS (
SELECT strftime('%Y', soldDate) as year, salesAmount
FROM sales
)

select year, sum(salesAmount)
from salesYear
GROUP BY year

SELECT strftime('%Y', soldDate) as yeara, sum(salesAmount)
FROM sales
GROUP BY yeara

select a.employeeId, a.firstName, a.lastName, strftime('%m', soldDate) as month, sum(salesAmount)
from employee a
INNER JOIN sales b
on a.employeeId = b.employeeId
and strftime('%Y', soldDate) = '2021'
GROUP by a.employeeId, a.firstName, a.lastName, month

select a.employeeId, a.firstName, a.lastName, 
  sum(case when strftime('%m', soldDate) = '01' then salesAmount end) as jan,
  sum(case when strftime('%m', soldDate) = '02' then salesAmount end) as feb,
  sum(case when strftime('%m', soldDate) = '03' then salesAmount end) as mar,
  sum(case when strftime('%m', soldDate) = '04' then salesAmount end) as apr,
  sum(case when strftime('%m', soldDate) = '05' then salesAmount end) as may,
  sum(case when strftime('%m', soldDate) = '06' then salesAmount end) as jun,
  sum(case when strftime('%m', soldDate) = '07' then salesAmount end) as jul,
  sum(case when strftime('%m', soldDate) = '08' then salesAmount end) as ago,
  sum(case when strftime('%m', soldDate) = '09' then salesAmount end) as sep,
  sum(case when strftime('%m', soldDate) = '10' then salesAmount end) as oct,
  sum(case when strftime('%m', soldDate) = '11' then salesAmount end) as nov,
  sum(case when strftime('%m', soldDate) = '12' then salesAmount end) as dec
from employee a
INNER JOIN sales b
on a.employeeId = b.employeeId
and strftime('%Y', soldDate) = '2021'
GROUP by a.employeeId, a.firstName, a.lastName