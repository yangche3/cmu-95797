WITH source AS (

	SELECT * FROM {{ source('main', 'bike_data') }}
	
),

cleaned AS (
    
	SELECT
        bikeid::int as bike_id,
        TRIM(BOTH ' ' FROM ride_id) as ride_id,
        COALESCE(starttime, started_at)::TIMESTAMP as start_datetime,
        COALESCE(stoptime, ended_at)::TIMESTAMP as end_datetime,
        COALESCE(tripduration, datediff('second', start_datetime, end_datetime)):: int as trip_duration,
        TRIM(BOTH ' ' FROM COALESCE("start station id", start_station_id)) as start_station_id,
        TRIM(BOTH ' ' FROM COALESCE("start station name", start_station_name)) as start_station_name,
        COALESCE("start station latitude", start_lat)::double as start_lat,
        COALESCE("start station longitude", start_lng)::double as start_lng,
        TRIM(BOTH ' ' FROM COALESCE("end station id", end_station_id)) as end_station_id,
        TRIM(BOTH ' ' FROM COALESCE("end station name", end_station_name)) as end_station_name,
        COALESCE("end station latitude", end_lat)::double as end_lat,
        COALESCE("end station longitude", end_lng)::double as end_lng,
        TRIM(BOTH ' ' FROM usertype) as user_type,
        "birth year"::int as birth_year,
        {{to_gender("gender")}} as gender,
        TRIM(BOTH ' ' FROM rideable_type) as rideable_type,
        TRIM(BOTH ' ' FROM member_casual) as member_casual,
        filename

    FROM source
)

SELECT * 
FROM cleaned
-- eliminate negative duration
WHERE trip_duration >= 0  