with
    source as (
        select
            /* Primary Key */
            businessentityid as storecustomerid
            
            /* Foreign Key */
            , salespersonid

            , name as storename
            , modifieddate	
            , rowguid		

            /* Stitch */
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_sequence
            , _sdc_batched_at
            
        from {{ source('aw_el', 'store') }}
    )

select * from source