-- The productvendor table has some problems, we only get 1 reference point from it, we need a change in price over time
create view price_change as 
select 
    pv.productid as id,
    v.name as name,
    (pv.lastreceiptcost - pv.standardprice) as price_change,
    ((pv.lastreceiptcost - pv.standardprice) /  pv.standardprice) as price_change_perc,
    pv.lastreceiptdate as date
from purchasing.productvendor as pv
left join purchasing.vendor as v
    on v.businessentityid = pv.businessentityid
-- order by id, name, date, price_change
;

-- This one is better, but since we only have one frame of reference, we again get redundant information
create view price_change2 as 
select 
    d.productid as id,
    v.name as name,
    (d.unitprice - pv.standardprice) as price_change,
    ((d.unitprice - pv.standardprice) / pv.standardprice) as price_change_perc,
    h.orderdate as date
from purchasing.purchaseorderdetail as d 
left join purchasing.purchaseorderheader as h 
    on d.purchaseorderid = h.purchaseorderid
left join purchasing.productvendor as pv 
    on d.productid = pv.productid
left join purchasing.vendor as v
    on v.businessentityid = pv.businessentityid
-- order by id, name, date, price_change
;



-- Well this didnt give expected results, even though its better
-- Just use the above boring one then
create view price_change3 as 
with p as (
    select 
        d.productid as id,
        v.name as name, 
        d.unitprice as price,
        h.orderdate as date,
        lag(d.unitprice, 1, d.unitprice) over (partition by d.productid, v.name order by h.orderdate, d.unitprice) as prevprice,
        lag(h.orderdate, 1, h.orderdate) over (partition by d.productid, v.name order by h.orderdate, d.unitprice) as prevdate
    from purchasing.purchaseorderdetail as d
    left join purchasing.purchaseorderheader as h
        on d.purchaseorderid = h.purchaseorderid
    left join purchasing.vendor as v
        on h.vendorid = v.businessentityid
)
select 
    -- p.id,
    -- p.name,
    -- (p.price - p.prevprice) as price_change,
    -- p.date
    sum(p.price - p.prevprice) total_change
from p;
