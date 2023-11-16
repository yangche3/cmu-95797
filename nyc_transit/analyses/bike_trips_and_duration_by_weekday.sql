SELECT 
    weekday(started_at_ts) as weekday,
    count(*) as total_trips,
    sum(duration_sec) as total_duration
FROM {{ ref('mart__fact_all_bike_trips') }}
GROUP BY 1 
