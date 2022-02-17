{{ config(materialized='view') }}


select
    dispatching_base_num,
    pickup_datetime,
    dropoff_datetime,
    PULocationID as pickup_location_id,
    DOLocationID as dropoff_location_id,
    SR_Flag as sr_flag
from {{ source('staging_fhv', 'fhv_data') }}


-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}
