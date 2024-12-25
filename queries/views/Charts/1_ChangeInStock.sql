create view inbound as
select productid as id, stockedqty as qty, enddate as date from production.workorder
union all
select d.productid as id, d.stockedqty as qty, h.modifieddate as date from purchasing.purchaseorderheader as h inner join purchasing.purchaseorderdetail as d on h.purchaseorderid = d.purchaseorderid;



create view outbound as
select b.componentid as id, (o.orderqty * b.perassemblyqty) as qty, o.startdate as date from production.workorder as o left join production.billofmaterials as b on o.productid = b.productassemblyid
union all
select d.productid as id, d.orderqty as qty, h.modifieddate as date from sales.salesorderheader as h inner join sales.salesorderdetail as d on h.salesorderid = d.salesorderid;



with i as (
    select productid as id, stockedqty as qty, enddate as date from production.workorder
    union all
    select d.productid as id, d.stockedqty as qty, h.modifieddate as date from purchasing.purchaseorderheader as h inner join purchasing.purchaseorderdetail as d on h.purchaseorderid = d.purchaseorderid
),
o as (
    select b.componentid as id, (o.orderqty * b.perassemblyqty) as qty, o.startdate as date from production.workorder as o left join production.billofmaterials as b on o.productid = b.productassemblyid
    union all
    select d.productid as id, d.orderqty as qty, h.modifieddate as date from sales.salesorderheader as h inner join sales.salesorderdetail as d on h.salesorderid = d.salesorderid
)
select sum(i.qty), sum(o.qty) from i full outer join o on i.date = o.date;
