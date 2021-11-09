with
    source as (
        select
            /* Primary Key */
            salesorderid

            /*Foreign Key */
            , customerid	
            , salespersonid	
            , territoryid
            , billtoaddressid	
            , shiptoaddressid
            , shipmethodid	
            , currencyrateid 
            , creditcardid
	
            , orderdate	
            , duedate	
            , shipdate	
            , revisionnumber
            , status	
            , onlineorderflag	
            , purchaseordernumber	
            , accountnumber	
            , creditcardapprovalcode	
            , subtotal	
            , taxamt	
            , freight	
            , totaldue	
            , rowguid	
            , modifieddate

            /* Stitch */
            , _sdc_table_version
            , _sdc_received_at	
            , _sdc_sequence	
            , _sdc_batched_at	

        from {{ source('aw_el', 'salesorderheader') }}
    )

    , transformed_source as (
        select
            row_number() over (order by salesorderid) as orderheader_sk
            , *
        from source
    )

select * from transformed_source

