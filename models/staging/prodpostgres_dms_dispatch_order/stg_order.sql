with destination as (

    select
        id as order_id,
        customer_id,
        package_type,
        created

    from prod.prodpostgres_dms.dispatch_order

)

select * from destination