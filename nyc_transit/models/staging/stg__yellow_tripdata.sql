WITH source AS (

    SELECT * FROM {{ source('main', 'yellow_tripdata') }}

),

cleaned AS (

    SELECT
        vendorid,
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        passenger_count,
        trip_distance,
        ratecodeid as rate_code_id,
        pulocationid as pickup_loc_id,
        dolocationid as dropoff_loc_id,
        payment_type,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        congestion_surcharge,
        airport_fee,
        {{to_bool("store_and_fwd_flag")}} as store_and_fwd_flag,
        filename

    FROM source

)

SELECT * 
FROM cleaned
-- eliminate any future data
WHERE tpep_pickup_datetime < '2022-12-31'
AND tpep_dropoff_datetime < '2022-12-31' 
-- eliminate negative distance
AND trip_distance > 0 
AND fare_amount > 0
AND extra > 0
AND mta_tax > 0
AND tip_amount > 0
AND tolls_amount > 0
AND improvement_surcharge > 0
AND total_amount > 0
AND congestion_surcharge > 0
AND airport_fee > 0