-- Use Window functions with QUALIFY and ROW_NUMBER to remove duplicate rows. Prefer rows with a later timestamp.

-- Select all columns from the 'events' table, keeping only rows with the latest timestamp for each event_id
SELECT
    *
FROM
    {{ ref('events') }}
QUALIFY
    ROW_NUMBER() OVER (PARTITION BY event_id ORDER BY insert_timestamp DESC) = 1;
