-- The productvendor table has some problems, we only get 1 reference point from it, we need a change in price over time
-- select 
--     sum(case when (d.unitprice = v.lastreceiptcost) then 1 else 0 end) as equal 
-- from purchasing.purchaseorderdetail as d 
-- left join purchasing.productvendor as v 
--     on d.productid = v.productid;



create view price_change as 
select 
    d.productid as id,
    d.unitprice as price,
    h.orderdate as date
from purchasing.purchaseorderdetail as d
left join purchasing.purchaseorderheader as h
    on d.purchaseorderid = h.purchaseorderid
order by id, date;