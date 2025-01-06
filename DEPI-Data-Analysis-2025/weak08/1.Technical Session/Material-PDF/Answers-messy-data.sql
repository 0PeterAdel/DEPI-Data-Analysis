SELECT * 
FROM messy_customer_data;

create view first as
SELECT  email,
country,
address,
REPLACE(customer_name,'Gmbh','GmbH') AS customer_name
FROM messy_customer_data 

create view second as 
SELECT *,
       SUBSTR(SUBSTR(email, INSTR(email, '@') + 1), 1, INSTR(SUBSTR(email, INSTR(email, '@') + 1), '.') - 1) AS email_provider
       ,REPLACE(REPLACE(REPLACE(REPLACE(address, 'str', 'street'), 'Str', 'street'), 'strasse', 'street'), 'Straße', 'street') AS street_clean
FROM second;

create view Third AS
SELECT *,
       IFNULL(NULLIF(address, ''), 'NA') AS address_final,
       IFNULL(NULLIF(country, ''), 'NA') AS country_final,
       IFNULL(NULLIF(email, ''), 'NA') AS email_final
FROM second;

WITH first AS (
    SELECT email,
           country,
           address,
           REPLACE(customer_name, 'Gmbh', 'GmbH') AS customer_name
    FROM messy_customer_data
),
second AS (
    SELECT *,
           SUBSTR(SUBSTR(email, INSTR(email, '@') + 1), 1, INSTR(SUBSTR(email, INSTR(email, '@') + 1), '.') - 1) AS email_provider,
           REPLACE(REPLACE(REPLACE(REPLACE(address, 'str', 'street'), 'Str', 'street'), 'strasse', 'street'), 'Straße', 'street') AS street_clean
    FROM first
),
third AS (
    SELECT *,
           IFNULL(NULLIF(address, ''), 'NA') AS address_final,
           IFNULL(NULLIF(country, ''), 'NA') AS country_final,
           IFNULL(NULLIF(email, ''), 'NA') AS email_final
    FROM second
)
SELECT * 
FROM third;


