create view totalstocksum as 
select sum(quantity)
from production.productinventory;

create view totalstock as
select productid, quantity
from production.productinventory;