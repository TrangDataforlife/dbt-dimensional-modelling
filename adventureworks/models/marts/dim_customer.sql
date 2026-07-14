WITH stg_customer AS (
    SELECT *
    FROM {{ ref('customer') }}
),
stg_person AS (
    SELECT *
    FROM {{ ref('person') }}
),
stg_store AS (
    SELECT *
    FROM {{ ref('store') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['stg_customer.customer_id']) }} as customer_key,
    c.customer_id,
    p.person_id,
    s.store_id,
    s.store_name,
    c.account_number,
    c.customer_type,
    c.full_name,
    c.email_address,
    c.phone
FROM stg_customer AS c
LEFT JOIN stg_person AS p
    ON c.person_id = p.person_id
LEFT JOIN stg_store AS s
    ON c.store_id = s.store_id