create view delay as 
select 
    d.productid as id,
    v.name as name, 
    datediff(DAY, orderdate, shipdate) as time 
from purchasing.purchaseorderheader as h
left join purchasing.purchaseorderdetail as d
    on d.purchaseorderid = h.purchaseorderid
left join purchasing.vendor as v
    on v.businessentityid = h.vendorid;
