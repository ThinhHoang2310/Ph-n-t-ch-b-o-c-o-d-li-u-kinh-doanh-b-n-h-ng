select * from newPizza
--1.tong doanh thu
select SUM(total_price) as total_sold_sum from newPizza as tongdoanhthu
--2.tong don hang
select COUNT(distinct order_num) as total_order from newPizza
--3.gia trung binh cho moi don hang
select SUM(total_price)/COUNT( distinct order_num) as avg_order from newPizza
--4.trung binh so luong qua moi don hang
SELECT CAST(SUM(quantity) / COUNT(DISTINCT order_num) AS DECIMAL(10,2)) as avg_pizza_per_ord
FROM newPizza
--5.tong so don hang dat trong moi ngay trong tuan
select DATEname(dw,order_date) as order_date, COUNT(distinct order_num) as total_orders
from newPizza
group by DATEname(dw,order_date)
--6.don hang duoc dat nhieu nhat trong moi thang
select DATENAME(MONTH, order_date) as Month_name,COUNT(distinct order_num) as total_ord_month
from newPizza
group by DATENAME(MONTH, order_date)
--don hang dat nhieu nhat trong thang
WITH day_in_week AS (
    SELECT DATENAME(MONTH, order_date) as Month_name, COUNT(distinct order_num) as total_ord_in_week
    FROM newPizza
    GROUP BY DATENAME(MONTH, order_date)
)
SELECT MAX(total_ord_in_week) as max_in_week FROM day_in_week;
----------
--7.phan tram so pizza ban ra theo category
SELECT pizza_category, sum(total_price) as total_sales, (SUM(total_price) * 100 / (SELECT SUM(total_price) FROM newPizza)) as pizza_per_category
FROM newPizza
GROUP BY pizza_category
--8.phan tram size pizza trong don hang
SELECT pizza_size, cast(sum(total_price) as decimal(10,2))  as total_sales, 
cast((SUM(total_price) * 100 / (SELECT SUM(total_price) FROM newPizza)) as decimal(10,2)) as pizza_per_category
FROM newPizza
GROUP BY pizza_size
--9.ten pizza ban duoc doanh thu thap nhat
select top 5 pizza_name,SUM(total_price) as total_revenue from newPizza
group by pizza_name
order by total_revenue asc
--ten pizza ban duoc doanh thu cao nhat
select top 5 pizza_name,SUM(total_price) as total_revenue from newPizza
group by pizza_name
order by total_revenue desc
--so luong pizza ban dc nhieu nhat
select top 5 pizza_name,SUM(quantity) as total_quantity from newPizza
group by pizza_name
order by total_quantity desc

select order_num,pizza_name from newPizza
where order_num=(select max(order_num) from newPizza)

--10.loai thuc an duoc dung nhieu trong banh
select pizza_dish as dish,COUNT(distinct order_num) as total_ord_dish
from newPizza
group by pizza_dish
----
WITH dish AS (
    SELECT pizza_dish, COUNT(distinct order_num) as total_dish
    FROM newPizza
    GROUP BY pizza_dish
)
SELECT MAX(total_dish) as max_in_dish FROM dish;




SELECT @@SERVERNAME