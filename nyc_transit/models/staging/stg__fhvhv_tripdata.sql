-- The structure of all staging files is referenced from https://docs.getdbt.com/guides/best-practices/how-we-structure/2-staging 
WITH source AS (

    SELECT * FROM {{ source('main', 'fhvhv_tripdata') }}

),

cleaned AS (

    SELECT
        hvfhs_license_num,
        dispatching_base_num,
        originating_base_num,
        request_datetime,
        on_scene_datetime,
        pickup_datetime,
        dropoff_datetime,
        pulocationid as pickup_loc_id,
        dolocationid as dropoff_loc_id,
        trip_miles,
        trip_time,
        base_passenger_fare,
        tolls,
        bcf as black_car_fund,
        sales_tax,
        congestion_surcharge,
        airport_fee,
        tips,
        driver_pay,
        {{to_bool("shared_request_flag")}} as shared_request_flag,
        {{to_bool("shared_match_flag")}} as shared_match_flag,
        {{to_bool("access_a_ride_flag")}} as access_a_ride_flag,
        {{to_bool("wav_request_flag")}} as wav_request_flag,
        {{to_bool("wav_match_flag")}} as wav_match_flag,
        filename

    FROM source

)

SELECT * 
FROM cleaned
-- eliminate any future data
WHERE pickup_datetime < '2022-12-31' 
AND dropoff_datetime < '2022-12-31' 
AND request_datetime < '2022-12-31'
AND on_scene_datetime < '2022-12-31' 
-- eliminate negative distance
AND trip_miles > 0 