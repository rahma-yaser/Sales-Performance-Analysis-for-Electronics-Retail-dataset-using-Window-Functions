CREATE TABLE electronics_sales (
    order_id        NUMBER PRIMARY KEY,
    order_date      DATE,
    region          VARCHAR2(50),
    category        VARCHAR2(50),
    product         VARCHAR2(100),
    quantity        NUMBER,
    unit_price      NUMBER,
    salesperson     VARCHAR2(50)
);
INSERT ALL
  INTO electronics_sales VALUES (1,  DATE '2024-01-15', 'North', 'Laptops', 'HP EliteBook',       5,  1200, 'Ali Youssef')
  INTO electronics_sales VALUES (2,  DATE '2024-01-20', 'South', 'Mobiles', 'iPhone 14',           10, 999,  'Sara Adel')
  INTO electronics_sales VALUES (3,  DATE '2024-02-01', 'North', 'Laptops', 'Dell XPS 13',         3,  1350, 'Ali Youssef')
  INTO electronics_sales VALUES (4,  DATE '2024-02-05', 'East',  'Tablets', 'iPad Air',            7,  650,  'Mohamed Nabil')
  INTO electronics_sales VALUES (5,  DATE '2024-02-20', 'North', 'Mobiles', 'Samsung Galaxy S23', 8,  870,  'Ali Youssef')
  INTO electronics_sales VALUES (6,  DATE '2024-03-05', 'West',  'Laptops', 'Lenovo ThinkPad',     4,  1100, 'Sara Adel')
  INTO electronics_sales VALUES (7,  DATE '2024-03-10', 'East',  'Mobiles', 'iPhone 14',           2,  999,  'Mohamed Nabil')
  INTO electronics_sales VALUES (8,  DATE '2024-04-01', 'West',  'Tablets', 'Samsung Tab S6',      5,  700,  'Sara Adel')
  INTO electronics_sales VALUES (9,  DATE '2024-04-15', 'South', 'Laptops', 'HP Pavilion',         6,  950,  'Ali Youssef')
  INTO electronics_sales VALUES (10, DATE '2024-04-20', 'North', 'Mobiles', 'Xiaomi Redmi Note',   15, 500,  'Mohamed Nabil'
)
SELECT * FROM dual;


-- Q1
with totals as (
  select
    region,
    salesperson,
    sum(quantity * unit_price) as total_sales
  from electronics_sales
  group by region, salesperson
),
ranked as (
  select
    region,
    salesperson,
    total_sales,
    dense_rank() over (partition by region order by total_sales desc) as sales_rank
  from totals
)
select
  region,
  salesperson,
  total_sales,
  sales_rank
from ranked
order by region, sales_rank;


-- Q2
select
    to_char(order_date, 'yyyy-mm') as months, sum(quantity * unit_price) as total_revenue
from electronics_sales
group by to_char(order_date, 'yyyy-mm')
order by months;


-- Q3
select
  category, avg(quantity * unit_price) as avg_sale_value
from electronics_sales
group by category;


-- Q4
select region, laptops_sales, mobiles_sales, tablets_sales
from (
  select region, category, quantity * unit_price as total_sales
  from electronics_sales
)
pivot (
  sum(total_sales) as sales
  for category in ('Laptops' as laptops, 'Mobiles' as mobiles, 'Tablets' as tablets)
)
order by region;


-- Q5
with sales as (
  select
    order_id, order_date, salesperson,
    (quantity * unit_price) as sale_amount,
    to_char(order_date, 'yyyy-mm') as months
  from electronics_sales
)
select
  order_id, order_date, salesperson, sale_amount,
  round(avg(sale_amount) over (partition by months), 2) as monthly_avg,
  round(sale_amount - avg(sale_amount) over (partition by months), 2) as deviation_from_avg
from sales;

-- Q6
with monthly_growth as (
  select
    to_char(order_date, 'yyyy-mm') as month,
    sum(quantity * unit_price) as total_sales
  from electronics_sales
  group by to_char(order_date, 'yyyy-mm')
)
select
  month, total_sales,
  lag(total_sales) over (order by month) as prev_month_sales,
  (total_sales - lag(total_sales) over (order by month)) as growth
from monthly_growth
order by month;


-- Q7
with sales as (
  select
    order_id, region, (quantity * unit_price) as sale_value
  from electronics_sales
)
select
  order_id, region, sale_value,
  round(avg(sale_value) over (partition by region), 2) as regional_avg,
  case
    when sale_value > avg(sale_value) over (partition by region)
         then 'above average'
    else 'normal'
  end as sale_flag
from sales
order by region, order_id desc;


-- Q8 
select region, product, total_sales_per_product, 
dense_rank() over (partition by region order by total_sales_per_product desc) as product_rank
from (select
    region, product, 
    sum(quantity * unit_price) as total_sales_per_product
  from electronics_sales
  group by region, product) 
order by region, total_sales_per_product desc;


-- Q9 
with sales as (
  select
    salesperson, order_date, product
  from electronics_sales
)
select distinct
  salesperson,
  first_value(order_date) over (partition by salesperson order by order_date) as first_sale_date,
  first_value(product)    over (partition by salesperson order by order_date) as first_product
from sales;