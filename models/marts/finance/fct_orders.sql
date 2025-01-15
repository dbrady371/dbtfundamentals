SELECT stg_jaffle_shop__orders.order_id
    ,customer_id
    ,amount
    ,stg_stripe__payments.status
FROM stg_jaffle_shop__orders
INNER JOIN stg_stripe__payments
ON stg_jaffle_shop__orders.order_id = stg_stripe__payments.order_id


