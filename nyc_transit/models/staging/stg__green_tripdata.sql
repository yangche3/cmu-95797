-- The structure of all staging files is referenced from https://docs.getdbt.com/guides/best-practices/how-we-structure/2-staging 
WITH source AS (

    SELECT * FROM {{ source('main', 'green_tripdata') }}

),

cleaned AS (

    SELECT
        vendorid as vendor_id,
        lpep_pickup_datetime,
        lpep_dropoff_datetime,
        ratecodeid as rate_code_id,
        pulocationid as pickup_loc_id,
        dolocationid as dropoff_loc_id,
        passenger_count,
        trip_distance,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        ehail_fee,
        improvement_surcharge,
        total_amount,
        payment_type,
        trip_type,
        congestion_surcharge,
        {{to_bool("store_and_fwd_flag")}} as store_and_fwd_flag,
        filename

    FROM source

)

SELECT * 
FROM cleaned
-- eliminate any future data
WHERE lpep_pickup_datetime < '2022-12-31'
AND lpep_dropoff_datetime < '2022-12-31' 
-- eliminate negative distance
AND trip_distance > 0 
AND fare_amount >= 0
AND extra > 0
AND mta_tax > 0
AND tip_amount > 0
AND tolls_amount > 0
AND improvement_surcharge > 0
AND total_amount > 0
AND payment_type > 0
AND trip_type > 0
AND congestion_surcharge > 0