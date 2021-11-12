with
    validation as (
        select count(salesorderdetailid) as num_of_orderdetails
        from {{ref ('fact_order')}} 
        where orderdate between '2011-05-31' and '2014-06-30'
    )

select * from validation where num_of_orderdetails != 121317