{{ config(materialized='table') }}

with dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    fhv.dispatching_base_num,
    fhv.pickup_datetime,
    fhv.dropoff_datetime,
    fhv.sr_flag,
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  
from {{ ref('stg_fhv_data' )}} as fhv
inner join dim_zones as pickup_zone
on fhv.pickup_location_id = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhv.dropoff_location_id = dropoff_zone.locationid


