WITH trips_diff_locs_weekday AS (
    SELECT
        weekday(pickup_datetime) AS weekday,
        COUNT(*) AS total_trips_diff_locs
    FROM
        {{ ref('mart__dim_locations') }} t1
        RIGHT JOIN {{ ref('mart__fact_all_taxi_trips') }} t2 ON t2.pulocationid = t1.LocationID
        LEFT JOIN {{ ref('mart__dim_locations') }} t3 ON t2.dolocationid = t3.LocationID
    WHERE
        t1.Borough != t3.Borough
    GROUP BY 1
),
all_trips_weekday AS (
    SELECT
        weekday(pickup_datetime) AS weekday,
        COUNT(*) AS total_trips
    FROM
        {{ ref('mart__fact_all_taxi_trips') }}
    GROUP BY 1
)
SELECT
    v1.weekday AS weekday,
    total_trips,
    total_trips_diff_locs,
    ROUND(total_trips_diff_locs / total_trips * 100,2) AS diff_start_end_pct
FROM
    trips_diff_locs_weekday v1
    INNER JOIN all_trips_weekday v2 ON v1.weekday = v2.weekday;
