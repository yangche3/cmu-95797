-- Write a query to find all the Zones where there are less than 100,000 trips.

WITH trips_zone AS (
    SELECT
        t1.*,
        t2.zone
    FROM
        {{ ref('mart__fact_all_taxi_trips') }} t1
        JOIN {{ ref('mart__dim_locations') }} t2 ON t1.pulocationid = t2.LocationID
    -- Add zone info to all taxi trips table
)

SELECT
    zone,
    COUNT(*) AS total_trips
FROM
    trips_zone
GROUP BY
    1
HAVING
    total_trips < 100000
ORDER BY
    1;
