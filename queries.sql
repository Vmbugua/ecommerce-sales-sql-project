USE nova_trade;

/* Products that generate the highest revenue */
SELECT
	order_items.product_id,
    sum(order_items.quantity * order_items.price) AS total_amount
FROM 
	nova_trade.order_items
JOIN
	products ON order_items.product_id = products.product_id
GROUP BY
	order_items.product_id
ORDER BY 
	total_amount DESC;
    
-----------------

/*total amount each customer has spent*/

SELECT
	customers.customer_id,
    customers.first_name,
    sum(payments.amount) AS total_amount
FROM
	payments
JOIN
	orders ON payments.order_id = orders.order_id
JOIN
    customers ON orders.customer_id = customers.customer_id
GROUP BY
	customers.customer_id;

-------------------

/*varying of sales month to month*/

SELECT
    date_format(payment_date, '%Y - %m') AS dates,
    sum(payments.amount) AS total_amount
FROM
	payments
GROUP BY 
	dates;
    
--------------------

/* number of repeat customers */

SELECT 
    customer_id,
    COUNT(order_id) AS orders_made
FROM
    orders
GROUP BY
    customer_id
HAVING
    COUNT(order_id) > 1;
    
-----------------------

/* average order value per month */

SELECT
	date_format(payment_date, '%Y - %m') AS dates,
    (SUM(amount))/count(distinct order_id) AS average
FROM
	payments
GROUP BY
	dates;
    
----------------

/* most used payment methods */

SELECT 
	payment_method,
    count(payment_method) AS tally
FROM
	payments
GROUP BY
	payment_method;
    
-----------------

/* the average rating per products */

select
	product_id,
    avg(rating) AS average_ratings
from
	reviews
group by
	product_id
order by
	average_ratings DESC;
    
-----------------

/* average shipping time */

select
	avg(datediff(delivery_date,ship_date)) AS delivery_time
from
	shipping;
    
----------------