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

SELECT * FROM cleaned