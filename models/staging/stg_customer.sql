with
    source as (
        select
            /* Primary Key */
            customerid

            /* Foreign Key */
            , territoryid	
            , storeid	
            , personid
            
            , modifieddate	
            , rowguid			

            /* Stitch */
            , _sdc_table_version
            , _sdc_received_at	
            , _sdc_sequence	
            , _sdc_batched_at	
            
        from {{ source('aw_el', 'customer') }}
    )

    , transformed_source as (
        select
            row_number() over (order by customerid) as customer_sk
            , *
        from source
    )

select * from transformed_source