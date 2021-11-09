with
    addressinfo as (
        select
            addressid

            , stateprovinceid	
            , city
	

        from {{ ref('stg_address') }}
    )

    , stateinfo as (
        select 
            stateprovinceid

            , countryregioncode
            , statename
        
        from {{ ref('stg_stateprovince') }}
    )

    , countryinfo as (
        select
            countryregioncode

            , countryname
        
        from {{ ref('stg_countryregion') }}
    )

    , final as (
        select
            addressinfo.addressid
            , addressinfo.city
            , stateinfo.stateprovinceid
            , stateinfo.statename
            , countryinfo.countryregioncode
            , countryinfo.countryname
        
        from stateinfo
        left join addressinfo on stateinfo.stateprovinceid = addressinfo.stateprovinceid
        left join countryinfo on stateinfo.countryregioncode = countryinfo.countryregioncode
    )

select * from final