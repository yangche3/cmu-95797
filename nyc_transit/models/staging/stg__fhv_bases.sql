WITH source AS (
    SELECT * FROM {{source ('main','fhv_bases')}}
),

cleaned AS(
    
    SELECT 
        TRIM(BOTH ' ' FROM base_number) as base_number, 
        TRIM(BOTH ' ' FROM base_name) as base_name,
        TRIM(BOTH ' ' FROM dba) as dba,
        TRIM(BOTH ' ' FROM dba_category) as dba_category,
        filename
    FROM source
)

SELECT * FROM cleaned 