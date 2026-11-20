-- DATABASE-SIDE VALIDATION AND CONSTRAINTS

-- 1. NOT NULL & DEFAULT CONSTRAINTS

-- Creating a products table where name and price cannot be NULL and default values are set for price and in_stock
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    in_stock BOOLEAN NOT NULL DEFAULT TRUE
);

-- Updating existing NULL values before applying the NOT NULL constraint
-- UPDATE products SET name = 'Unnamed Product' WHERE name IS NULL;
-- ALTER TABLE products ALTER COLUMN name SET NOT NULL;


-- 2. SINGLE-COLUMN & MULTI-COLUMN UNIQUE CONSTRAINTS

-- Making sure each email is unique and each org_id and member_code combination is different
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    email VARCHAR(150) NOT NULL UNIQUE,
    org_id INTEGER NOT NULL,
    member_code VARCHAR(50) NOT NULL,
    UNIQUE (org_id, member_code)
);

-- Making sure the same user cannot bookmark the same product more than once
CREATE TABLE bookmarks (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    UNIQUE (user_id, product_id)
);


-- 3. CHECK CONSTRAINTS (SINGLE & MULTIPLE COLUMNS)

-- Checking that the title is not empty, price is positive and sale price does not exceed the regular price
CREATE TABLE store_items (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL CHECK (LENGTH(TRIM(title)) > 0),
    price NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    sale_price NUMERIC(10, 2),
    CHECK (sale_price IS NULL OR sale_price <= price)
);

-- Making sure the delivery date is not earlier than the shipping date
CREATE TABLE shipments (
    id SERIAL PRIMARY KEY,
    shipped_at DATE NOT NULL,
    delivered_at DATE,
    CHECK (delivered_at IS NULL OR delivered_at >= shipped_at)
);