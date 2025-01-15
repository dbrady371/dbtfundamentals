with payments as (
    SELECT *
    FROM {{ ref('stg_stripe__payments') }}
)
SELECT
    order_id
    ,sum(amount) as total_amount
FROM
    payments
GROUP BY order_id
having total_amount < 0