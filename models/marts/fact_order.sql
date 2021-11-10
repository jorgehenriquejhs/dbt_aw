with
    customer as (
        select *
        from {{ ref('dim_customer') }}
    )

    , product as (
        select *
        from {{ ref('dim_product') }}
    )

    , creditcard as (
        select *
        from {{ ref('dim_creditcard') }}
    )

    , dim_address as (
        select *
        from {{ ref('dim_address') }}
    )

    , salesreason as (
        select *
        from {{ ref('dim_salesreason') }}
    )

    , orderheader_with_sk as (
        select
            customer.customer_sk as customer_fk
            , customer.customername
            , salesreason.salesreasons
            , orderheader.creditcardid
            , orderheader.billtoaddressid
            , orderheader.salesorderid
            , orderheader.orderdate
            , orderheader.status
            , orderheader.subtotal	
            , orderheader.taxamt	
            , orderheader.freight	
            , orderheader.totaldue

        from {{ ref('stg_salesorderheader') }} as orderheader
        left join salesreason on orderheader.salesorderid = salesreason.salesorderid
        left join customer on orderheader.customerid = customer.customerid
        
    )

    , orderdetail_with_sk as (
        select
            product.product_sk as product_fk
            , product.productname
            , orderdetail.salesorderid
            , orderdetail.salesorderdetailid
            , orderdetail.orderqty			
            , orderdetail.unitprice	
            , orderdetail.unitpricediscount
        from {{ ref('stg_salesorderdetail') }} as orderdetail
        left join product on orderdetail.productid = product.productid
    )

    , final as (
        select
            orderheader_with_sk.customer_fk
            , orderheader_with_sk.customername
            , orderheader_with_sk.salesreasons
            , orderheader_with_sk.salesorderid
            , orderheader_with_sk.orderdate
            , orderheader_with_sk.status
            , orderdetail_with_sk.salesorderdetailid
            , orderdetail_with_sk.product_fk
            , orderdetail_with_sk.productname
            , orderdetail_with_sk.orderqty			
            , orderdetail_with_sk.unitprice	
            , orderdetail_with_sk.unitpricediscount
            , orderheader_with_sk.subtotal	
            , orderheader_with_sk.taxamt	
            , orderheader_with_sk.freight	
            , orderheader_with_sk.totaldue
            , dim_address.city
            , dim_address.statename
            , dim_address.countryname
            , creditcard.cardtype

        from orderheader_with_sk
        left join orderdetail_with_sk on orderheader_with_sk.salesorderid = orderdetail_with_sk.salesorderid
        left join dim_address on orderheader_with_sk.billtoaddressid = dim_address.addressid
        left join creditcard on orderheader_with_sk.creditcardid = creditcard.creditcardid
    )

select * from final