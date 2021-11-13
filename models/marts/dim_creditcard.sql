with
    selected as (
        select
            creditcard_sk

            , creditcardid	
            
            , cardtype		

        from {{ ref('stg_creditcard') }}
    )

select * from selected