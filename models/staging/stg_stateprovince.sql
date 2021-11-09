with
    source as (
        select
            /* Primary Key */
            stateprovinceid

            /* Foreign Key */
            , countryregioncode
            , territoryid /* from table SalesTerritory -> currently out of our model */

            , stateprovincecode		
            , isonlystateprovinceflag	
            , name as statename
            , rowguid	
            , modifieddate	

            /* Stitch */
            , _sdc_table_version
            , _sdc_received_at	
            , _sdc_sequence	
            , _sdc_batched_at

        from {{ source('aw_el', 'stateprovince') }}
    )

select * from source