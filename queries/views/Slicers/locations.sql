create view locations_unique as 
select 
    locationid as id,
    name as location
from production.location;