{{ config(alias='employees') }}

with
    source as (
        select
            id as employee_id
            ,departament_id
            ,case 
                when departament = 'sales manager' then 'GERENTE DE VENDAS'
                when departament = 'sales coordinator' then 'COORDENADOR DE VENDAS'
                when departament = 'salesman' then 'VENDEDOR'
                when departament = 'operations director' then 'DIRETOR DE OPERAÇÕES'
                when departament = 'sales director' then 'DIRETOR DE VENDAS'
                when departament = 'technical manager' then 'GERENTE TÉCNICO'
                when departament = 'technical' then 'TÉCNICO'
                when departament = 'mecanic' then 'MECÂNICO'
                else 'OUTRO'
            end as departament
            ,company_branches_id
            ,upper(first_name) as first_name
            ,upper(last_name) as last_name
            ,gender
            ,upper(email) as email
        from {{ source('seeds', 'employees') }}
    )

select * from source