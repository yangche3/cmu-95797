with trips_borough as (
    select *
    from
        {{ ref('mart__fact_all_taxi_trips') }} t1 
        JOIN {{ ref('mart__dim_locations') }} t2 ON t1.pulocationid = t2.LocationID
) -- add borough info to all taxi trips table 


select
    Borough as pickup_borough,
    count (*) as total_trips
from trips_borough
group by 1
