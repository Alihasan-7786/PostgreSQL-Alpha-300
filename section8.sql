-- 1. UNION & UNION ALL (COMBINING ROWS)

-- Combining user IDs from both tables and removing duplicates
SELECT user_id
FROM photo_tags
UNION
SELECT user_id
FROM caption_tags;

-- Combining user IDs from both tables without removing duplicates
SELECT user_id
FROM photo_tags
UNION ALL
SELECT user_id
FROM caption_tags;


-- 2. INTERSECT & EXCEPT (COMPARING SETS)

-- Getting user IDs that are present in both tables
SELECT user_id
FROM photo_tags
INTERSECT
SELECT user_id
FROM caption_tags;

-- Getting user IDs from photo_tags that are not present in caption_tags
SELECT user_id
FROM photo_tags
EXCEPT
SELECT user_id
FROM caption_tags;


-- 3. ORDERING & USING SET RESULTS IN QUERIES

-- Combining user IDs from both tables and sorting them in ascending order
SELECT user_id
FROM photo_tags
UNION ALL
SELECT user_id
FROM caption_tags
ORDER BY user_id ASC;

-- Combining user IDs from both tables, joining with users and counting tags for each user
SELECT u.username, COUNT(*) AS tag_count
FROM (
    SELECT user_id FROM photo_tags
    UNION ALL
    SELECT user_id FROM caption_tags
) AS all_tags
JOIN users u
    ON u.id = all_tags.user_id
GROUP BY u.id, u.username
ORDER BY tag_count DESC;