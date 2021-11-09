with
    source as (
        select 
            /* Primary Key */
            salesreasonid	
            
            , name as reasonname
            , reasontype	
            , modifieddate

            /* Stitch */
            , _sdc_table_version
            , _sdc_received_at	
            , _sdc_sequence	
            , _sdc_batched_at

        from {{ source('aw_el', 'salesreason') }}
    )

select * from source