-- SECTION 25: ADVANCED QUERY TUNING

-- 1. Checking the cost settings used by the query planner (Lectures 201–203)
SHOW seq_page_cost;
SHOW random_page_cost;
SHOW cpu_tuple_cost;
SHOW cpu_index_tuple_cost;
SHOW cpu_operator_cost;


-- 2. Checking startup cost, total cost and child node details (Lectures 204–205)
EXPLAIN ANALYZE
SELECT u.username, COUNT(p.id) AS post_count
FROM users u
LEFT JOIN posts p ON p.user_id = u.id
GROUP BY u.id, u.username
ORDER BY post_count DESC;


-- 3. Checking how indexes are used (Lecture 206)
-- First, check the query plan normally
EXPLAIN ANALYZE
SELECT *
FROM users
WHERE username LIKE 'A%';

-- Turning off sequential scans for this session to test index usage
SET enable_seqscan = off;

EXPLAIN ANALYZE
SELECT *
FROM users
WHERE username LIKE 'A%';

-- Turning sequential scans back on after testing
SET enable_seqscan = on;

-- Another test: changing random_page_cost for this session
SET random_page_cost = 1.1;

EXPLAIN ANALYZE
SELECT *
FROM users
WHERE username LIKE 'A%';

-- Resetting random_page_cost to its default value
RESET random_page_cost;


-- SECTION 26: SIMPLE COMMON TABLE EXPRESSIONS
-- 4. Using a simple CTE to get the latest users and their posts (Lectures 207–209)
WITH popular_users AS (
    SELECT id, username
    FROM users
    ORDER BY id DESC
    LIMIT 10
)
SELECT pu.id, pu.username, p.id AS post_id, p.url, p.caption
FROM popular_users pu
JOIN posts p ON p.user_id = pu.id;


-- 5. Using a CTE to count posts made by each user
WITH user_post_counts AS (
    SELECT user_id, COUNT(*) AS post_count
    FROM posts
    GROUP BY user_id
)
SELECT u.username, COALESCE(upc.post_count, 0) AS post_count
FROM users u
LEFT JOIN user_post_counts upc ON upc.user_id = u.id
ORDER BY post_count DESC, u.id;