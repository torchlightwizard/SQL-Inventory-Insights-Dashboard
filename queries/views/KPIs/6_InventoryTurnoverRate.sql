create view turnover_rate as
with s as (
    select 
        d.productid as id, 
        -- Here we ignore the fact if b.perassembly has duplicate values, because we cant find the real true value
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
    (sum(s.qty) / sum(i.qty)) as turnover_rate
from s
full outer join i
    on s.id = i.id;



create view turnover_not_final as 
with s as (
    select 
        d.productid as id, 
        -- Here we ignore the fact if b.perassembly has duplicate values, because we cant find the real true value
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
    s.id as id, 
    sum(s.qty) as sale_qty, 
    sum(i.qty) as inventory_qty
from s
full outer join i
    on s.id = i.id
    group by s.id;
    


create view turnover_final as 
select 
    p.name as product, 
    (t.sale_qty / t.inventory_qty) as turnover_rate
from turnover_not_final as t
left join production.product as p
    on p.productid = t.id;