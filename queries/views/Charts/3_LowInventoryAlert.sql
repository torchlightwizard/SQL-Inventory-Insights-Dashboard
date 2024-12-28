create view low_inventory_alert_per_location as
select 
    p.name as product,
    l.name as location,
    i.quantity as qty,
    p.reorderpoint as qty_limit,
    (case when (i.quantity < p.reorderpoint) then 1 else 0 end) as alert
from production.productinventory as i
left join production.product as p
    on i.productid = p.productid
left join production.location as l
    on l.locationid = i.locationid;



create view low_inventory_alert_combined as 
with i as (
    select 
        i.productid as id,
        sum(i.quantity) as qty
    from production.productinventory as i
        group by i.productid
)
select 
    p.name as product,
    i.qty as qty,
    p.reorderpoint as qty_limit,
    (case when (i.qty < p.reorderpoint) then 1 else 0 end) as alert
from i
left join production.product as p
    on i.id = p.productid;
