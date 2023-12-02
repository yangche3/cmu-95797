-- Write a query to calculate the 7-day moving average precipitation for every day in the weather data. The 7-day window should center on the day in question (for each date, the 3 days before, the date, and 3 days after).

SELECT
    date,
    (
        LAG(prcp, 3) OVER (ORDER BY date) +
        LAG(prcp, 2) OVER (ORDER BY date) +
        LAG(prcp, 1) OVER (ORDER BY date) +
        prcp +
        LEAD(prcp, 1) OVER (ORDER BY date) +
        LEAD(prcp, 2) OVER (ORDER BY date) +
        LEAD(prcp, 3) OVER (ORDER BY date)
    ) / 7.0 AS moving_7d_avg_prcp
FROM
    {{ ref('stg__central_park_weather') }}
ORDER BY 
    1;
