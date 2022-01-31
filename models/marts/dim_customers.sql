-- with destination as (

--     select
--         id as destination_id,
--         address_data,
--         google_maps_id

--     from prod.prodpostgres_dms.dispatch_destination

-- ),

-- packages as (

--     select
--         id as package_id,
--         customer_id,
--         created,
--         destination_confirmed_by_recipient

--     from prod.prodpostgres_dms.dispatch_package

-- ),

-- packages_destination as (

--     select
--         customer_id,

--         min(created) as first_order_date,
--         max(created) as most_recent_order_date,
--         count(package_id) as number_of_orders

--     from packages

--     group by 1

-- ),

with packages as (
    select * from {{ ref('stg_packages') }}
),

packages_destination as (
    select * from {{ ref('stg_packages_destination') }}
),

final as (

    select
        packages.customer_id,
        packages.created,
        packages.destination_confirmed_by_recipient,
        packages_destination.first_order_date,
        packages_destination.most_recent_order_date,
        coalesce(packages_destination.number_of_orders, 0) as number_of_orders

    from packages

    left join packages_destination using (customer_id)

)

select * from final