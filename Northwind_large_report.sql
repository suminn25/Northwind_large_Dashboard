SELECT quarter(O.OrderDate), C.CategoryName, COUNT(distinct O.Id)
FROM Orders O
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
INNER JOIN Product P ON P.Id = OD.ProductId
INNER JOIN Category C ON C.Id = P.CategoryId
GROUP BY quarter(O.OrderDate), C.CategoryName;

SELECT quarter(O.OrderDate), SUM(OD.UnitPrice * OD.Quantity)
FROM Orders O
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY quarter(O.OrderDate);

# 분기별 총 주문금액이 가장 높은 지역
SELECT quarter(O.OrderDate), C.Region, SUM(OD.UnitPrice * OD.Quantity)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY quarter(O.OrderDate), C.Region
ORDER BY quarter(O.OrderDate), SUM(OD.UnitPrice * OD.Quantity) desc;

SELECT date_format(O.OrderDate, '%Y'), SUM(OD.UnitPrice * OD.Quantity)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY date_format(OrderDate, '%Y')
ORDER BY date_format(OrderDate, '%Y'), SUM(OD.UnitPrice * OD.Quantity) desc;

#1. 총 주문 금액이 높은 지역이 있을 것이다
SELECT C.Region, SUM(OD.UnitPrice * OD.Quantity)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY C.Region
ORDER BY SUM(OD.UnitPrice * OD.Quantity) desc;

#2. 총 주문 금액이 높은 지역에 주문 건수가 많을 것이다.
SELECT C.Region,SUM(OD.UnitPrice * OD.Quantity), COUNT(distinct O.Id)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY C.Region;

#2-1. 주문 건수가 많은 지역에 고객이 많이 거주할 것이다.
SELECT C.Region, COUNT(distinct C.Id), COUNT(distinct O.Id)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
GROUP BY C.Region;

SELECT date_format(O.OrderDate, '%Y%m'), COUNT(distinct O.Id)
FROM Orders O
WHERE date_format(O.OrderDate, '%Y%m') >= '202001' and
        date_format(O.OrderDate, '%Y%m') < '202007'
GROUP BY date_format(O.OrderDate, '%Y%m');

# 2021년 상반기주문 건수
SELECT date_format(O.OrderDate, '%Y%m'), COUNT(distinct O.Id)
FROM Orders O
WHERE date_format(O.OrderDate, '%Y%m') >= '202101' and
        date_format(O.OrderDate, '%Y%m') < '202107'
GROUP BY date_format(O.OrderDate, '%Y%m');

SELECT date_format(O.OrderDate, '%m'), SUM(OD.UnitPrice * OD.Quantity)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
WHERE (date_format(OrderDate, '%m') >= '202001' and date_format(OrderDate, '%m') < '202007') OR
        (date_format(OrderDate, '%m') >= '202101' and date_format(OrderDate, '%m') < '202107')
GROUP BY date_format(OrderDate, '%m')
ORDER BY date_format(OrderDate, '%m'), SUM(OD.UnitPrice * OD.Quantity) desc;

SELECT date_format(O.OrderDate, '%m'), SUM(OD.UnitPrice * OD.Quantity)/COUNT(distinct O.Id)
FROM Orders O
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY date_format(O.OrderDate, '%m');

SELECT date_format(O.OrderDate, '%m'), COUNT(distinct O.Id)
FROM Orders O
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
WHERE date_format(O.OrderDate, '%m') < '07'
GROUP BY date_format(O.OrderDate, '%m');

# 2019년 상반기주문 건수
SELECT date_format(O.OrderDate, '%Y%m'), COUNT(distinct O.Id)
FROM Orders O
GROUP BY date_format(O.OrderDate, '%Y%m');

SELECT date_format(O.OrderDate, '%m'), SUM(OD.UnitPrice * OD.Quantity)
FROM Orders O
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY date_format(OrderDate, '%m')
ORDER BY date_format(OrderDate, '%m'), SUM(OD.UnitPrice * OD.Quantity) desc;

SELECT date_format(O.OrderDate, '%m'), AVG(OD.UnitPrice)
FROM Orders O
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY date_format(O.OrderDate, '%m');

SELECT date_format(O.OrderDate, '%m'), COUNT(distinct O.Id), AVG(OD.UnitPrice)
FROM Orders O
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY date_format(O.OrderDate, '%m');

SELECT date_format(O.OrderDate, '%m'), SUM(OD.UnitPrice * OD.Quantity), AVG(OD.UnitPrice)
FROM Orders O
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY date_format(OrderDate, '%m')
ORDER BY date_format(OrderDate, '%m'), SUM(OD.UnitPrice * OD.Quantity) desc;

SELECT C.Region, CG.CategoryName, COUNT(distinct OD.OrderId)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
INNER JOIN Product P ON P.Id = OD.ProductId
INNER JOIN Category CG ON CG.Id = P.CategoryId
WHERE C.Region = 'Western Europe'
GROUP BY C.Region, CG.CategoryName;

SELECT C.CategoryName, AVG(OD.UnitPrice)
FROM OrderDetail OD
INNER JOIN Product P ON P.Id = OD.ProductId
INNER JOIN Category C ON C.Id = P.CategoryId
GROUP BY C.CategoryName;

SELECT AVG(OD.UnitPrice), COUNT(distinct OD.OrderId)
FROM OrderDetail OD;

SELECT date_format(O.OrderDate, '%m'), COUNT(distinct O.Id), AVG(OD.UnitPrice)
FROM Orders O
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY date_format(O.OrderDate, '%m');

SELECT AVG(OD.UnitPrice), COUNT(distinct OD.OrderId)
FROM OrderDetail OD;
