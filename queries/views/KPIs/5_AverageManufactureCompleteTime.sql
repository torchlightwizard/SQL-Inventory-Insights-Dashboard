create view average_man_end_time_avg as
with t as ( 
    select workorderid, 
        datediff(DAY, lag(enddate) over(order by enddate asc), enddate) as elapsed_time 
    from production.workorder
    where orderqty != scrappedqty
) 
select avg(elapsed_time) 
from t;



create view average_man_end_time as
with t as ( 
    select workorderid, 
        datediff(DAY, lag(enddate) over(order by enddate asc), enddate) as elapsed_time 
    from production.workorder
    where orderqty != scrappedqty
) 
select elapsed_time 
from t;