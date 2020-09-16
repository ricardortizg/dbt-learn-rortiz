


with all_orders as (
    select * from {{ ref('stg_orders') }}
),

all_payments as (
    select * from {{ ref('stg_payments') }}

),

valid_payments as (
    select * from all_payments
    where status = 'success'

),

order_payments as (

    select
        all_orders.order_id,
        all_orders.customer_id,
        sum(valid_payments.payment) 
    from all_orders
    left outer join valid_payments
        on all_orders.order_id = valid_payments.order_id
        group by 1, 2
)

select * from order_payments




