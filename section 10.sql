-- SECTION 10: SELECTING DISTINCT RECORDS

-- Counting the number of unique phone manufacturers
SELECT COUNT(DISTINCT manufacturer)
FROM phones;

-- Getting all the unique department names from the products table
SELECT DISTINCT department
FROM products;

-- Getting unique combinations of department and price
SELECT DISTINCT department, price
FROM products;

-- Counting the total number of unique departments in the products table
SELECT COUNT(DISTINCT department)
FROM products;