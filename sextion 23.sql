-- 1. Creating an index (Lecture 192)
-- Creating an index on the username column in the users table
CREATE INDEX users_username_idx ON users (username);


-- 2. Checking query performance using timing and execution plan (Lecture 193)
-- Turning on timing in psql (or checking execution time in pgAdmin)
-- \timing
EXPLAIN ANALYZE
SELECT *
FROM users
WHERE username = 'Alyson14';


-- 3. Checking the indexes already created on a table (Lectures 195–196)
-- This also shows indexes created automatically for PRIMARY KEY and UNIQUE constraints
SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename = 'users';


-- 4. Removing an index when it is no longer needed (Lecture 194)
DROP INDEX IF EXISTS users_username_idx;