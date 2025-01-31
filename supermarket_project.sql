Use Supermarket;

CREATE VIEW rate_of_sales AS 
select city, count(invoice_id), sum(total) as total_spend, round(100000*sum(total)/city.population,2) as rate_of_sales_per100k
from supermarket
inner join city
using (city)
group by city
order by sum(total) desc;


CREATE VIEW payment_type AS 
SELECT 
    payment, 
    SUM(total) AS total_spend,
    (SUM(total) / (SELECT SUM(total) FROM supermarket) * 100) AS percentage_of_total
FROM 
    supermarket
GROUP BY 
    payment;

CREATE VIEW payment_type_city AS 
SELECT 
    city,
    payment, 
    SUM(total) AS total_spend,
    (SUM(total) / (SELECT SUM(total) FROM supermarket WHERE city = s.city) * 100) AS percentage_of_total
FROM 
    supermarket s
GROUP BY 
    city,
    payment
order by city;

CREATE VIEW product_lines AS 
select product_line, customer_type, sum(total)
from supermarket 
group by customer_type, product_line
order by  sum(total) desc;

CREATE VIEW product_lines_gender AS 
select product_line, customer_type, gender, sum(total)
from supermarket 
group by gender, customer_type, product_line
order by  sum(total) desc;
