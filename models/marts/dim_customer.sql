with
    customerinfo as (
        select
            customer_sk

            , customerid	

        from {{ ref('stg_customer') }}
    )

    , personinfo as (
        select
            businessentityid
            
            , fullname

        from {{ ref('stg_person') }}
    )

    , storeinfo as (
        select
            storecustomerid
            
            , storename

        from {{ ref('stg_store') }}
    ) 

    , final as (
        select
            customerinfo.customer_sk
            , customerinfo.customerid
            , personinfo.businessentityid
            , personinfo.fullname
            , storeinfo.storecustomerid
            , storeinfo.storename
            , case
            when personinfo.fullname is not null
            then personinfo.fullname
            else storeinfo.storename
            end as customername
        
        from customerinfo
        left join personinfo on customerinfo.customerid = personinfo.businessentityid
        left join storeinfo on customerinfo.customerid = storeinfo.storecustomerid
    )

select * from final