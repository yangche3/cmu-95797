-- Write a query to compare an individual fare to the zone, borough, and overall average fare using the fare_amount in yellow taxi trip data.

WITH yellow_trips_borough AS (
    SELECT
        *
    FROM
        {{ ref('stg__yellow_tripdata')}} tb1
        JOIN {{ ref('mart__dim_locations')}} tb2 ON tb1.pulocationid = tb2.locationid
    -- Add borough and zone info to yellow taxi trips table
)

SELECT
    fare_amount,
    AVG(fare_amount) OVER (PARTITION BY zone) AS avg_fare_zone,
    AVG(fare_amount) OVER (PARTITION BY borough) AS avg_fare_borough,
    AVG(fare_amount) OVER () AS avg_fare_overall
FROM
    yellow_trips_borough
ORDER BY
    1 DESC;
