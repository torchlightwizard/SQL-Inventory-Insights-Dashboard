create view turnover_rate as
with s as (
    select d.productid as id, h.shipdate as date, d.linetotal as price
    from sales.salesorderheader as h
    inner join sales.salesorderdetail as d
    on h.salesorderid = d.salesorderid
),
p as (
    select d.productid as id, h.shipdate as date, (d.linetotal) as price
    from purchasing.purchaseorderheader as h
    inner join purchasing.purchaseorderdetail as d
    on h.purchaseorderid = d.purchaseorderid
)
select 
    sum(s.price) as total_sales,
    sum(p.price) as total_cost,
    (sum(s.price) / sum(p.price)) * 100 as turnover
from s
full outer join p
on s.date = p.date;

create view turnover as 
with s as (
    select d.productid as id, h.shipdate as date, d.linetotal as price
    from sales.salesorderheader as h
    inner join sales.salesorderdetail as d
    on h.salesorderid = d.salesorderid
),
p as (
    select d.productid as id, h.shipdate as date, (d.linetotal) as price
    from purchasing.purchaseorderheader as h
    inner join purchasing.purchaseorderdetail as d
    on h.purchaseorderid = d.purchaseorderid
)
select 
    s.date as date, 
    s.id as sales_id, 
    p.id as purchase_id, 
    s.price as sales_price, 
    p.price as purchase_price,
    ps.name as sales_name,
    pp.name as purchase_name
from s
full outer join p
on s.date = p.date
inner join production.product as ps
on s.id = ps.productid
inner join production.product as pp
on p.id = pp.productid;