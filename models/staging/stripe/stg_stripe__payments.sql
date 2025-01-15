SELECT 
    id as payment_id
    ,orderid as order_id
    ,paymentmethod as payment_method
    ,status
    ,amount / 100 as amount
    ,created as created_at
FROM STRIPE.PAYMENT