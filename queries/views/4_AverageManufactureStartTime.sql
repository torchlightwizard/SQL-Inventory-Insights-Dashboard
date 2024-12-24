create view average_man_start_time_avg as
with t as ( 
    select workorderid, 
        datediff(DAY, lag(startdate) over(order by startdate asc), startdate) as elapsed_time 
    from production.workorder
) 
select avg(elapsed_time) 
from t;

create view average_man_start_time as
with t as ( 
    select workorderid, 
        datediff(DAY, lag(startdate) over(order by startdate asc), startdate) as elapsed_time 
    from production.workorder
) 
select elapsed_time 
from t;