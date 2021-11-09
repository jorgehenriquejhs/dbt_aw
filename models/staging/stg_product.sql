with
    source as (
        select
            /* Primary Key */
            productid	

            , name as productname
            , productnumber	
            , sellenddate	
            , safetystocklevel	
            , finishedgoodsflag	
            , class	
            , makeflag	
            , reorderpoint	
            , standardcost	
            , style	
            , listprice	
            , daystomanufacture	
            , productline	
            , size		
            , color	
            , sellstartdate	
            , weight
            , modifieddate	
            , rowguid	

            /* Foreign Key */
            , productsubcategoryid	
            , productmodelid
            , sizeunitmeasurecode
            , weightunitmeasurecode	
            	

            /* Stitch */
            , _sdc_table_version
            , _sdc_received_at	
            , _sdc_sequence	
            , _sdc_batched_at	
            
        from {{ source('aw_el', 'product') }}
    )

    , transformed_source as (
        select
            row_number() over (order by productid) as product_sk
            , *
        from source
    )

select * from transformed_source