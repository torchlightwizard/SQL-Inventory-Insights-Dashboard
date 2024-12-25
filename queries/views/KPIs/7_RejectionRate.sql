create view rejected_ratio as 
select 
    (sum(rejectedqty) / sum(stockedqty)) * 100
from purchasing.purchaseorderdetail;



create view rejected as 
select 
    productid, 
    orderqty, 
    stockedqty, 
    rejectedqty 
from purchasing.purchaseorderdetail 
order by rejectedqty desc;