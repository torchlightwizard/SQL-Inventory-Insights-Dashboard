create view manufacture_orders as 
select 
    o.workorderid as orderid,
    p.name as product,
    (case when r.locationid is null then "Finished Goods Storage" else l.name end) as location,
    o.orderqty as qty,
    o.startdate as date
from production.workorder as o
left join production.product as p
    on o.productid = p.productid
left join production.workorderrouting as r
    on o.workorderid = r.workorderid
left join production.location as l
    on l.locationid = r.locationid;
