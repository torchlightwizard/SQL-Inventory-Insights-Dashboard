create view safety_sum_individual_location as 
select 
   count(distinct p.productid)
from production.product as p
inner join production.productinventory as i
on i.productid = p.productid
where (i.quantity > p.safetystocklevel);



create view safety_sum_combined_location as 
with i as (
    select productid as id, sum(quantity) as qty
    from production.productinventory
    group by productid
)
select 
   count(*)
from production.product as p
inner join i
    on i.id = p.productid
    where (i.qty > p.safetystocklevel);



create view safety_individual_location as
select 
    p.productid, 
    i.locationid,
    i.quantity, 
    p.safetystocklevel,
    (i.quantity - p.safetystocklevel) as exceededquantity
from production.product as p
inner join production.productinventory as i
on i.productid = p.productid
where (i.quantity > p.safetystocklevel)
order by p.productid asc, i.locationid asc, i.quantity desc;



create view safety_combined_location as 
with i as (
    select productid as id, sum(quantity) as qty
    from production.productinventory
    group by productid
)
select 
    p.productid, 
    i.qty, 
    p.safetystocklevel,
    (i.qty - p.safetystocklevel) as exceededquantity
from production.product as p
inner join i
    on i.id = p.productid
    where (i.qty > p.safetystocklevel);