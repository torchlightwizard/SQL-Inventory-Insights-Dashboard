create view total_stock_sum as 
select sum(quantity)
from production.productinventory;



create view total_stock as
select productid, quantity
from production.productinventory;