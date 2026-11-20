-- 1. SUBQUERIES IN SELECT (SCALAR SUBQUERIES)

-- Getting the highest photo ID along with each photo record
SELECT
    id,
    url,
    (SELECT MAX(id) FROM photos) AS max_photo_id
FROM photos;


-- 2. SUBQUERIES IN FROM (DERIVED TABLES)

-- Finding the average number of comments on each photo
SELECT AVG(comment_count) AS avg_comments_per_photo
FROM (
    SELECT photo_id, COUNT(*) AS comment_count
    FROM comments
    GROUP BY photo_id
) AS photo_comment_counts;

-- Getting the username and comment count for each user
SELECT u.username, c_stats.comment_count
FROM users u
JOIN (
    SELECT user_id, COUNT(*) AS comment_count
    FROM comments
    GROUP BY user_id
) AS c_stats
    ON u.id = c_stats.user_id;


-- 3. SUBQUERIES IN WHERE (IN, ALL, ANY/SOME)

-- Getting users whose IDs are present in the photos table
SELECT id, username
FROM users
WHERE id IN (
    SELECT DISTINCT user_id
    FROM photos
    WHERE user_id IS NOT NULL
);

-- Getting comments with an ID greater than all comment IDs written by user 1
SELECT id, user_id
FROM comments
WHERE id > ALL (
    SELECT id
    FROM comments
    WHERE user_id = 1
);

-- Getting comments with an ID greater than at least one comment ID written by user 1
SELECT id, user_id
FROM comments
WHERE id > ANY (
    SELECT id
    FROM comments
    WHERE user_id = 1
);


-- 4. CORRELATED SUBQUERIES

-- Finding the latest comment written by each user based on the highest comment ID
SELECT c1.id, c1.user_id, c1.contents
FROM comments c1
WHERE c1.id = (
    SELECT MAX(c2.id)
    FROM comments c2
    WHERE c2.user_id = c1.user_id
);

-- Counting comments for each photo using a subquery
SELECT
    p.id AS photo_id,
    p.url,
    (
        SELECT COUNT(*)
        FROM comments c
        WHERE c.photo_id = p.id
    ) AS comment_count
FROM photos p;