create view total_stock_sum as 
select 
    sum(quantity) as qty
from production.productinventory;



create view total_stock_per_location as
select 
    p.name as product,
    l.name as location, 
    i.quantity as qty
from production.productinventory as i
left join production.product as p
    on i.productid = p.productid
left join production.location as l
    on l.locationid = i.locationid;
