WITH source AS (
    SELECT * FROM {{source ('main','fhv_bases')}}
),

cleaned AS(
    
    SELECT 
        base_number, 
        base_name,
        dba,
        dba_category,
        filename
    FROM source
)

SELECT * FROM cleaned 