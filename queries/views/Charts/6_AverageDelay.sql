create view delay as 
select 
    p.name as product,
    v.name as vendor, 
    datediff(DAY, orderdate, shipdate) as time 
from purchasing.purchaseorderheader as h
left join purchasing.purchaseorderdetail as d
    on d.purchaseorderid = h.purchaseorderid
left join production.product as p 
    on d.productid = p.productid
left join purchasing.vendor as v
    on v.businessentityid = h.vendorid;
