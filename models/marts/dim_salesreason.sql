with 
    reasoninfo as (
        select
            salesreasonid
            , reasontype
            , reasonname
        from {{ ref('stg_salesreason') }}    
    )
    
    , salesreasoninfo as (
        select 
            salesorderid
            , salesreasonid
	    from {{ ref('stg_salesorderheadersalesreason') }}
    )
    
    , reasonperorder as (
        select
            salesreasoninfo.salesorderid
            , reasoninfo.salesreasonid
            , reasoninfo.reasontype
            , reasoninfo.reasonname
        from salesreasoninfo
        left join reasoninfo on reasoninfo.salesreasonid = salesreasoninfo.salesreasonid
        where salesreasoninfo.salesreasonid is not Null
    )

    , source as (
        select
            salesorderid,
            STRING_AGG(reasonname, ', ') as salesreasons
        from reasonperorder
        group by salesorderid
    )

select * from source