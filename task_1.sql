#1. Country 별로 ContactName이 ‘A’로 시작하는 Customer의 숫자를 세는 쿼리를 작성하세요.
select Country, count(1) cnt
from Customers
where ContactName like 'A%'
group by Country;

#2. Customer 별로 Order한 Product의 총 Quantity를 세는 쿼리를 작성하세요.
select a.CustomerID, sum(b.Quantity)
from Orders a 
left join OrderDetails b on a.OrderId = b.OrderId
group by a.CustomerID;

#3. 년월별, Employee별로 Product를 몇 개씩 판매했는지를 표시하는 쿼리를 작성하세요.
select substr(a.OrderDate,1,7) ym, a.EmployeeID, sum(b.Quantity) sumOfQuantity
from Orders a
	left join OrderDetails b on a.OrderID = b.OrderID
group by substr(a.OrderDate,1,7), a.EmployeeID;

#