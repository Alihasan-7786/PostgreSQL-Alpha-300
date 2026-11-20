-- SECTION 27: RECURSIVE COMMON TABLE EXPRESSIONS

-- 1. Using a recursive CTE to generate a countdown (Lectures 210–211, 213–214)
WITH RECURSIVE countdown(n) AS (
    -- Starting point of the recursion
    SELECT 10 AS n

    UNION ALL

    -- Subtracting 1 each time until the condition is met
    SELECT n - 1
    FROM countdown
    WHERE n > 1
)
SELECT n
FROM countdown;


-- 2. Using a recursive CTE to generate dates (Lectures 212–214)
WITH RECURSIVE dates(day) AS (
    SELECT DATE '2026-01-01' AS day

    UNION ALL

    -- Adding one day each time until the end date
    SELECT (day + INTERVAL '1 day')::date
    FROM dates
    WHERE day < DATE '2026-01-07'
)
SELECT day
FROM dates;


-- SECTION 28: SIMPLIFYING QUERIES WITH VIEWS

-- 3. Finding the most popular users based on their likes (Lectures 215–216)
-- Joining users, posts and likes to count how many likes each user gets
SELECT
    u.id,
    u.username,
    COUNT(l.id) AS like_count
FROM users u
JOIN posts p ON p.user_id = u.id
JOIN likes l ON l.post_id = p.id
GROUP BY u.id, u.username
ORDER BY like_count DESC
LIMIT 10;


-- 4. Creating a view to get the 10 most recent posts (Lecture 217)
CREATE VIEW recent_posts AS
SELECT *
FROM posts
ORDER BY created_at DESC
LIMIT 10;


-- 5. Getting data from the view just like a normal table (Lectures 217–218)
SELECT *
FROM recent_posts;


-- 6. Updating the view to show more details about recent posts (Lecture 219)
CREATE OR REPLACE VIEW recent_posts AS
SELECT
    p.id,
    p.created_at,
    p.url,
    p.caption,
    u.username
FROM posts p
JOIN users u ON u.id = p.user_id
ORDER BY p.created_at DESC
LIMIT 15;


-- 7. Dropping the view when it is no longer needed (Lecture 219)
DROP VIEW IF EXISTS recent_posts;