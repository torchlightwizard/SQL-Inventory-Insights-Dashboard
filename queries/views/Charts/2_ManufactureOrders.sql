create view manufacture_orders as 
select 
    o.workorderid as orderid,
    o.productid as productid,
    o.orderqty as qty,
    o.startdate as date,
    (case when r.locationid is null then 7 else r.locationid end) as locationid
from production.workorder as o
left join production.workorderrouting as r
    on o.workorderid = r.workorderid;