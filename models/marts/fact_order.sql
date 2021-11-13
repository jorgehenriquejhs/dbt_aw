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
            , case
                when orderheader.status = 1 then 'Em Processamento'
                when orderheader.status = 2 then 'Aprovado'
                when orderheader.status = 3 then 'Em Espera'
                when orderheader.status = 4 then 'Rejeitado'
                when orderheader.status = 5 then 'Enviado'
                when orderheader.status = 6 then 'Cancelado'
            end as status

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