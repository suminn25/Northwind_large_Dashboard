#1. 상품(product)의 카테고리(category)별로, 상품 수와 평균 가격대(list_price)를 찾는 쿼리를 작성하세요.
select category, count(1) cnt, avg(list_price) avg_price
from products
group by category;

#2. 2006년 1분기에 고객(customer)별 주문(order) 횟수, 주문한 상품(product)의 카테고리(category) 수,
#총 주문 금액(quantity * unit_price)을 찾는 쿼리를 작성하세요.
select o.customer_id, 
    count(distinct o.id) order_cnt, 
    count(distinct p.category) category_cnt, 
    sum(od.quantity * od.unit_price) sum_of_order_price
from orders o
    left join order_details od on o.id = od.order_id
    left join products p on od.product_id = p.id
where '2006-01-01' <= o.order_date
    and o.order_date < '2006-04-01'
group by o.customer_id;

#3. 2006년 3월에 주문(order)된 건의 주문 상태(status_name)를 찾는 쿼리를 작성하세요.
select o.id, os.id, os.status_name
from orders o
    left join orders_status os on o.status_id = os.id
where '2006-03-01' <= o.order_date 
    and o.order_date < '2006-04-01';

select id, status_id, (select status_name from orders_status os where os.id = o.status_id) status_name
from orders o
where '2006-03-01' <= order_date 
    and order_date < '2006-04-01';

#4. 2006년 1분기 동안 세 번 이상 주문(order) 된 상품(product)과 그 상품의 주문 수를 찾는 쿼리를 작성하세요.
select *
from (
    select product_id, count(distinct o.id) cnt
    from orders o
        left join order_details od on o.id = od.order_id
    where '2006-01-01' <= order_date 
        and order_date < '2006-04-01'
    group by product_id
    ) a
where cnt >= 3;

select product_id, count(distinct o.id) cnt
from orders o
    left join order_details od on o.id = od.order_id
where '2006-01-01' <= order_date 
    and order_date < '2006-04-01'
group by product_id
having count(distinct o.id) >= 3;

#5-1. 2006년 1분기, 2분기 연속으로 하나 이상의 주문(order)을 받은 직원(employee)을 찾는 쿼리를 작성하세요.
select o1.employee_id
from 
    (select distinct employee_id
    from orders
    where '2006-01-01' <= order_date 
        and order_date < '2006-04-01') o1
        
    inner join
    
    (select distinct employee_id
    from orders
    where '2006-04-01' <= order_date 
        and order_date < '2006-07-01') o2
        
    on o1.employee_id = o2.employee_id;

#5-2. 2006년 1분기, 2분기 연속으로 하나 이상의 주문을 받은 직원별로, 월별 주문 수를 찾는 쿼리를 작성하세요. 
select employee_id, date_format(order_date, '%Y-%m') ym, count(1) cnt
from orders
where employee_id in (
    select o1.employee_id
        from 
            (select distinct employee_id
            from orders
            where '2006-01-01' <= order_date 
                and order_date < '2006-04-01') o1
            inner join
            (select distinct employee_id
            from orders
            where '2006-04-01' <= order_date 
                and order_date < '2006-07-01') o2
            on o1.employee_id = o2.employee_id
        )
group by 1, 2;









