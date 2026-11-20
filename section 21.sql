-- 1. Finding the 3 users with the highest IDs (Lectures 178–179)
-- Getting the users with the highest IDs from the users table
SELECT *
FROM users
ORDER BY id DESC
LIMIT 3;


-- 2. Finding posts made by a particular user (Lectures 180–181)
-- Example: getting posts of a user using their ID (e.g., 200) or username
SELECT u.username, p.id AS post_id, p.url, p.caption
FROM users u
JOIN posts p ON p.user_id = u.id
WHERE u.id = 200;


-- 3. Counting likes made by each user (Lectures 182–183)
-- Counting how many likes each user has given
SELECT u.username, COUNT(*) AS like_count
FROM users u
JOIN likes l ON l.user_id = u.id
GROUP BY u.id, u.username
ORDER BY like_count DESC;