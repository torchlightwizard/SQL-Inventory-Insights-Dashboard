create view purchase_by_vendor as 
select 
    p.name as product,
    v.name as vendor,
    d.orderqty as qty,
    d.linetotal as cost,
    h.orderdate as date
from purchasing.purchaseorderdetail as d
left join production.product as p 
    on d.productid = p.productid
left join purchasing.purchaseorderheader as h
    on d.purchaseorderid = h.purchaseorderid
left join purchasing.vendor as v
    on h.vendorid = v.businessentityid;
