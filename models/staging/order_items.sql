with
    source as (
        select
            id
            ,order_id
            ,order_type_id
            ,split(upper(item), '@~|~@') as item
            ,ARRAY_LENGTH(REGEXP_EXTRACT_ALL(item, '@~\\|~@')) as occurrences
        from {{ source('sales_car', 'order_items') }}
    ),
    treated as (
        select distinct
            id as order_item_id
            ,order_id
            ,order_type_id
            ,item[OFFSET(0)] as manufacturer
            ,item[OFFSET(1)] as model
            ,item[OFFSET(2)] as year_manufacturer
            ,case
                when item[OFFSET(3)] = 'GREEN' then 'VERDE'
                when item[OFFSET(3)] = 'WHITE' then 'BRANCO'
                when item[OFFSET(3)] = 'RED' then 'VERMELHO'
                when item[OFFSET(3)] = 'SILVER' then 'PRATA'
                when item[OFFSET(3)] = 'BLUE' then 'AZUL'
                when item[OFFSET(3)] = 'BLACK' then 'PRETO'
                else 'OUTRO'
            end as color
            ,case
                when item[OFFSET(4)] = 'USED' then 'USADO'
                when item[OFFSET(4)] = 'NEW' then 'NOVO'
                when item[OFFSET(4)] = 'SEMI-NEW' then 'SEMI-NOVO'
                else 'OUTRO'
            end as status
            ,item[OFFSET(5)] as price
        from source where occurrences = 5
    )

select * from treated