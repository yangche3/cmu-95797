SELECT 
    count (*) AS total_trips_to_airport
FROM {{ ref('mart__fact_all_taxi_trips')}} t1 
LEFT JOIN {{ ref('mart__dim_locations')}} t2 
ON t1.dolocationid = t2.LocationID
WHERE t2.service_zone='Airports' OR t2.service_zone='EWR'
