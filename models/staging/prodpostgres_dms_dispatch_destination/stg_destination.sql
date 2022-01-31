with destination as (

    select
        id as destination_id,
        address_data,
        google_maps_id

    from prod.prodpostgres_dms.dispatch_destination

)

select * from destination