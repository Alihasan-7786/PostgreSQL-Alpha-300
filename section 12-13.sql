--  POSTGRESQL COMPLEX DATATYPES

-- Creating a table to practice different numeric data types
CREATE TABLE numeric_examples (
    small_val SMALLINT,
    int_val INTEGER,
    big_val BIGINT,
    exact_price NUMERIC(10, 2),       -- Storing a number with 2 decimal places
    approx_float DOUBLE PRECISION
);

-- Adding some sample values to the numeric columns
INSERT INTO numeric_examples (small_val, int_val, big_val, exact_price, approx_float)
VALUES (100, 50000, 9000000000, 199.99, 3.1415926535);


-- 2. CHARACTER TYPES (CHAR, VARCHAR, TEXT)

-- Creating a table to store text values of different lengths
CREATE TABLE character_examples (
    fixed_code CHAR(4),
    short_label VARCHAR(50),
    long_description TEXT
);

-- Adding sample text values to the table
INSERT INTO character_examples (fixed_code, short_label, long_description)
VALUES ('SQL ', 'PostgreSQL', 'Variable-length text with no fixed character limit.');


-- 3. BOOLEAN TYPE (TRUE / FALSE / NULL)

-- Creating a table to store true, false and NULL values
CREATE TABLE feature_flags (
    id SERIAL PRIMARY KEY,
    is_active BOOLEAN
);

-- Inserting different boolean values into the table
INSERT INTO feature_flags (is_active)
VALUES (TRUE), (FALSE), ('yes'), ('0'), (NULL);


-- 4. DATE, TIME, TIMESTAMP & TIMESTAMPTZ

-- Creating a table to store event dates and times
CREATE TABLE event_schedules (
    id SERIAL PRIMARY KEY,
    event_date DATE,
    start_time TIME,
    created_at TIMESTAMP,
    created_at_tz TIMESTAMPTZ
);

-- Adding an event date and time with its timezone
INSERT INTO event_schedules (event_date, start_time, created_at, created_at_tz)
VALUES (
    '2026-11-20',
    '18:30:00',
    '2026-11-20 18:30:00',
    '2026-11-20 18:30:00+05:30'
);


-- 5. INTERVALS & DATE/TIME ARITHMETIC

-- Checking the current time and calculating different time intervals
SELECT
    NOW() AS current_ts_with_tz,
    NOW() + INTERVAL '7 days' AS one_week_later,
    NOW() - INTERVAL '2 hours 30 minutes' AS two_and_half_hours_ago,
    AGE(TIMESTAMP '2026-12-31', TIMESTAMP '2026-11-20') AS time_remaining;