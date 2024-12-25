create view turnover_rate as
with s as (
    select 
        d.productid as id, 
        (d.orderqty * (case when b.perassemblyqty is null then 1 else b.perassemblyqty end)) as qty 
    from sales.salesorderdetail as d
    left join production.billofmaterials as b
        on d.productid = b.productassemblyid
),
i as (
    select 
        i.productid as id, 
        i.quantity as qty
    from production.productinventory as i
)
select 
    sum(s.qty) / sum(i.qty) as turnover_rate
from s
full outer join i
    on s.id = i.id;

create view turnover as 
with s as (
    select 
        d.productid as id, 
        (d.orderqty * (case when b.perassemblyqty is null then 1 else b.perassemblyqty end)) as qty 
    from sales.salesorderdetail as d
    left join production.billofmaterials as b
        on d.productid = b.productassemblyid
),
i as (
    select 
        i.productid as id, 
        i.quantity as qty
    from production.productinventory as i
)
select 
    s.id, s.qty, i.qty
from s
full outer join i
    on s.id = i.id;
    