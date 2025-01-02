create view min_date as
with min as (
    select 
        min(startdate) as date
    from production.workorder
union all
    select 
        min(orderdate) as date
    from purchasing.purchaseorderheader
union all
    select 
        min(orderdate) as date
    from sales.salesorderheader
)
select 
    min(date) as date
from min;



create view max_date as
with max as (
    select 
        max(modifieddate) as date
    from production.workorderrouting
union all
    select 
        max(modifieddate) as date
    from purchasing.purchaseorderheader
union all
    select 
        max(modifieddate) as date
    from sales.salesorderheader
)
select 
    max(date) as date
from max;
