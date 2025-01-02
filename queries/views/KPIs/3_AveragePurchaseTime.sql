create view average_purchase_time_avg as
with t as ( 
    select 
        purchaseorderid as id, 
        datediff(DAY, lag(orderdate) over(order by orderdate asc), orderdate) as elapsed_time 
    from purchasing.purchaseorderheader
) 
select 
    p.name as product,
    avg(t.elapsed_time) as elapsed_time
from t
left join purchasing.purchaseorderdetail as d
    on d.purchaseorderid = t.id
left join production.product as p
    on p.productid = d.productid
    group by p.name;



create view average_purchase_time as
with t as ( 
    select 
        purchaseorderid as id, 
        datediff(DAY, lag(orderdate) over(order by orderdate asc), orderdate) as elapsed_time 
    from purchasing.purchaseorderheader
) 
select 
    p.name as product,
    t.elapsed_time as elapsed_time
from t
left join purchasing.purchaseorderdetail as d
    on d.purchaseorderid = t.id
left join production.product as p
    on p.productid = d.productid;
