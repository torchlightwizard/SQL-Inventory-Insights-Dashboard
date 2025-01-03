create view rejected_ratio as 
select 
    (sum(rejectedqty) / sum(stockedqty)) as rejection ratio
from purchasing.purchaseorderdetail;



create view rejected as 
select 
    p.name as product, 
    d.orderqty as ordered_qty, 
    d.stockedqty as stocked_qty, 
    d.rejectedqty as rejected_qty,
    d.modifieddate as date
from purchasing.purchaseorderdetail as d 
left join production.product as p 
    on p.productid = d.productid 
-- order by rejectedqty desc
;