SELECT quarter(O.OrderDate), C.CategoryName, COUNT(distinct O.Id)
FROM Orders O
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
INNER JOIN Product P ON P.Id = OD.ProductId
INNER JOIN Category C ON C.Id = P.CategoryId
GROUP BY quarter(O.OrderDate), C.CategoryName;

# 총 주문금액이 가장 높은 분기는 언제일까?
SELECT quarter(O.OrderDate), SUM(OD.UnitPrice * OD.Quantity)
FROM Orders O
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY quarter(O.OrderDate);

# 2분기에 총 주문금액이 가장 높은 지역은?
SELECT C.Region, SUM(OD.UnitPrice * OD.Quantity)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
WHERE O.OrderDate >= '2018-04-01' and
        O.OrderDate < '2018-07-01'
GROUP BY C.Region;

# 분기별 총 주문금액이 가장 높은 지역
SELECT date_format(O.OrderDate, '%Y-%m'), C.Region, SUM(OD.UnitPrice * OD.Quantity)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY date_format(OrderDate, '%Y-%m'), C.Region
ORDER BY date_format(OrderDate, '%Y-%m'), SUM(OD.UnitPrice * OD.Quantity) desc;

# 워싱턴 주에 고객이 가장 많이 살 것이다.
SELECT C.Region, COUNT(distinct C.Id)
FROM Customer C
GROUP BY C.Region;


# 워싱턴 주에서 카테고리별 주문 건 수
SELECT CG.CategoryName, COUNT(distinct OD.OrderId)
FROM Category CG
INNER JOIN Product P ON P.CategoryId = CG.Id
INNER JOIN OrderDetail OD ON OD.UnitPrice = P.UnitPrice
INNER JOIN Orders O ON O.Id = OD.OrderId
INNER JOIN Customer C ON C.Id = O.CustomerId
WHERE C.Region = 'Western Europe'
GROUP BY CG.CategoryName
ORDER BY COUNT(distinct OD.OrderId) desc;

# 워싱턴 주에 상품가격이 저렴한 상품이 가장 많이 팔렸을 것이다.
SELECT P.UnitPrice, COUNT(distinct O.Id)
FROM Product P
INNER JOIN OrderDetail OD ON OD.ProductId = P.Id
INNER JOIN Orders O ON O.Id = OD.OrderID;

#(상품가격이 저렴할수록 주문 건수가 높을 것이다.)
SELECT P.UnitPrice, COUNT(distinct O.Id)
FROM Product P
INNER JOIN OrderDetail OD ON OD.ProductId = P.Id
INNER JOIN Orders O ON O.Id = OD.OrderID
GROUP BY P.UnitPrice
ORDER BY P.UnitPrice;

# 워싱턴 주 지역별 총 주문금액
SELECT C.Region, SUM(OD.UnitPrice * OD.Quantity)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
WHERE C.Region = 'Western Europe'
GROUP BY C.Region
ORDER BY SUM(OD.UnitPrice * OD.Quantity) desc;

#연도별 총 주문금액
SELECT date_format(O.OrderDate, '%Y'), SUM(OD.UnitPrice * OD.Quantity)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY date_format(OrderDate, '%Y')
ORDER BY date_format(OrderDate, '%Y'), SUM(OD.UnitPrice * OD.Quantity) desc;

# 워싱턴 주 연도별 총 주문금액이 높을수록 주문 건수가 많을 것이다.
SELECT date_format(O.OrderDate, '%Y'), SUM(OD.UnitPrice * OD.Quantity)/COUNT(distinct O.Id)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
WHERE C.Region = 'Western Europe'
GROUP BY date_format(OrderDate, '%Y')
ORDER BY date_format(OrderDate, '%Y');

# 연도별 총 주문금액
SELECT date_format(O.OrderDate, '%Y'), SUM(OD.UnitPrice * OD.Quantity)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY date_format(OrderDate, '%Y')
ORDER BY date_format(OrderDate, '%Y'), SUM(OD.UnitPrice * OD.Quantity) desc;

# 2회 이상 주문한 고객이 많을수록 주문건 수가 높을 것이다.
SELECT COUNT(distinct O.Id), SUM(OD.UnitPrice * OD.Quantity)
FROM Orders O
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
WHERE COUNT(distinct O.id) > 2
GROUP BY COUNT(distinct O.Id);

# 워싱턴 주에 고객이 가장 많이 살 것이다.
SELECT C.Region, COUNT(distinct C.Id)
FROM Customer C
GROUP BY C.Region;

# 고객이 많이 사는 지역에 주문 건수가 높을 것이다.
SELECT C.Region, COUNT(distinct C.Id), COUNT(distinct O.Id)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
GROUP BY C.Region;

# 주문 건수가 높은 지역에 총 주문금액이 높을 것이다.
SELECT C.Region, SUM(OD.UnitPrice * OD.Quantity), COUNT(distinct O.Id)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY C.Region;

# 연도별 총 주문 금액
SELECT date_format(O.OrderDate, '%Y'), SUM(OD.UnitPrice * OD.Quantity)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY date_format(OrderDate, '%Y')
ORDER BY date_format(OrderDate, '%Y'), SUM(OD.UnitPrice * OD.Quantity) desc;

# 2020년보다 2021년에 주문 건수가 적을 것이다.
SELECT date_format(O.OrderDate, '%Y'), COUNT(distinct O.Id)
FROM Orders O
WHERE date_format(O.OrderDate, '%Y') >= '202001' and
        date_format(O.OrderDate, '%Y') < '202007' and
        date_format(O.OrderDate, '%Y') >= '202101' and
        date_format(O.OrderDate, '%Y') < '202107'
GROUP BY date_format(O.OrderDate, '%Y');

# 2020년 상반기 주문 건수
SELECT date_format(O.OrderDate, '%Y%m'), COUNT(distinct O.Id)
FROM Orders O
WHERE date_format(O.OrderDate, '%Y%m') >= '2020-01' and
        date_format(O.OrderDate, '%Y%m') < '2020-07'
GROUP BY date_format(O.OrderDate, '%Y%m');

# 2020년 인기 카테고리
SELECT date_format(O.OrderDate, '%Y%m'), C.CategoryName, COUNT(distinct OD.OrderId)
FROM Orders O
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
INNER JOIN Product P ON P.Id = OD.ProductId
INNER JOIN Category C ON C.Id = P.CategoryId
WHERE date_format(O.OrderDate, '%Y%m') >= '202001' and
        date_format(O.OrderDate, '%Y%m') < '202101'
GROUP BY date_format(O.OrderDate, '%Y%m'), C.CategoryName;


# 2020년 상반기 주문 건수
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

# 2020년도 상반기 대비 2021년도 상반기 총 주문금액
# 2020년도 상반기 대비 2021년도 평균 주문 금액
SELECT date_format(O.OrderDate, '%Y%m'), SUM(OD.UnitPrice * OD.Quantity)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
WHERE (date_format(OrderDate, '%Y%m') >= '202001' and date_format(OrderDate, '%Y%m') < '202007') OR
        (date_format(OrderDate, '%Y%m') >= '202101' and date_format(OrderDate, '%Y%m') < '202107')
GROUP BY date_format(OrderDate, '%Y%m')
ORDER BY date_format(OrderDate, '%Y%m'), SUM(OD.UnitPrice * OD.Quantity) desc;

#1. 총 주문 금액이 높은 지역이 있을 것이다
SELECT C.Region, SUM(OD.UnitPrice * OD.Quantity)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY C.Region
ORDER BY SUM(OD.UnitPrice * OD.Quantity) desc;

#2. 총 주문 금액이 높은 지역에 주문 건수가 많을 것이다
SELECT C.Region, COUNT(distinct O.Id), SUM(OD.UnitPrice * OD.Quantity)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
GROUP BY C.Region;

# 모두 비율로 표현
#2-1. 주문 건수가 많은 지역에 고객이 많이 거주할 것이다.
SELECT C.Region, COUNT(distinct C.Id), COUNT(distinct O.Id)
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
GROUP BY C.Region;

#3. 
SELECT C.Region, CG.CategoryName, COUNT(distinct OD.OrderId)
FROM Category CG
INNER JOIN Product P ON P.CategoryId = CG.Id
INNER JOIN OrderDetail OD ON OD.UnitPrice = P.UnitPrice
INNER JOIN Orders O ON O.Id = OD.OrderId
INNER JOIN Customer C ON C.Id = O.CustomerId
GROUP BY C.Region, CG.CategoryName
ORDER BY COUNT(distinct OD.OrderId) desc;

