-- SECTION 29: OPTIMIZING QUERIES WITH MATERIALIZED VIEWS

-- 1. Grouping posts by week (Lecture 221)
SELECT
    date_trunc('week', created_at) AS week_start,
    COUNT(*) AS post_count
FROM posts
GROUP BY week_start
ORDER BY week_start;


-- 2. Counting posts and likes using a LEFT JOIN (Lecture 222)
-- COUNT(l.id) counts only actual likes and avoids counting empty rows
SELECT
    date_trunc('week', p.created_at) AS week_start,
    COUNT(DISTINCT p.id) AS total_posts,
    COUNT(l.id) AS total_likes
FROM posts p
LEFT JOIN likes l ON l.post_id = p.id
GROUP BY week_start
ORDER BY week_start;


-- 3. Checking weekly activity by counting posts, comments and likes (Lecture 223)
SELECT
    date_trunc('week', COALESCE(p.created_at, c.created_at, l.created_at)) AS week_start,
    COUNT(DISTINCT p.id) AS num_posts,
    COUNT(DISTINCT c.id) AS num_comments,
    COUNT(DISTINCT l.id) AS num_likes
FROM posts p
LEFT JOIN comments c ON c.post_id = p.id
LEFT JOIN likes l ON l.post_id = p.id
GROUP BY week_start
ORDER BY week_start;


-- 4. Creating, viewing, refreshing and deleting a materialized view (Lecture 224)
CREATE MATERIALIZED VIEW weekly_engagement AS
SELECT
    date_trunc('week', p.created_at) AS week_start,
    COUNT(DISTINCT p.id) AS num_posts,
    COUNT(DISTINCT c.id) AS num_comments,
    COUNT(DISTINCT l.id) AS num_likes
FROM posts p
LEFT JOIN comments c ON c.post_id = p.id
LEFT JOIN likes l ON l.post_id = p.id
GROUP BY week_start
ORDER BY week_start;

-- Checking the data stored in the materialized view
SELECT *
FROM weekly_engagement;

-- Updating the stored data after changes in the original tables
REFRESH MATERIALIZED VIEW weekly_engagement;

-- Removing the materialized view if it is not needed
DROP MATERIALIZED VIEW IF EXISTS weekly_engagement;


-- SECTION 30: HANDLING CONCURRENCY AND REVERSIBILITY WITH TRANSACTIONS

-- 5. Starting and committing a transaction (Lectures 226–227)
BEGIN;

UPDATE users
SET bio = 'Updated bio via transaction'
WHERE id = 1;

COMMIT;


-- 6. Starting a transaction and rolling it back (Lecture 227)
BEGIN;

DELETE FROM posts
WHERE id = 1;

-- Undoing the delete before saving the changes
ROLLBACK;


-- 7. Closing a transaction after an error (Lectures 228–229)
BEGIN;

-- This query will fail because the column does not exist
SELECT nonexistent_column FROM users;

-- Queries after an error will fail until we run ROLLBACK:
-- SELECT * FROM users;

-- Rolling back to close the failed transaction
ROLLBACK;