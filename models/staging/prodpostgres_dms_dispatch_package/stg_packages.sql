with packages as (

    select
        id as package_id,
        customer_id,
        created,
        destination_confirmed_by_recipient

    from prod.prodpostgres_dms.dispatch_package

)

select * from packages