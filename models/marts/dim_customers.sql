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


with packages as (
    select * from {{ ref('stg_packages') }}
),

orders as (
    select * from {{ ref('stg_order') }}
),

package_orders as (

    select
        customer_id,
        min(created) as first_order_date,
        max(created) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),

final as (

    select distinct
        packages.customer_id,
        packages.created,
        packages.destination_confirmed_by_recipient,
        package_orders.first_order_date,
        package_orders.most_recent_order_date,
        coalesce(package_orders.number_of_orders, 0) as number_of_orders

    from packages

    left join package_orders using (customer_id)

)

select * from final