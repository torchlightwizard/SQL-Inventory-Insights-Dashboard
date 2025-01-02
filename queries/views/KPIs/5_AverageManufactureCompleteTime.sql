create view average_man_end_time_avg as
with t as ( 
    select 
        workorderid as id, 
        datediff(DAY, lag(enddate) over(order by enddate asc), enddate) as elapsed_time 
    from production.workorder
    where orderqty != scrappedqty
) 
select 
    p.name as product, 
    avg(t.elapsed_time) as elapsed_time 
from t
left join production.workorderrouting as r
    on r.workorderid = t.id
left join production.product as p
    on p.productid = r.productid
    group by p.name;



create view average_man_end_time as
with t as ( 
    select 
        workorderid as id, 
        datediff(DAY, lag(enddate) over(order by enddate asc), enddate) as elapsed_time 
    from production.workorder
    where orderqty != scrappedqty
) 
select 
    p.name as product,
    t.elapsed_time as elapsed_time 
from t
left join production.workorderrouting as r
    on r.workorderid = t.id
left join production.product as p
    on p.productid = r.productid;