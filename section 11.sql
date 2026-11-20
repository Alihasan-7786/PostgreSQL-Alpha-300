-- SECTION 11: UTILITY OPERATORS, KEYWORDS, AND FUNCTIONS

-- Finding the greater value between 30 and twice the product weight
SELECT
    name,
    weight,
    GREATEST(30, 2 * weight)
FROM products;

-- Finding the smaller value between half the product price and 400
SELECT
    name,
    price,
    LEAST(price * 0.5, 400)
FROM products;

-- Categorizing products based on their price
SELECT
    name,
    price,
    CASE
        WHEN price > 600 THEN 'high'
        WHEN price > 300 THEN 'medium'
        ELSE 'cheap'
    END
FROM products;
