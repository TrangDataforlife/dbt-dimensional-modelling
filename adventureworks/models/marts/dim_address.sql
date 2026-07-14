WITH stg_country_region as (
    SELECT *
    FROM {{ ref('countryregion') }}
),
stg_state_province as (
    SELECT *
    FROM {{ ref('stateprovince') }}
),
stg_address as (
    SELECT *
    FROM {{ ref('address') }}
)

SELECT 
{{ dbt_utils.generate_surrogate_key(['stg_address.addressid']) }} as address_key,
stg_address.addressid,
stg_address.addressline1,
stg_address.city,
stg_state_province.name as state_province_name,
stg_country_region.name as country_region_name
FROM stg_address a
LEFT JOIN stg_state_province sp
    ON a.stateprovinceid = sp.stateprovinceid
LEFT JOIN stg_country_region cr
    ON sp.countryregioncode = cr.countryregioncode
