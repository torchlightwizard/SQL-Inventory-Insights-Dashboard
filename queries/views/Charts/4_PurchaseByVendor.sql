create view purchase_by_vendor as 
select 
    d.productid as id,
    d.orderqty as qty,
    d.linetotal as cost,
    h.orderdate as date,
    v.name as vendor
from purchasing.purchaseorderdetail as d
left join purchasing.purchaseorderheader as h
    on d.purchaseorderid = h.purchaseorderid
left join purchasing.vendor as v
    on h.vendorid = v.businessentityid;