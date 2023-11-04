WITH source AS (
    SELECT * FROM {{source ('main','central_park_weather')}}
),

cleaned AS(
    SELECT 
        TRIM(BOTH ' ' FROM station) as station, 
        TRIM(BOTH ' ' FROM name) as name,
        date::date as date,
        awnd::double as wind_spd_avg,
        prcp::double as prcp,
        snow::double as snow_fall,
        snwd::double as snow_depth,
        tmax::int as tmp_max,
        tmin::int as tmp_min,
        filename
    FROM source

)

SELECT * 
FROM cleaned 
-- eliminate any future data
WHERE date < '2022-12-31'  