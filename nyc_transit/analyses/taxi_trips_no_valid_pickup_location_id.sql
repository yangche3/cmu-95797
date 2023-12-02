-- Make a query that finds taxi trips which don’t have a pick-up location_id in the locations table.

SELECT
    t1.*
FROM
    {{ ref('mart__fact_all_taxi_trips') }} t1
    LEFT JOIN {{ ref('mart__dim_locations') }} t2 ON t1.pulocationid = t2.LocationID
WHERE
    t2.LocationID IS NULL; -- Filter out trips with no pick-up location id
