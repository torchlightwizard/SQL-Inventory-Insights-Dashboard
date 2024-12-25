create view totalexceedsafetysum as 
select 
   count(*)
from production.product as p
inner join production.productinventory as i
on i.productid = p.productid
where (i.quantity > p.safetystocklevel);

create view totalexceedsafety as
select 
    p.productid, 
    i.quantity, 
    p.safetystocklevel,
    (i.quantity - p.safetystocklevel) as exceededquantity
from production.product as p
inner join production.productinventory as i
on i.productid = p.productid
where (i.quantity > p.safetystocklevel);