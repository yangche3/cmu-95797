-- The structure of all staging files is referenced from https://docs.getdbt.com/guides/best-practices/how-we-structure/2-staging 
WITH source AS (

	SELECT * FROM {{ source('main', 'fhv_tripdata') }}
	
),

cleaned AS (

  SELECT 
        TRIM(BOTH ' ' FROM dispatching_base_num) as dispatching_base_num,
        pickup_datetime,
        dropoff_datetime,
        PUlocationID as pickup_loc_id,
        DOlocationID as dropoff_loc_id,
        TRIM(BOTH ' ' FROM Affiliated_base_number) as affiliated_base_number,
        filename
	FROM source
)

SELECT * 
FROM cleaned
-- eliminate any future data
WHERE pickup_datetime < '2022-12-31' 
AND dropoff_datetime < '2022-12-31'