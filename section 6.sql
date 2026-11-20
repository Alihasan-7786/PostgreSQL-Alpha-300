-- 1. LIMIT (CONTROLLING THE NUMBER OF ROWS)

-- Getting the first 5 users from the table
SELECT *
FROM users
LIMIT 5;

-- Getting 3 photos uploaded by user with ID 4
SELECT id, url, user_id
FROM photos
WHERE user_id = 4
LIMIT 3;


-- 2. OFFSET (SKIPPING ROWS)

-- Skipping the first 5 users and showing the rest
SELECT *
FROM users
OFFSET 5;


-- 3. USING LIMIT AND OFFSET FOR PAGINATION

-- Keeping the users in ID order while displaying them page by page
-- Showing the first 5 users (point 1)
SELECT id, username
FROM users
ORDER BY id ASC
LIMIT 5 OFFSET 0;

-- Skipping the first 5 users and showing the next 5 (Point 2)
SELECT id, username
FROM users
ORDER BY id ASC
LIMIT 5 OFFSET 5;

-- Skipping the first 10 users and showing the next 5 (Point 3)
SELECT id, username
FROM users
ORDER BY id ASC
LIMIT 5 OFFSET 10;