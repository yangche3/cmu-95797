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

SELECT * FROM cleaned