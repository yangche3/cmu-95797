-- Calculate the number of trips and average duration by borough and zone.

WITH trips_borough AS (
    SELECT
        *
    FROM
        {{ ref('mart__fact_all_taxi_trips') }} t1
        JOIN {{ ref('mart__dim_locations') }} t2 ON t1.pulocationid = t2.LocationID
    -- Add borough and zone info to all taxi trips table
)

SELECT
    Borough AS borough,
    zone,
    COUNT(*) AS total_trips,
    AVG(duration_min) AS avg_duration_min
FROM
    trips_borough
GROUP BY
    1, 2 -- Group by borough and zone
ORDER BY
    1, 2;
