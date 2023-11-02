WITH source AS (

	SELECT * FROM {{ source('main', 'fhv_tripdata') }}
	
),

cleaned AS (

  SELECT 
        dispatching_base_num,
        pickup_datetime,
        dropoff_datetime,
        PUlocationID as pickup_loc_id,
        DOlocationID as dropoff_loc_id,
        Affiliated_base_number,
        filename
	FROM source
)

SELECT * FROM cleaned