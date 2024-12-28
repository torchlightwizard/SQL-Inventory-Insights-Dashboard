create view production.inbound as 
    select 
        productid as id, 
        stockedqty as qty, 
        enddate as date 
    from production.workorder 
union all 
    select 
        d.productid as id, 
        d.stockedqty as qty, 
        h.modifieddate as date 
    from purchasing.purchaseorderheader as h 
    inner join purchasing.purchaseorderdetail as d 
        on h.purchaseorderid = d.purchaseorderid;



create view production.outbound as 
    select 
        b.componentid as id, 
        -- Here we ignore the fact if b.perassembly has duplicate values, because we cant find the real true value
        (o.orderqty * (case when b.perassemblyqty is null then 1 else b.perassemblyqty end)) as qty, 
        o.startdate as date 
    from production.workorder as o 
    left join production.billofmaterials as b 
        on o.productid = b.productassemblyid 
union all 
    select 
        d.productid as id, 
        d.orderqty as qty, 
        h.modifieddate as date 
    from sales.salesorderheader as h 
    inner join sales.salesorderdetail as d 
        on h.salesorderid = d.salesorderid;



create view production.inventory_change as 
with i as (
    select 
        id, 
        sum(qty) as qty, 
        date 
    from production.inbound 
        group by id, date
),
o as (
    select 
        id, 
        sum(qty) as qty, 
        date 
    from production.outbound 
        group by id, date
)
select 
    (case when o.id is null then pi.name else po.name end) as product,
    (case when o.qty is null then 0 else o.qty end) - (case when i.qty is null then 0 else i.qty end) as qty_changed,
    (case when o.date is null then i.date else o.date end) as date
from o
full outer join i
    on (o.id = i.id and o.date = i.date)
left join production.product as pi
    on i.id = pi.productid
left join production.product as po
    on o.id = po.productid;
