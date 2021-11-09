with
    source as (
        select
            /* Primary Key */
            businessentityid

            , CONCAT(firstname, ' ', lastname) as fullname
            , title
            , firstname
            , middlename
            , lastname
            , suffix
            , persontype
            , namestyle
            , emailpromotion
            , modifieddate
            , rowguid        

            /* Stitch */
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_sequence
            , _sdc_batched_at
            
        from {{ source('aw_el', 'person') }}
    )

select * from source