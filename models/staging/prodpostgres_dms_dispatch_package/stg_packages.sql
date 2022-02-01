with packages as (

    select distinct
        id as package_id,
        customer_id,
        created,
        destination_confirmed_by_recipient,
        weight

    from prod.prodpostgres_dms.dispatch_package

    where customer_id is not null

)

select * from packages