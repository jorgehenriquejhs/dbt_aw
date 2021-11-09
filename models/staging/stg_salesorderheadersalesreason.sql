with
    source as (
        select 
            salesorderid		            	
            , salesreasonid	
            , modifieddate		

            /* Stitch */
            , _sdc_table_version
            , _sdc_received_at	
            , _sdc_sequence	
            , _sdc_batched_at

        from {{ source('aw_el', 'salesorderheadersalesreason') }}
    )

select * from source