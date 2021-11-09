with
    selected as (
        select
            creditcard_sk

            , creditcardid	
            
            , cardtype	
            /* , cardnumber	*/
            , expmonth	
            , expyear	
            , modifieddate		

        from {{ ref('stg_creditcard') }}
    )

select * from selected