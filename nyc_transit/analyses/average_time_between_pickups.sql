-- Find the average time between taxi pick-ups per zone

-- Create a common table expression (CTE) to calculate the time difference between consecutive pick-up times
WITH trips_pickup_diff AS (
    SELECT
        pulocationid,
        pickup_datetime,
        DATEDIFF('second', LAG(pickup_datetime, 1) OVER (PARTITION BY pulocationid ORDER BY pickup_datetime), pickup_datetime) AS time_pickup_diff_sec,
        
    FROM
        {{ ref('mart__fact_all_taxi_trips') }}
)

-- Select the zone and the average time between pick-ups in seconds for each zone
SELECT
    zone,
    AVG(time_pickup_diff_sec) AS avg_time_btw_sec
FROM
    trips_pickup_diff t1
    JOIN {{ ref('mart__dim_locations') }} t2 
    ON t1.pulocationid = t2.LocationID
GROUP BY
    1
ORDER BY
    2;
