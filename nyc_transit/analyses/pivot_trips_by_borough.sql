--Write a query to pivot the results by borough.

SELECT
    {{ dbt_utils.pivot('pickup_borough', 
                        dbt_utils.get_column_values( ref('mart__fact_trips_by_borough'), 'pickup_borough'),
                        then_value='total_trips'
    )}}
FROM {{ ref('mart__fact_trips_by_borough')}}