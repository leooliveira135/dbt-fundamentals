with packages_destination as (

    select
        customer_id,
        min(created) as first_order_date,
        max(created) as most_recent_order_date,
        count(id) as number_of_orders

    from prod.prodpostgres_dms.dispatch_package

    group by 1

)

select * from packages_destination