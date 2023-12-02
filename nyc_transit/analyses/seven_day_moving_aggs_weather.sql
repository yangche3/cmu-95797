-- Write a query to calculate the 7-day moving min, max, avg, sum for precipitation and snow for every day in the weather data, defining the window only once. The 7-day window should center on the day in question (for each date, the 3 days before, the date, and 3 days after).

SELECT
    date,
    MIN(prcp) OVER seven_days AS min_prcp,
    MAX(prcp) OVER seven_days AS max_prcp,
    AVG(prcp) OVER seven_days AS avg_prcp,
    SUM(prcp) OVER seven_days AS sum_prcp,
    MIN(snow) OVER seven_days AS min_snow,
    MAX(snow) OVER seven_days AS max_snow,
    AVG(snow) OVER seven_days AS avg_snow,
    SUM(snow) OVER seven_days AS sum_snow
FROM
    {{ ref('stg__central_park_weather')}}
WINDOW seven_days AS (
    ORDER BY date ASC 
    RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND 
                  INTERVAL 3 DAYS FOLLOWING
);
