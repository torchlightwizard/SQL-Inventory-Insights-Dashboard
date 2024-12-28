create view locations as
select 
    i.productid as id,
    l.name as name,
    i.quantity
from production.productinventory as i
left join production.location as l
    on i.locationid = l.locationid;