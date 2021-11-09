with
    source as (
        select
            /* Primary Key */
            addressid

            /* Foreign Key */
            , stateprovinceid
                	
            , addressline1	
            , addressline2	
            , city		
            , postalcode	
            , spatiallocation	
            , rowguid	
            , modifieddate

            /* Stitch */
            , _sdc_table_version
            , _sdc_received_at	
            , _sdc_sequence	
            , _sdc_batched_at	

        from {{ source('aw_el', 'address') }}
    )

select * from source