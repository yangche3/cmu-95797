{% macro to_bool(column_name) %}
(case
    when {{column_name}}='Y' then true
    when {{column_name}}='N' then false
    when {{column_name}}='' then null
    when {{column_name}} is null then null
    else {{column_name}}
end)::bool
{% endmacro %}

{% macro to_gender(column_name) %}
(case
    when {{column_name}}=1 then 'male'
    when {{column_name}}=2 then 'female'
    when {{column_name}}=0 then 'unknown'
    else {{column_name}}
end)
{% endmacro %}