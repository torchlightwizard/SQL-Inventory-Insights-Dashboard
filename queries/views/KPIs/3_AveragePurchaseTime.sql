create view average_purchase_time_avg as
with t as ( 
    select purchaseorderid, 
        datediff(DAY, lag(orderdate) over(order by orderdate asc), orderdate) as elapsed_time 
    from purchasing.purchaseorderheader
) 
select avg(elapsed_time) 
from t;



create view average_purchase_time as
with t as ( 
    select purchaseorderid, 
        datediff(DAY, lag(orderdate) over(order by orderdate asc), orderdate) as elapsed_time 
    from purchasing.purchaseorderheader
) 
select elapsed_time 
from t;