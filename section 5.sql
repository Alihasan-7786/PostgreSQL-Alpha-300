-- 1. BASIC AGGREGATE FUNCTIONS

-- Counting the total number of records in the comments table
SELECT COUNT(*) AS total_rows
FROM comments;

-- Counting how many comments have a user_id value
SELECT COUNT(user_id) AS non_null_user_ids
FROM comments;

-- Finding the total, average, smallest and largest ID in the photos table
SELECT
    SUM(id) AS sum_of_ids,
    AVG(id) AS avg_of_ids,
    MIN(id) AS smallest_id,
    MAX(id) AS largest_id
FROM photos;


-- 2. GROUP BY (GROUPING RECORDS)

-- Counting how many comments each user has written
SELECT user_id, COUNT(*) AS comment_count
FROM comments
GROUP BY user_id;

-- Counting comments for each combination of photo_id and user_id
SELECT photo_id, user_id, COUNT(*) AS comments_on_photo_by_user
FROM comments
GROUP BY photo_id, user_id;


-- 3. HAVING (FILTERING GROUPED RECORDS)

-- Finding photos that have more than 2 comments
SELECT photo_id, COUNT(*) AS comment_count
FROM comments
GROUP BY photo_id
HAVING COUNT(*) > 2;

-- First filtering out NULL user IDs, then counting comments for each user
-- Finally showing only users who have written at least 3 comments
SELECT user_id, COUNT(*) AS comment_count
FROM comments
WHERE user_id IS NOT NULL
GROUP BY user_id
HAVING COUNT(*) >= 3;


-- 4. USING AGGREGATE FUNCTIONS WITH JOINS

-- Counting how many comments are present on each photo
SELECT p.id AS photo_id, p.url, COUNT(*) AS num_comments
FROM photos p
JOIN comments c
    ON p.id = c.photo_id
GROUP BY p.id, p.url;

-- Counting the number of comments written by each user, including users with no comments
SELECT u.username, COUNT(c.id) AS num_comments
FROM users u
LEFT JOIN comments c
    ON u.id = c.user_id
GROUP BY u.id, u.username;