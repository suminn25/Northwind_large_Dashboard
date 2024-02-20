# 21년도 현 매출액
# 21년도 월별 주문 건 수

SELECT SUM(OD.UnitPrice * OD.Quantity)
FROM OrderDetail OD;

# 연도별 총 주문금액
SELECT SUM(OD.UnitPrice*OD.Quantity), Date_format(O.OrderDate, '%Y')
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
WHERE 
    (Date_format(O.OrderDate, '%Y') >= '2018' and
    Date_format(O.OrderDate, '%Y') < '2021' and
    C.Region = 'Western Europe')
GROUP BY Date_format(O.OrderDate, '%Y');

# 연도별 구매건수
SELECT COUNT(distinct O.Id), Date_format(O.OrderDate, '%Y')
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
WHERE 
    (Date_format(O.OrderDate, '%Y') >= '2018' and
    Date_format(O.OrderDate, '%Y') < '2021' and
    C.Region = 'Western Europe')
GROUP BY Date_format(O.OrderDate, '%Y');


# 연도별 인기카테고리
SELECT CG.CategoryName, COUNT(distinct O.Id), Date_format(O.OrderDate, '%Y')
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
INNER JOIN OrderDetail OD ON OD.OrderId = O.Id
INNER JOIN Product P ON P.UnitPrice = OD.UnitPrice
INNER JOIN Category CG ON CG.Id = P.CategoryId
WHERE 
    (Date_format(O.OrderDate, '%Y') >= '2019' and
    Date_format(O.OrderDate, '%Y') < '2021' and
    C.Region = 'Western Europe')
GROUP BY CG.CategoryName, Date_format(O.OrderDate, '%Y');

# 21년도 구매 건 수 추이
SELECT date_format(O.OrderDate, '%Y-%m'), COUNT(distinct O.Id)
FROM Orders O
INNER JOIN Customer C ON C.Id = O.CustomerId
WHERE date_format(O.OrderDate, '%Y-%m') >= '2021-01' and
    date_format(O.OrderDate, '%Y-%m') < '2021-09' and
    C.Region = 'Western Europe'
GROUP BY date_format(O.OrderDate, '%Y-%m');

# 19년 대비 20년 구매 건수
SELECT C.Id, COUNT(distinct O.Id), Date_format(O.OrderDate, '%Y')
FROM Customer C
INNER JOIN Orders O ON O.CustomerId = C.Id
WHERE 
    (Date_format(O.OrderDate, '%Y') >= '2019' and
    Date_format(O.OrderDate, '%Y') < '2020' and
    C.Region = 'Western Europe') OR
    (Date_format(O.OrderDate, '%Y') >= '2020' and
    Date_format(O.OrderDate, '%Y') < '2021' and
    C.Region = 'Western Europe')
GROUP BY C.Id, Date_format(O.OrderDate, '%Y');

#19년도 월별 총 매출액
SELECT date_format(O.OrderDate, '%Y-%m'), SUM(OD.UnitPrice * OD.Quantity)
FROM OrderDetail OD
INNER JOIN Orders O ON O.Id = OD.OrderId
INNER JOIN Customer C ON C.Id = O.CustomerId
WHERE date_format(O.OrderDate, '%Y-%m') >= '2019-01-01' and
    date_format(O.OrderDate, '%Y-%m') < '2020-01-01' and
    C.Region = 'Western Europe'
GROUP BY C.Region, date_format(O.OrderDate, '%Y-%m');
# 제일 잘팔린 상품

#20년도 월별 총 매출액
SELECT date_format(O.OrderDate, '%Y-%m'), SUM(OD.UnitPrice * OD.Quantity)
FROM OrderDetail OD
INNER JOIN Orders O ON O.Id = OD.OrderId
INNER JOIN Customer C ON C.Id = O.CustomerId
WHERE date_format(O.OrderDate, '%Y-%m') >= '2020-01-01' and
    date_format(O.OrderDate, '%Y-%m') < '2021-01-01' and
    C.Region = 'Western Europe'
GROUP BY C.Region, date_format(O.OrderDate, '%Y-%m');

# 카테고리별 평균 가격
SELECT C.CategoryName, C.Description, AVG(P.UnitPrice)
FROM Category C
INNER JOIN Product P ON P.CategoryId = C.Id
GROUP BY C.CategoryName, C.Description
ORDER BY AVG(P.UnitPrice) desc;
