with customers as (
    SELECT *
    FROM {{ ref('stg_jaffle_shop__customers') }}
),
orders as (
    SELECT *
    FROM {{ ref('stg_jaffle_shop__orders') }}
),
amount as (
    SELECT customer_id
    ,SUM(amount) as total_spend
    FROM {{ ref('fct_orders')}}
    WHERE {{ ref('fct_orders')}}.status = 'success'
    group by 1
    
),
customer_orders as (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS most_recent_order_date,
        COUNT(order_id) AS number_of_orders
    FROM orders
    GROUP BY customer_id
),
final as (
    SELECT 
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        customer_orders.number_of_orders as number_of_orders,
        amount.total_spend

    FROM customers
    LEFT JOIN customer_orders 
    ON customers.customer_id = customer_orders.customer_id
    LEFT JOIN amount
    ON customers.customer_id = amount.customer_id
)
SELECT *
FROM final