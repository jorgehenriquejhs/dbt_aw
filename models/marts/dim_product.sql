with
    selected as (
        select
            product_sk

            , productid	

            , productname	
	

        from {{ ref('stg_product') }}
    )

select * from selected