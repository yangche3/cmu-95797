-- Common table expression to join bike trip data with prcp and snow information
WITH bikes_weather AS (
    SELECT
        t1.*,
        prcp,
        snow,
        t2.date AS trip_date
    FROM
        {{ ref('mart__fact_all_bike_trips') }} t1
        LEFT JOIN {{ ref('stg__central_park_weather') }} t2 ON DATE_TRUNC('day', t1.started_at_ts) = t2.date
    WHERE t2.date is not null
),

-- CTE to calculate the average number of bike trips on days with precipitation or snow
avg_trips_on_snow_prep_day AS (
    SELECT
        COUNT(*) / COUNT(DISTINCT trip_date) AS avg_trips_on_snow_prep_day
    FROM
        bikes_weather
    WHERE
        prcp > 0 OR snow > 0
),

-- CTE to find the days which has snow and pcrp on the next day( including days which have snow or prcp tho)
days_tmr_snow_pcrp AS (
    SELECT
        *
    FROM
        bikes_weather
    QUALIFY 
        (LEAD(prcp, 1) OVER (ORDER BY trip_date) > 0 OR LEAD(snow, 1) OVER (ORDER BY trip_date) > 0)
),

-- CTE to filter out days which have snow or prcp already, and then calculate the average number of trips on those days
avg_trips_before_snow_prep_day AS (
    SELECT
        COUNT(*) / COUNT(DISTINCT trip_date) AS avg_trips_before_snow_prep_day
    FROM
        days_tmr_snow_pcrp
    WHERE
        prcp = 0 AND snow = 0
)

-- consolidate two datas together
SELECT
    avg_trips_on_snow_prep_day,
    avg_trips_before_snow_prep_day
FROM
    avg_trips_on_snow_prep_day, avg_trips_before_snow_prep_day

