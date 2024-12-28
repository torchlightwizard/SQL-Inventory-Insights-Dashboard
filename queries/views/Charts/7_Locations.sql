create view locations as
select 
    p.name as product,
    l.name as location,
    i.quantity
from production.productinventory as i
left join production.product as p 
    on i.productid = p.productid
left join production.location as l
    on i.locationid = l.locationid;
