with annotation as (

    select
        id as annotation_id,
        package_id,
        created,
        annotation,
        annotation_type

    from prod.prodpostgres_glue.dispatch_packageannotation_0x7rtqjhke1hd
)

select * from annotation