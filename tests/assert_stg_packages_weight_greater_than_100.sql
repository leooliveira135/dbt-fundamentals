with weight_package as (
    select * from {{ ref('stg_packages') }}    
)

select
    package_id,
    sum(weight) as sum_weight
from
    weight_package
group by
    package_id
having
    sum_weight < 100