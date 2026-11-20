-- 1. BASIC ORDER BY (ASCENDING & DESCENDING)

-- Showing users in alphabetical order by username
SELECT id, username
FROM users
ORDER BY username ASC;

-- Getting the same result without writing ASC
SELECT id, username
FROM users
ORDER BY username;

-- Showing users from the highest ID to the lowest ID
SELECT id, username
FROM users
ORDER BY id DESC;


-- 2. SORTING BY MULTIPLE COLUMNS (TIE-BREAKERS)

-- Sorting photos by user_id first and then by id in descending order
SELECT id, url, user_id
FROM photos
ORDER BY user_id ASC, id DESC;

-- Sorting cities by name first and then by area in descending order
SELECT name, country, area
FROM cities
ORDER BY name ASC, area DESC;


-- 3. SORTING WITH ALIASES, AGGREGATES & LIMIT

-- Counting comments for each user and showing users with the most comments first
SELECT user_id, COUNT(*) AS comment_count
FROM comments
GROUP BY user_id
ORDER BY comment_count DESC;

-- Showing the latest 5 photos based on their ID
SELECT id, url, user_id
FROM photos
ORDER BY id DESC
LIMIT 5;